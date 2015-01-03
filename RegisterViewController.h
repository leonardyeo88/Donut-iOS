//
//  RegisterViewController.h
//  Donut
//
//  Created by Leonard Yeo on 19/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *school;
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong, nonatomic) NSMutableArray *schoolArray;

- (IBAction)registerClicked:(id)sender;

@end
