//
//  Completed.h
//  Donut
//
//  Created by Leonard Yeo on 19/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Completed : NSObject

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventHours;

//methods
-(id) initWithEventName: (NSString *) eName andEventHours: (NSString *) eHours;


@end
