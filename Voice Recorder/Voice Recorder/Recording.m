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
    @synthesize dateString;
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

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.url = [decoder decodeObjectForKey:@"url"];
    }
    return self;
}

- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".aif"];
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:url forKey:@"url"];
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
