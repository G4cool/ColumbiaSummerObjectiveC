//
//  Recording.h
//  Voice Recorder
//
//  Created by Luca on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recording : NSObject <NSSecureCoding>
    @property (strong, nonatomic) NSDate* date;
    // Always save in ~/Documents/yyyyMMddHHmmss
    @property (readonly, nonatomic) NSString* path; // readonly ==> There is no setter (?)
    @property (readonly, nonatomic) NSURL* url; // readonly ==> There is no setter (?)
    -(Recording*) initWithDate:(NSDate*) aDate;
@end
