//
//  ViewController.m
//  BMI Calculator
//
//  Created by Luca on 6/30/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = RGB(233, 233, 233);
    self.bmiLabel.textAlignment = NSTextAlignmentCenter;
    //CGRect frameView = self.view.frame;
    //CGRect frame = self.bmiLabel.frame;
    //frame.origin.x = frameView.origin.x/2;
    //frame.origin.y = frameView.origin.y/2;
    //CGFloat selfHeight = self.view.bounds.size.height;
    //CGFloat selfWidth = self.view.bounds.size.width;
    //CGFloat boxHeight=box.bounds.size.height;
    //CGFloat boxWidth=box.bounds.size.width;
    //NSLog(@"%f", selfWidth);
    //NSLog(@"%f", selfHeight);
    //frame.origin.y = self.view.bounds.size.height/2;
    //frame.origin.x = self.view.bounds.size.width/2;
    //frame.origin.y = [[UIScreen mainScreen] bounds].size.height/2;
    //frame.origin.x = [[UIScreen mainScreen] bounds].size.width/2;
    //self.bmiLabel.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculate:(id)sender {
    Person* p = [Person sharedPersonInstance];
    p.heightInM = [NSNumber numberWithDouble:self.heightField.text.doubleValue];
    p.weightInKG = [NSNumber numberWithDouble:self.weightField.text.doubleValue];
    self.bmiLabel.text = p.bmi.stringValue;
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.weightField resignFirstResponder];
    [self.heightField resignFirstResponder];
}

@end
