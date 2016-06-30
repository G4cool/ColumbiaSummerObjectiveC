//
//  ViewController.m
//  BMI Calculator
//
//  Created by Luca on 6/30/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.bmiLabel.textAlignment = NSTextAlignmentCenter;
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
