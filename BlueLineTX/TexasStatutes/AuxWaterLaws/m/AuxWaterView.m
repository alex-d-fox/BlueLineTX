//  Created by Alex Fox on 6/20/13.
//  Copyright (c) 2013 Alex Fox. All rights reserved.
//

#import "AuxWaterView.h"
#import "SearchWebView.h"

@implementation AuxWaterView {
    UIWebView *webView;
    NSInteger y;
    NSString * oldText;
    NSString * oldTitle;
}

#pragma mark - Class Methods

#pragma mark - NSObject

- (id)init {
	return self = [super initWithStyle:UITableViewStyleGrouped];
}
    
#pragma mark - UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    BOOL areAdsRemoved = [[NSUserDefaults standardUserDefaults] boolForKey:@"areAddsRemoved"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    //this will load wether or not they bought the in-app purchase
    
    if(!areAdsRemoved){
        self.canDisplayBannerAds = YES;
    }
}

-(void)setValue:(NSString*)string {
    value=string;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    CGRect screenBounds = self.view.bounds;
    CGFloat screenWidth = screenBounds.size.width;
    CGFloat screenHeight = screenBounds.size.height;
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 35, screenWidth, screenHeight - 35)];
    NSString * myString = [[NSString alloc] initWithFormat:@"wl.%@", value];
    NSURL *targetURL = [[NSBundle mainBundle] URLForResource:myString withExtension:@"htm"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    //    webView.scalesPageToFit=YES;
    [webView loadRequest:request];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 35)] ;
    searchBar.backgroundImage = [[UIImage alloc] init];
    searchBar.delegate =self;
    UIView * parentView = [[UIView alloc] initWithFrame:screenBounds];
    parentView.backgroundColor = [UIColor whiteColor];
    [parentView addSubview:searchBar];
        [parentView addSubview:webView];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    parentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.tableView addSubview:parentView];
	[self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - search

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([oldText isEqual: nil]) {
        if (y > 0) {
            oldText = searchBar.text;
            [webView highlightAllOccurencesOfString:searchBar.text];
            NSString *nextSearch = [NSString stringWithFormat:@"scrollTo('%li')",(long)y];
            [webView stringByEvaluatingJavaScriptFromString:nextSearch];
            y--;
        }
        else {
            oldText = searchBar.text;
            y = [webView highlightAllOccurencesOfString:searchBar.text];
            [webView highlightAllOccurencesOfString:searchBar.text];
            NSString *nextSearch = [NSString stringWithFormat:@"scrollTo('%li')",(long)y];
            [webView stringByEvaluatingJavaScriptFromString:nextSearch];
            y--;
        }
    }
    else if (![oldText isEqual:searchBar.text]) {
        oldText = searchBar.text;
        y = [webView highlightAllOccurencesOfString:searchBar.text];
        NSString *nextSearch = [NSString stringWithFormat:@"scrollTo('%li')",(long)y];
        [webView stringByEvaluatingJavaScriptFromString:nextSearch];
        y--;
    }
    else if ([oldText isEqual:searchBar.text]) {
        if (y > 0) {
            NSString *nextSearch = [NSString stringWithFormat:@"scrollTo('%li')",(long)y];
            [webView stringByEvaluatingJavaScriptFromString:nextSearch];
            y--;
        }
        else {
            y = [webView highlightAllOccurencesOfString:searchBar.text];
            [webView highlightAllOccurencesOfString:searchBar.text];
            NSString *nextSearch = [NSString stringWithFormat:@"scrollTo('%li')",(long)y];
            [webView stringByEvaluatingJavaScriptFromString:nextSearch];
            y--;
        }
    }
    [searchBar endEditing:YES];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
}

@end
