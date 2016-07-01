//
//  ViewController.h
//  BMI Calculator
//
//  Created by Luca on 6/30/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *weightField;
@property (strong, nonatomic) IBOutlet UITextField *heightField;
@property (strong, nonatomic) IBOutlet UITextField *ageField;
@property (strong, nonatomic) IBOutlet UILabel *bmiLabel;
@property (strong, nonatomic) IBOutlet UILabel *bmrLabel;
@property (strong, nonatomic) IBOutlet UILabel *weightLabel;
@property (strong, nonatomic) IBOutlet UILabel *heightLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;
@property (strong, nonatomic) IBOutlet UILabel *unitSystemLabel;
@property (strong, nonatomic) IBOutlet UISwitch *unitSystemSwitch;
@property (strong, nonatomic) IBOutlet UISwitch *genderSwitch;
@property (strong, nonatomic) IBOutlet UILabel *weightToLoseLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *activityPicker;
@property (strong, nonatomic) IBOutlet UILabel *dailyCaloricIntakeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *myImageView; // ?

- (IBAction)calculate:(id)sender;
- (IBAction)unitSystemSwitch:(id)sender;
- (IBAction)genderSwitch:(id)sender;

@end

