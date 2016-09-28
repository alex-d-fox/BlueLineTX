//  Created by Alex Fox on 6/20/13.
//  Copyright (c) 2013 Alex Fox. All rights reserved.
//

#import "ElectionCodeView.h"
#import "ElectionView.h"

@implementation ElectionCodeView {
    NSArray * categorey;
}

#pragma mark - Class Methods

+ (NSString *)title {
	return @"Election Code";
}


#pragma mark - NSObject

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {}
    return self;
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
	self.title = [[self class] title];
    
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"ElectionCode" ofType:@"plist"];
    categorey = [NSArray arrayWithContentsOfFile:plistPath];
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

    ElectionView *myViewController = [[ElectionView alloc] init];
    NSString *original = [[[categorey objectAtIndex:indexPath.section] objectAtIndex:indexPath.row+1] objectAtIndex:0];
    NSString *trimmed = original;
    [myViewController setValue: trimmed];
     myViewController.title = [[[categorey objectAtIndex:indexPath.section] objectAtIndex:indexPath.row+1] objectAtIndex:1];

    [self.navigationController pushViewController:myViewController animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Categorey";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [[[categorey objectAtIndex:indexPath.section] objectAtIndex:indexPath.row+1] objectAtIndex:1];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[categorey objectAtIndex:section] count]-1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [categorey count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[categorey objectAtIndex:section] objectAtIndex:0];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    
    // Add the label
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0,tableView.bounds.size.width, 30)];
    headerLabel.backgroundColor = [UIColor blackColor];
    headerLabel.numberOfLines = 2;
    headerLabel.font = [UIFont systemFontOfSize:14.0f];
    headerLabel.textColor = [UIColor whiteColor];
    // do whatever headerLabel configuration you want here
    
    headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    [headerView addSubview:headerLabel];
    
    // Return the headerView
    return headerView;
}
@end
