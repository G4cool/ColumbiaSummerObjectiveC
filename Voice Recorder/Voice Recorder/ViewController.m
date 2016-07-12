//
//  ViewController.m
//  Voice Recorder
//
//  Created by Luca on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "Recording.h"
#import "TableViewController.h"

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
 1. Turn off the timer for ProgressView
 2. Clearn up Recording Session
 3. Set currentRecodring to nil
 4. Reset ProgressView
 
 didFinish // when timer finishes
 1. Turn off timer for ProgressView
 2. Clean up session
 3. Set currentRecording to nil
 4. Reset ProgressView
*/

@synthesize otherListOfPresidents;
@synthesize listOfRecordings;
@synthesize recorder;
@synthesize currentRecording;

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

//listOfRecordings = [[NSMutableArray alloc]init];

- (NSString *) dateString
{
    // return a formatted string for a file name
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"ddMMMYY_hhmmssa";
    return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".caf"];
}

- (IBAction)startButton:(id)sender {
    NSString* archive = [NSString stringWithFormat:@"/Users/Luca/Desktop/Universal/RecordingsTwo/arrayArchive"];
    /*
     if([[NSFileManager defaultManager] fileExistsAtPath: archive]){
        self.listOfRecordings = [NSKeyedUnarchiver unarchiveObjectWithFile:archive];
        [[NSFileManager defaultManager] removeItemAtPath:archive error:nil];
    }else{
        // Doesn't exist!
        NSLog(@"No file to open!!");
        //exit(1);
    }
     */
    
    listOfRecordings = [[NSMutableArray alloc]init];
        AVAudioSession* audioSession = [AVAudioSession sharedInstance];
        NSError* err = nil;
        [audioSession setCategory: AVAudioSessionCategoryRecord error: &err];
        if(err){
            NSLog(@"audioSession: %@ %ld %@",
                  [err domain], [err code], [[err userInfo] description]);
            return;
        }
        err = nil;
        [audioSession setActive:YES error:&err];
        if(err){
            NSLog(@"audioSession: %@ %ld %@",
                  [err domain], [err code], [[err userInfo] description]);
            return;
        }
        
        NSMutableDictionary* recordingSettings = [[NSMutableDictionary alloc] init];
        
        [recordingSettings setValue:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
        
        [recordingSettings setValue:@44100.0 forKey:AVSampleRateKey];
        
        [recordingSettings setValue:@1 forKey:AVNumberOfChannelsKey];
        
        [recordingSettings setValue:@16 forKey:AVLinearPCMBitDepthKey];
        
        [recordingSettings setValue:@(NO) forKey:AVLinearPCMIsBigEndianKey];
        
        [recordingSettings setValue:@(NO) forKey:AVLinearPCMIsFloatKey];
        
        [recordingSettings setValue:@(AVAudioQualityHigh)
                             forKey:AVEncoderAudioQualityKey];
    
    NSArray *searchPaths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath_ = [searchPaths objectAtIndex: 0];
    
    NSString *pathToSave = [documentPath_ stringByAppendingPathComponent:[self dateString]];
    
    // File URL
    NSURL *url = [NSURL fileURLWithPath:pathToSave];//FILEPATH];
    
        
        NSDate* now = [NSDate date];
        
        self.currentRecording = [[Recording alloc] initWithDate: now];
        //[self.listOfRecordings addObject: self.currentRecording];
    
    //NSString* archive = [NSString stringWithFormat:@"%@/Documents/arrayArchive", NSHomeDirectory()];
    //archive = [NSString stringWithFormat:@"/Users/Luca/Desktop/Universal/RecordingsTwo/arrayArchive"];
    
    //self.currentRecording.path = archive;
        
        NSLog(@"%@",self.currentRecording);
        
        err = nil;
        
        /*self.recorder = [[AVAudioRecorder alloc]
                         initWithURL:self.currentRecording.url
                         settings:recordingSettings
                         error:&err];*/
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordingSettings error:&err];
    //recorder = [[AVAudioRecorder alloc] initWithURL:self.currentRecording.url settings:recordingSettings error:&err];
    
    // Initialize degate, metering, etc.
    recorder.delegate = self;
    recorder.meteringEnabled = YES;
    
        //NSString* filePath = [self.currentRecording.url path];
        //NSLog(@"the url: %@", self.currentRecording.url);
        //[self.listOfRecordings addObject:self.currentRecording.url];
        //NSLog(@"Index: %lu", (unsigned long)[self.listOfRecordings indexOfObject:self.currentRecording.url]);
    //NSUInteger indexThing = [self.listOfRecordings indexOfObject:self.currentRecording.url]; // No pointer
    //NSLog(@"What is here: %@", self.listOfRecordings[indexThing]);
        //NSLog(@"The size: %d", ((sizeof self.currentRecording) / (sizeof self.currentRecording[0])));
        //NSLog(@"the path: %@", filePath);
    //NSLog(@"what is here: %@", self.listOfRecordings[0]);
    //NSLog(@"what is here: %@", [self.listOfRecordings objectAtIndex:0]);
    
        if(!self.recorder){
            NSLog(@"recorder: %@ %ld %@",
                  [err domain], [err code], [[err userInfo] description]);
            UIAlertController* alert = [UIAlertController
                                        alertControllerWithTitle:@"Warning"
                                        message:[err localizedDescription]
                                        preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            return;
        }
        
        // Prepare to record
        //[self.recorder setDelegate:self];
        [self.recorder prepareToRecord];
        self.recorder.meteringEnabled = YES;
        
        BOOL audioHWAvailable = audioSession.inputAvailable;
        if( !audioHWAvailable ){
            UIAlertController* cantRecordAlert = [UIAlertController
                                                  alertControllerWithTitle:@"Warning"
                                                  message:@"Audio input hardware not available."
                                                  preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {}];
            
            [cantRecordAlert addAction:defaultAction];
            [self presentViewController:cantRecordAlert animated:YES completion:nil];
            
            
            return;
        }
        
        // Start recording
        //[self.recorder recordForDuration:(NSTimeInterval)5];
    self.myTimer = [NSTimer scheduledTimerWithTimeInterval:(1/10) target:self selector:@selector(updateUI:) userInfo:nil repeats:YES];
    
    /*
    [NSKeyedArchiver archiveRootObject: self.listOfRecordings toFile: archive];
    
    assert([[NSFileManager defaultManager] fileExistsAtPath: archive]);
    
    archive = [NSString stringWithFormat:@"%@/Documents/arrayArchive", NSHomeDirectory()];
     */
    
    if([[NSFileManager defaultManager] fileExistsAtPath: archive]){
        listOfRecordings = [NSKeyedUnarchiver unarchiveObjectWithFile:archive];
        [[NSFileManager defaultManager] removeItemAtPath:archive error:nil];
    }else{
        // Doesn't exist!
        NSLog(@"No file to open!!");
        //exit(1);
    }
    
    NSLog(@"listOfRecordings: %@", listOfRecordings);
    
    [listOfRecordings addObject: self.currentRecording];
    
    NSLog(@"listOfRecordings after adding: %@", listOfRecordings);
    
    NSLog(@"The original: %@", self.currentRecording);
    /*for(NSString* s in startingArray){
     NSLog(@"%@", s);
     }*/
    
    /*
    [NSKeyedArchiver archiveRootObject: self.currentRecording toFile: archive];
    
    assert([[NSFileManager defaultManager] fileExistsAtPath: archive]);
    
    archive = [NSString stringWithFormat:@"%@/Documents/arrayArchive", NSHomeDirectory()];
     */
    
    [NSKeyedArchiver archiveRootObject: listOfRecordings toFile: archive];
    
    assert([[NSFileManager defaultManager] fileExistsAtPath: archive]);
    
    //archive = [NSString stringWithFormat:@"/Users/Luca/Desktop/Universal/RecordingsTwo/arrayArchive"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath: archive]){
        listOfRecordings = [NSKeyedUnarchiver unarchiveObjectWithFile:archive];
        [[NSFileManager defaultManager] removeItemAtPath:archive error:nil];
    }else{
        // Doesn't exist!
        NSLog(@"No file to open!!");
        exit(1);
    }
    
    NSLog(@"listOfRecordings again: %@", listOfRecordings);
    
    /*
    Recording *secondRecording;
    if([[NSFileManager defaultManager] fileExistsAtPath: archive]){
        secondRecording = [NSKeyedUnarchiver unarchiveObjectWithFile:archive];
        //[[NSFileManager defaultManager] removeItemAtPath:archive error:nil];
    }else{
        // Doesn't exist!
        NSLog(@"No file to open!!");
        exit(1);
    }
     */

    //NSLog(@"Reopen: %@", secondRecording);
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //NSLog(@"hello from the other side: %@", recordings[0]);
    TableViewController* pvc = (TableViewController*) segue.destinationViewController;
    pvc.recordings = self.listOfRecordings;
    //NSLog(@"hello from the other side: %@", recordings[0]);
}

- (IBAction)stopButton:(id)sender {
    //self.myTimer = [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
    [recorder stop];
    [self performSelectorOnMainThread:@selector(stopTimer) withObject:nil waitUntilDone:YES];
    /*
    Recording* exampleRecording = self.listOfRecordings[0];
    NSString* descriptionOfOne = exampleRecording.description;
    
    NSLog(@"First one in listOfRecordings%@", descriptionOfOne);
     */
}
@end











