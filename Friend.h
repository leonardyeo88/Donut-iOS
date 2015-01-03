//
//  Friend.h
//  Donut
//
//  Created by Leonard Yeo on 14/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property (nonatomic, strong) NSString *friendName;
@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventDate;
@property (nonatomic, strong) NSString *eventStartTime;
@property (nonatomic, strong) NSString *eventEndTime;

//methods
-(id) initWithFriendName: (NSString *) fName andEventName: (NSString *) eName andEventDate: (NSString *) eDate andEventStartTime: (NSString *) eStartTime andEventEndTime: (NSString *) eEndTime;

@end
