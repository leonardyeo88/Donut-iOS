//
//  MyRecordViewController.h
//  Donut
//
//  Created by Leonard Yeo on 15/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyRecordViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *json;
@property (nonatomic, strong) NSMutableArray *recordsArray;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *eventHourlabel;
@property (weak, nonatomic) IBOutlet UILabel *eventNumberlabel;

#pragma mark = Methods
-(void) retrieveData;

@end
