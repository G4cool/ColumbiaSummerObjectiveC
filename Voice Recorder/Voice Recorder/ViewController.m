//
//  ViewController.m
//  Voice Recorder
//
//  Created by Luca on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


// Recorder class code:
/*
 @interface Recordign NSObject <NSSecureCoding> // ???
    @property (strong, nonatomic) NSDate* date;
    // always save in ~/Documents/yyyyMMddHHmmss
    @property (readonly, nonatomic) NSString* path; // readonly ==> There is no setter (?)
    @property (readonly, nonatomic) NSURL* url; // readonly ==> There is no setter (?)
    -(Recording*) initWithDate:(NSDate*) aDate;
 @end
 
 @implementation Recording
    @synthesize date;
    -(Recording*) iniWithDate:(NSDate*) aDate {
        self = [super init];
        if (self) {
            self.date = aDate;
        }
        return self;
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
        NSURL *URL = [NSURL initWithString:@"%@", path];
        return [URL absoluteURL];
    }
 @end
 
 Recording* r = [[Recording alloc] iniWithDate [NSDate today]];
*/


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
