//
//  AppDelegate.m
//  Test
//
//  Created by Alex Fox on 6/20/13.
//  Copyright (c) 2013 Alex Fox. All rights reserved.
//

#import "AppDelegate.h"
#import "RootView.h"


@implementation AppDelegate {
    UIWindow *_window;
	UINavigationController *_navigationController;
}

@synthesize window = _window;
@synthesize navigationController = _navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    sleep(1);
    // start of your application:didFinishLaunchingWithOptions // ...
//    [TestFlight takeOff:@"392170f8-214f-43cb-b7c1-d3e67c128770"];
    // The rest of your application:didFinishLaunchingWithOptions method// ...
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    RootView *viewController = [[RootView alloc] init];
	UINavigationController *aNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
	self.navigationController = aNavigationController;
    [_window setRootViewController:aNavigationController];
    [_window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
