//
//  Upcoming.m
//  Donut
//
//  Created by Leonard Yeo on 21/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "Upcoming.h"

@implementation Upcoming
@synthesize eventName, eventDate;

-(id) initWithEventName: (NSString *) eName andEventDate: (NSString *) eDate
{
    self = [super init];
    if(self){
        eventName = eName;
        eventDate = eDate;
    }
    
    return self;
}

@end
