//
//  Event.m
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import "Event.h"

@implementation Event
@synthesize eventName;
@synthesize eventVenue;
@synthesize eventDate;
@synthesize eventDescription;
@synthesize eventEndTime;
@synthesize eventID;
@synthesize eventOrgURL;
@synthesize eventPax;
@synthesize eventStartTime;

-(id) initWithEventName: (NSString *) eName andEventVenue: (NSString *) eVenue andEventID: (NSString *) eID andEventDate: (NSString *) eDate andEventStartTime: (NSString *) eStartTime andEventEndTime: (NSString *)eEndTime andEventPax: (NSString *) ePax andEventDescription: (NSString *) eDescription andEventOrgURL: (NSString *) eOrgURL
{
    self = [super init];
    if(self){
        eventName = eName;
        eventVenue = eVenue;
        eventDate = eDate;
        eventDescription = eDescription;
        eventEndTime = eEndTime;
        eventID = eID;
        eventOrgURL = eOrgURL;
        eventPax = ePax;
        eventStartTime = eStartTime;
        
    }
    
    return self;
}

@end
