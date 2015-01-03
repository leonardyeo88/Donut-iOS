//
//  EventCell.h
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *startTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel *endTimeLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageLabel;




@end
