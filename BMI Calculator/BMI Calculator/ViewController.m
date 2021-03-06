//
//  ViewController.m
//  BMI Calculator
//
//  Created by Luca on 6/30/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@interface ViewController ()

{
    NSArray *_pickerData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _pickerData = @[@"Sedentary", @"Lightly active", @"Moderately active", @"Very active", @"Extremely active"];
    // Connect data
    self.activityPicker.dataSource = self;
    self.activityPicker.delegate = self;
    
    self.view.backgroundColor = RGB(233, 233, 233);
    self.bmiLabel.textAlignment = NSTextAlignmentCenter;
    self.bmrLabel.textAlignment = NSTextAlignmentCenter;
    self.weightToLoseLabel.textAlignment = NSTextAlignmentCenter;
    self.dailyCaloricIntakeLabel.textAlignment = NSTextAlignmentCenter;
    self.weightField.placeholder = @"70";
    self.heightField.placeholder = @"1.89";
    self.ageField.placeholder = @"26";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
}

NSString* activityLevelPicked;

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    activityLevelPicked = _pickerData[row];
}

double lbsPlaceholder = 70 * 2.20462;
double inPlacelholder = 1.89 * 39.3701;

- (IBAction)calculate:(id)sender {
    // Sound effect on calculate
    CFBundleRef mainBundle = CFBundleGetMainBundle ();
    
    // Get the URL to the sound file to play.
    CFURLRef soundFileURLRef = CFBundleCopyResourceURL (mainBundle, CFSTR ("Calculate"),CFSTR ("wav"),NULL);
    
    // Create a system sound object representing the sound file
    SystemSoundID soundFileObject;
    AudioServicesCreateSystemSoundID (soundFileURLRef, &soundFileObject);
    AudioServicesPlaySystemSound(soundFileObject);
    
    Person* p = [Person sharedPersonInstance];
    p.heightInM = [NSNumber numberWithDouble:self.heightField.text.doubleValue];
    p.weightInKG = [NSNumber numberWithDouble:self.weightField.text.doubleValue];
    if (self.unitSystemSwitch.on) {
        p.units = @"metric";
    } else {
        p.units = @"imperial";
    }
    if (self.genderSwitch.on) {
        p.gender = @"female";
    } else {
        p.gender = @"male";
    }
    p.age = [NSNumber numberWithDouble:self.ageField.text.doubleValue];
    
    if (self.unitSystemSwitch.on) {
        self.bmiLabel.text = [NSString stringWithFormat:@"BMI: %.02f kg/m^2", p.bmi.doubleValue];
        self.bmrLabel.text = [NSString stringWithFormat:@"BMR: %.02f cal", p.bmr.doubleValue]; // Double check unit
    } else {
        self.bmiLabel.text = [NSString stringWithFormat:@"BMI: %.02f lbs/in^2", p.bmi.doubleValue];
        self.bmrLabel.text = [NSString stringWithFormat:@"BMR: %.02f cal", p.bmr.doubleValue]; // Double check unit
    }
    
    UIImage* newImage;
    NSString* path;
    
    NSBundle *myBundle = [NSBundle mainBundle];
    
    // 1 = underweight, 2 = normal weight, 3 = overweight, 4 = class I obesity, 5 = class II obesity, 6 = class III obesity
    // Should update this so it finds based on image name b/c number correspond!
    if (p.bmi.doubleValue < 18.5) {
        p.weightClass = @1;
        path = [myBundle pathForResource:@"1" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 18.5 && p.bmi.doubleValue < 25.0) {
        p.weightClass = @2;
        path = [myBundle pathForResource:@"2" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 25.0 && p.bmi.doubleValue < 30.0) {
        p.weightClass = @3;
        path = [myBundle pathForResource:@"3" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 30.0 && p.bmi.doubleValue < 35.0) {
        p.weightClass = @4;
        path = [myBundle pathForResource:@"4" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 35.0 && p.bmi.doubleValue < 39.9) {
        p.weightClass = @5;
        path = [myBundle pathForResource:@"5" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    } else if (p.bmi.doubleValue >= 40.0) {
        p.weightClass = @6;
        path = [myBundle pathForResource:@"6" ofType:@".png"];
        newImage = [UIImage imageWithContentsOfFile:path];
    }
    
    if (p.weightClass.integerValue < 2) {
        if ([p.units isEqual: @"metric"]) {
            self.weightToLoseLabel.text = [NSString stringWithFormat:@"Weight to gain per week: %.02f kg", p.weightToChangePerWeek.doubleValue];
        } else if ([p.units isEqual: @"imperial"]) {
            self.weightToLoseLabel.text = [NSString stringWithFormat:@"Weight to gain per week: %.02f lbs", p.weightToChangePerWeek.doubleValue];
        }
    } else if (p.weightClass.integerValue > 2) {
        if ([p.units isEqual: @"metric"]) {
            self.weightToLoseLabel.text = [NSString stringWithFormat:@"Weight to lose per week: %.02f kg", p.weightToChangePerWeek.doubleValue];
        } else if ([p.units isEqual: @"imperial"]) {
            self.weightToLoseLabel.text = [NSString stringWithFormat:@"Weight to lose per week: %.02f lbs", p.weightToChangePerWeek.doubleValue];
        }
    } else {
        self.weightToLoseLabel.text = [NSString stringWithFormat:@"You can keep your weight the same."];
    }
    
    p.activityLevel = activityLevelPicked;
    self.dailyCaloricIntakeLabel.text = [NSString stringWithFormat:@"Avg daily caloric intake: %.02f cal", p.avgDailyCaloricIntake.doubleValue];
    
    self.myImageView.image = newImage;
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.weightField resignFirstResponder];
    [self.heightField resignFirstResponder];
}

- (IBAction)unitSystemSwitch:(id)sender {
    if (self.unitSystemSwitch.on) {
        self.weightLabel.text = @"Weight (kg):";
        self.heightLabel.text = @"Height (m):";
        self.unitSystemLabel.text = @"Unit system: Metric";
        self.weightField.placeholder = @"70";
        self.heightField.placeholder = @"1.89";
    } else {
        self.weightLabel.text = @"Weight (lbs):";
        self.heightLabel.text = @"Height (in):";
        self.unitSystemLabel.text = @"Unit system: Imperial";
        self.weightField.placeholder = [NSString stringWithFormat:@"%f", lbsPlaceholder];
        self.heightField.placeholder = [NSString stringWithFormat:@"%f", inPlacelholder];
    }
}

- (IBAction)genderSwitch:(id)sender {
    if (self.genderSwitch.on) {
        self.genderLabel.text = @"Gender: Female";
    } else {
        self.genderLabel.text = @"Gender: Male";
    }
}

@end









