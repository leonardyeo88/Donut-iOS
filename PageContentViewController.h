//
//  PageContentViewController.h
//  Donut
//
//  Created by Leonard Yeo on 15/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController 
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property NSUInteger pageIndex;
@property NSString *imageFile;




@end
