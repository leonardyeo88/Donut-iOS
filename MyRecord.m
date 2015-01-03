//
//  MyRecord.m
//  Donut
//
//  Created by Leonard Yeo on 19/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "MyRecord.h"

@implementation MyRecord
@synthesize myName, eventHours,eventCount;

-(id) initWithEventHours: (NSString *) eHours andEventCount: (NSString *) eCount andMyName: (NSString *) name
{
    self = [super init];
    if(self){
        eventHours = eHours;
        eventCount = eCount;
        myName = name;
    }
    
    return self;
}

@end
