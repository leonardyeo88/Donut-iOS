//
//  EventViewController.h
//  Donut
//
//  Created by Leonard Yeo on 11/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic, strong) NSMutableArray *json;
@property (nonatomic, strong) NSMutableArray *eventsArray;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

#pragma mark = Methods
-(void) retrieveData;

@end
