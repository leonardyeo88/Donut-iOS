//
//  AppDelegate.m
//  Donut
//
//  Created by Leonard Yeo on 10/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "AppDelegate.h"
#import "EventViewController.h"
#import "ViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    /*NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    BOOL isAccepted = [standardUserDefaults boolForKey:@"userid"];
    
    if (isAccepted == NO) {
        //[self presentViewController:ViewController animated:YES completion:nil];
    } else {
        //[standardUserDefaults setBool:YES forKey:@"userid"];
        //EventViewController *eventController = [[EventViewController alloc]init];
        //[self.navigationController pushViewController:eventController animated:YES];
    }*/
    
    
    UIImage *navbar = [UIImage imageNamed:@"navibarbackground.png"];
    
    
    [[UINavigationBar appearance] setBackgroundImage:navbar forBarMetrics:UIBarMetricsDefault];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:1 green:0.663 blue:0.012 alpha:1]];
    
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:1 green:0.663 blue:0.012 alpha:1], NSForegroundColorAttributeName, [UIColor colorWithRed:1 green:0.663 blue:0.012 alpha:1], NSForegroundColorAttributeName, nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
    
    
    
    /*UIImage* tabBarBackground = [UIImage imageNamed:@"tabbarbackground.png"];
    
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       
                                                       [UIColor whiteColor], NSForegroundColorAttributeName,
                                                       
                                                       nil] forState:UIControlStateNormal];
    
    UIColor *titleHighlightedColor = [UIColor whiteColor];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       
                                                       titleHighlightedColor, NSForegroundColorAttributeName,
                                                       
                                                       nil] forState:UIControlStateHighlighted];
    
    
    
    [[UITabBar appearance] setSelectionIndicatorImage:
     
     [UIImage imageNamed:@"smalltabsbackground.png"]];*/
    
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    // Check user login
    if([[NSUserDefaults standardUserDefaults] valueForKey:@"userid"])
    {
        // So, here user already login then set your root view controller, let's say `SecondViewController``
        EventViewController *secondViewController = [storyBoard instantiateViewControllerWithIdentifier:@"TabBarController"];
        // then set your root view controller
        self.window.rootViewController = secondViewController;
    }
    else
    {
        // It means you need to your root view controller is your login view controller, so let's create it
        ViewController  *loginViewController= [storyBoard instantiateViewControllerWithIdentifier:@"ViewController"];
        self.window.rootViewController = loginViewController;
    }
    
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
