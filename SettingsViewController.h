//
//  SettingsViewController.h
//  Donut
//
//  Created by Leonard Yeo on 21/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

- (IBAction)loginClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *feedbackText;
- (IBAction)sendFeebackClicked:(id)sender;

@end
