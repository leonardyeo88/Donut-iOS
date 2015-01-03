//
//  EventDetailViewController.h
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventDetailViewController : UIViewController

@property (strong, nonatomic) NSString *etitleDetail;
@property (strong, nonatomic) NSString *edateDetail;
@property (strong, nonatomic) NSString *evenueDetail;
@property (strong, nonatomic) NSString *edescriptionDetail;
@property (strong, nonatomic) NSString *estartTimeDetail;
@property (strong, nonatomic) NSString *eendTimeDetail;
@property (strong, nonatomic) NSString *eUserIDDetail;
@property (strong, nonatomic) NSString *eIDDetail;


@property (strong, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventDateLabel;
@property (strong, nonatomic) IBOutlet UITextView *eventVenueLabel;
@property (strong, nonatomic) IBOutlet UITextView *eventDescriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventStartTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *eventEndTimeLabel;

- (IBAction)volunteerClicked:(id)sender;

@end
