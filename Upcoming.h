//
//  Upcoming.h
//  Donut
//
//  Created by Leonard Yeo on 21/2/14.
//  Copyright (c) 2014 kinkypizza. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Upcoming : NSObject

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *eventDate;

//methods
-(id) initWithEventName: (NSString *) eName andEventDate: (NSString *) eDate;

@end
