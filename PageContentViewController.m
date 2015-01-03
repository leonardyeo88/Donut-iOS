//
//  PageContentViewController.m
//  Donut
//
//  Created by Leonard Yeo on 15/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "PageContentViewController.h"

@interface PageContentViewController ()


@end

@implementation PageContentViewController


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
    
    self.pageControl.currentPage = self.pageIndex;
    
    self.backgroundImageView.image = [UIImage imageNamed:self.imageFile];
}

-(IBAction)dismiss:(id)sender
{
    // connected to Tap Gesture Recognizer so pageview can be dismissed on last page
    NSUInteger index = _pageIndex;
    
    if (index == 4){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
