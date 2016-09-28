//
//  TableViewController.m
//  BlueLineTX
//
//  Created by Alex Fox on 7/18/14.
//  Copyright (c) 2014 Alex Fox. All rights reserved.
//

#import "RootView.h"

static NSString *const kTitleKey = @"title";
static NSString *const kClassesKey =  @"classes";

@interface RootView ()

@end

@implementation RootView {
    NSArray *_viewControllers;
    NSArray *ListArray;
}

+ (NSString *)title {
	return @"BlueLine - Texas Statutes";
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
       ListArray = [NSArray arrayWithObjects:
         @"AgricultureCodeView",
         @"AlcoholicBeveragesCodeView",
         @"AuxWaterLawsView",
         @"BizComCodeView",
         @"BusinessOrgCodeView",
         @"CivilPracticeandRemediesCodeView",
         @"CriminalProcedureCodeView",
         @"ElectionCodeView",
         @"EducationCodeView",
         @"EstatesCodeView",
         @"FamilyCodeView",
         @"FinanceCodeView",
         @"GovernmentCodeView",
         @"HealthSafetyCodeView",
         @"HumanResourcesCodeView",
         @"InsuranceCodeView",
         @"InsuranceNotCodifiedCodeView",
         @"LaborCodeView",
         @"LocalGovernmentCodeView",
         @"NaturalResourcesCodeView",
         @"OccupationsCodeView",
         @"ParksAndWildlifeCodeView",
         @"PenalCodeView",
         @"PropertyCodeView",
         @"SpecialDistrictLocalLawsCodeView",
         @"TaxCodeView",
         @"TrafficCodeView",
         @"UtilitiesCodeView",
         @"WaterCodeView",
         nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.toolbar.tintColor = [UIColor blackColor];
    
    _viewControllers = [[NSArray alloc] initWithObjects:
						[NSDictionary dictionaryWithObjectsAndKeys:
						 ListArray, kClassesKey,
						 @"", kTitleKey,
						 nil],
						nil];
    self.title = [[self class] title];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
		return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
	}
	return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_viewControllers count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger myint;

    myint = [[[_viewControllers objectAtIndex:section] objectForKey:kClassesKey] count];
    
    return  myint;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];    }

    Class klass = [[NSBundle mainBundle] classNamed:[[[_viewControllers objectAtIndex:indexPath.section] objectForKey:kClassesKey] objectAtIndex:indexPath.row]];
    cell.textLabel.text = [klass title];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return [[_viewControllers objectAtIndex:section] objectForKey:kTitleKey];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class klass = [[NSBundle mainBundle] classNamed:[[[_viewControllers objectAtIndex:indexPath.section] objectForKey:kClassesKey] objectAtIndex:indexPath.row]];
    UIViewController *myviewcontroller = [[klass alloc] init];
    [self.navigationController pushViewController:myviewcontroller animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadInputViews];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

@end
