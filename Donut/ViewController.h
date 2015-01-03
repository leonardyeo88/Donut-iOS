//
//  ViewController.h
//  Donut
//
//  Created by Leonard Yeo on 10/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPageViewControllerDataSource>

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPass;
- (IBAction)loginClicked:(id)sender;
- (IBAction)tapToCloseKeyboard:(id)sender;
- (IBAction)registerClicked:(id)sender;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageImages;


@end
