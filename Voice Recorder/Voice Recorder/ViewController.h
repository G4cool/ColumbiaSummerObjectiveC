//
//  ViewController.h
//  Voice Recorder
//
//  Created by Luca on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIProgressView *progressBar;
@property (nonatomic, strong) NSTimer *myTimer;

- (IBAction)startButton:(id)sender;
- (IBAction)stopButton:(id)sender;

@end

