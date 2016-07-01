//
//  Person.m
//  BMI Calculator
//
//  Created by Luca on 6/30/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "Person.h"

static Person* secretPerson;

@implementation Person

@synthesize weightInKG;
@synthesize heightInM;
@synthesize gender;
@synthesize age;
@synthesize units;

+(Person*) sharedPersonInstance {
    if (secretPerson == nil) {
        secretPerson = [[Person alloc] init];
        secretPerson.heightInM = @1.75;
        secretPerson.weightInKG = @75;
        secretPerson.gender = @"female";
        secretPerson.age = @26;
        secretPerson.units = @"metric";
    }
    
    return secretPerson;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%p %@ %@", self, self.weightInKG, self.heightInM];
}

-(NSNumber*) bmi {
    return [NSNumber numberWithDouble:self.weightInKG.doubleValue/((self.heightInM.doubleValue)*(self.heightInM.doubleValue))];
}

-(NSNumber*) bmr {
    double bmr;
    if ([self.units isEqual: @"metric"]) {
        if ([self.gender isEqual: @"male"]) {
            bmr = (10 * self.weightInKG.doubleValue) + (6.25 * (self.heightInM.doubleValue * 100)) - (5 * self.age.doubleValue) + 5;
        } else if ([self.gender isEqual: @"female"]) {
            bmr = (10 * self.weightInKG.doubleValue) + (6.25 * (self.heightInM.doubleValue * 100)) - (5 * self.age.doubleValue) - 161;
        }
    } else if ([self.units isEqual: @"imperial"]) {
        // FIX FOR IMPERIAL SYSTEM, CONVERT!!!!!
        if ([self.gender isEqual: @"male"]) {
            //bmr = (10 * self.weightInKG.doubleValue * 2.20462) + (6.25 * (self.heightInM.doubleValue * 100) * 39.3701) - (5 * self.age.doubleValue) + 5;
            bmr = 66 + (6.23 * self.weightInKG.doubleValue * 2.20462) + (12.7 * (self.heightInM.doubleValue * 100) * 39.3701) - (6.8 * self.age.doubleValue);
        } else if ([self.gender isEqual: @"female"]) {
            //bmr = (10 * self.weightInKG.doubleValue * 2.20462) + (6.25 * (self.heightInM.doubleValue * 100) * 39.3701) - (5 * self.age.doubleValue) - 161;
            bmr = 655 + (4.25 * self.weightInKG.doubleValue * 2.20462) + (4.7 * (self.heightInM.doubleValue * 100) * 39.3701) - (4.7 * self.age.doubleValue);
        }
    }
    
    return [NSNumber numberWithDouble:(bmr)];
}

@end













