//
//  testViewController.m
//  Donut
//
//  Created by Leonard Yeo on 12/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "testViewController.h"

@interface testViewController ()

@end

@implementation testViewController
@synthesize testLabel;

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
    NSUserDefaults *fetchDefaults = [NSUserDefaults standardUserDefaults];
    
    // getting an NSString
    NSString *message = [fetchDefaults objectForKey:@"kMessageKey"];
    
    testLabel.text = message;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
