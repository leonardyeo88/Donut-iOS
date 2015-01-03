//
//  CompletedViewController.h
//  Donut
//
//  Created by Leonard Yeo on 19/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompletedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *completedTable;
@property (nonatomic, strong) NSMutableArray *json;
@property (nonatomic, strong) NSMutableArray *completedArray;

#pragma mark = Methods
-(void) retrieveData;
@end
