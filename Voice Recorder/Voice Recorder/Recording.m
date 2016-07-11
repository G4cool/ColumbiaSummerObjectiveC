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
    @synthesize description;
    @synthesize path;
    @synthesize url;
    -(Recording*) initWithDate:(NSDate*) aDate {
        if (initialRecording == nil) {
            initialRecording = [[Recording alloc] init];
            initialRecording.date = aDate;
        }
        
        return initialRecording;
    }

    -(NSString*) description {
        //NSLog(@"PLEASE");
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        //NSLog(@"The description is %@",[formatter stringFromDate:self.date]);
        return [NSString stringWithFormat:@"%p %@", self, self.date];
    }

    -(NSString*) path {
        NSString* home = NSHomeDirectory();
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString* dateString = [formatter stringFromDate:self.date];
        //NSLog(@"dateString: %@", dateString);
        return [NSString stringWithFormat:@"%@/Documents/%@.caf", home, dateString]; // .caf ==> Core Audio File
    }

    -(NSURL*) url{
        //NSURL *baseURL = [NSURL fileURLWithString:@"%@", path];
        //NSURL *URL = [NSURL URLWithString:@"folder/file.html" relativeToURL:baseURL];
        NSString* home = NSHomeDirectory();
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString* dateString = [formatter stringFromDate:self.date];
       // NSLog(@"dateString: %@", dateString);
        NSString* pathForURL =  [NSString stringWithFormat:@"%@/Documents/%@.caf", home, dateString]; // .caf ==> Core Audio File
        //NSLog(@"url working?");
        //NSLog(@"%@", pathForURL);
        NSURL *URL = [[NSURL alloc] initWithString:pathForURL];
        //NSLog(@"url working?");
        NSString* filePath = [URL path];
        //NSLog(@"the url: %@", URL);
        //NSLog(@"the path: %@", filePath);
        return [URL absoluteURL];
    }
@end
