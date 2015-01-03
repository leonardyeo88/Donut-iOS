//
//  MyRecord.h
//  Donut
//
//  Created by Leonard Yeo on 19/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRecord : NSObject
@property (nonatomic, strong) NSString *myName;
@property (nonatomic, strong) NSString *eventHours;
@property (nonatomic, strong) NSString *eventCount;

//methods
-(id) initWithEventHours: (NSString *) eHours andEventCount: (NSString *) eCount andMyName: (NSString *) name;

@end
