//
//  Recording.m
//  Voice Recorder
//
//  Created by Luca on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "Recording.h"

static Recording* initialRecording;

@implementation Recording
    @synthesize date;
    +(Recording*) iniWithDate:(NSDate*) aDate {
        if (initialRecording) {
            initialRecording.date = aDate;
        }
        return initialRecording;
    }

    -(NSString*) path {
        NSString* home = NSHomeDirectory();
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString* dateString = [formatter stringFromDate:self.date];
        return [NSString stringWithFormat:@"%@/Documents/%@.caf", home, dateString]; // .caf ==> Core Audio File
    }

    -(NSURL*) url:(NSString*) path {
        //NSURL *baseURL = [NSURL fileURLWithString:@"%@", path];
        //NSURL *URL = [NSURL URLWithString:@"folder/file.html" relativeToURL:baseURL];
        NSURL *URL = [[NSURL alloc] initWithString:path];
        return [URL absoluteURL];
    }
@end
