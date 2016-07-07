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
    @synthesize path;
    @synthesize url;
    -(Recording*) iniWithDate:(NSDate*) aDate {
        NSLog(@"i got to here");
        if (initialRecording == nil) {
            initialRecording = [[Recording alloc] init];
            initialRecording.date = aDate;
        }
        
        return initialRecording;
    }

    -(NSString*) description {
        return [NSString stringWithFormat:@"%p %@", self, self.date];
    }

    -(NSString*) path {
        NSString* home = NSHomeDirectory();
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString* dateString = [formatter stringFromDate:self.date];
        return [NSString stringWithFormat:@"%@/Documents/%@.caf", home, dateString]; // .caf ==> Core Audio File
    }

    -(NSURL*) url{
        //NSURL *baseURL = [NSURL fileURLWithString:@"%@", path];
        //NSURL *URL = [NSURL URLWithString:@"folder/file.html" relativeToURL:baseURL];
        NSURL *URL = [[NSURL alloc] initWithString:path];
        return [URL absoluteURL];
    }
@end
