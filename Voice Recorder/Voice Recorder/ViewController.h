//
//  ViewController.h
//  Voice Recorder
//
//  Created by Luca on 7/6/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic, strong) NSTimer *myTimer;
@property (strong, nonatomic) IBOutlet UIButton *startButton;
@property (strong, nonatomic) IBOutlet UIButton *stopButton;
@property (nonatomic, strong) IBOutlet UIProgressView *progressBar;

- (IBAction)startButton:(id)sender;
- (IBAction)stopButton:(id)sender;

@end

