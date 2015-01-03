//
//  FriendCell.h
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FriendCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *friendLabel;
@property (nonatomic, weak) IBOutlet UILabel *eventNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *startTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageLabel;


@end
