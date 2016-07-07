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
 
 
 
 
 
 
 1. Make a Recording Object
 2. Set currentRecodring to new Recording
 3. Insert currentRecording into recordingList
 4. Set up recording session
 5. Set up timer to update ProgressView & expire the Recording session (?)
 
 StopButton Pressed
 1. Turn off the timer
 2. Clearn up Recording Session
 3. Set currentRecodring to nil
*/


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.progressBar = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    
    //self.startButton.center = self.view.center;
    //self.stopButton.center = self.view.center;
    self.progressBar.center = self.view.center;
    [self.view addSubview:self.progressBar];
}

- (void)updateUI:(NSTimer *)timer
{
    static int count = 0; count++;
    
    if (count <= 100000000) { // 100000000 works
        self.progressBar.progress = (float)count/100000.0f; // 100000.0f works
    } else {
        [self.myTimer invalidate];
        self.myTimer = nil;
    } 
}

- (void) stopTimer
{
    [self.myTimer invalidate];
    self.myTimer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButton:(id)sender {
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:(1/10) target:self selector:@selector(updateUI:) userInfo:nil repeats:YES]; }

- (IBAction)stopButton:(id)sender {
    //self.myTimer = [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
}
@end











