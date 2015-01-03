//
//  Event.h
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventVenue;
@property (nonatomic, strong) NSString *eventID;
@property (nonatomic, strong) NSString *eventDate;
@property (nonatomic, strong) NSString *eventStartTime;
@property (nonatomic, strong) NSString *eventEndTime;
@property (nonatomic, strong) NSString *eventPax;
@property (nonatomic, strong) NSString *eventDescription;
@property (nonatomic, strong) NSString *eventOrgURL;

//methods
-(id) initWithEventName: (NSString *) eName andEventVenue: (NSString *) eVenue andEventID: (NSString *) eID andEventDate: (NSString *) eDate andEventStartTime: (NSString *) eStartTime andEventEndTime: (NSString *)eEndTime andEventPax: (NSString *) ePax andEventDescription: (NSString *) eDescription andEventOrgURL: (NSString *) eOrgURL;

@end
