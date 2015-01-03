//
//  UpcomingViewController.h
//  Donut
//
//  Created by Leonard Yeo on 19/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpcomingViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *upcomingTableView;
@property (nonatomic, strong) NSMutableArray *json;
@property (nonatomic, strong) NSMutableArray *upcomingArray;

#pragma mark = Methods
-(void) retrieveData;
@end
