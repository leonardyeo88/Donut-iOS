//
//  MyRecordPageViewController.m
//  Donut
//
//  Created by Leonard Yeo on 15/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "MyRecordPageViewController.h"
#import "CompletedViewController.h"
#import "UpcomingViewController.h"
#import "MyRecordViewController.h"

@interface MyRecordPageViewController ()

@end

@implementation MyRecordPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.dataSource = self;
    
    NSDictionary *textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:1 green:0.663 blue:0.012 alpha:1], NSForegroundColorAttributeName, [UIColor colorWithRed:1 green:0.663 blue:0.012 alpha:1], NSForegroundColorAttributeName, nil];
    
    [self setViewControllers:@[[self.storyboard instantiateViewControllerWithIdentifier:@"myrecord"]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textTitleOptions];
    self.navigationItem.title = @"My Record";
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[MyRecordViewController class]]){
        self.navigationItem.title = @"My Record";
        return nil;
    }
    
    if ([viewController isKindOfClass:[UpcomingViewController class]]){
        self.navigationItem.title = @"Upcoming";
        return [self.storyboard instantiateViewControllerWithIdentifier:@"completed"];
        
    }
    
    if ([viewController isKindOfClass:[CompletedViewController class]]){
        self.navigationItem.title = @"Completed";
        return [self.storyboard instantiateViewControllerWithIdentifier:@"myrecord"];
        
    }
    
    return [self.storyboard instantiateViewControllerWithIdentifier:@"myrecord"];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if ([viewController isKindOfClass:[UpcomingViewController class]]){
        self.navigationItem.title = @"Upcoming";
        return nil;
    }
    
    if ([viewController isKindOfClass:[CompletedViewController class]]){
        self.navigationItem.title = @"Completed";
        
        return [self.storyboard instantiateViewControllerWithIdentifier:@"upcoming"];
        
    }
    
    return [self.storyboard instantiateViewControllerWithIdentifier:@"completed"];
}


@end
