//
//  Friend.m
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "Friend.h"

@implementation Friend
@synthesize eventName, eventEndTime, eventStartTime, eventDate, friendName;

-(id) initWithFriendName: (NSString *) fName andEventName: (NSString *) eName andEventDate: (NSString *) eDate andEventStartTime: (NSString *) eStartTime andEventEndTime: (NSString *) eEndTime
{
    self = [super init];
    if(self){
        eventName = eName;
        eventDate = eDate;
        eventEndTime = eEndTime;
        eventStartTime = eStartTime;
        friendName = fName;
    }
    
    return self;
}

@end
