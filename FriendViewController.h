//
//  FriendViewController.h
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *json;
@property (nonatomic, strong) NSMutableArray *friendsArray;
@property (strong, nonatomic) IBOutlet UITableView *friendTableView;

#pragma mark = Methods
-(void) retrieveData;

@end
