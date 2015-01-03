//
//  Completed.m
//  Donut
//
//  Created by Leonard Yeo on 19/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "Completed.h"

@implementation Completed
@synthesize eventName, eventHours;

-(id) initWithEventName: (NSString *) eName andEventHours: (NSString *) eHours
{
    self = [super init];
    if(self){
        eventName = eName;
        eventHours = eHours;
    }
    
    return self;
}

@end
