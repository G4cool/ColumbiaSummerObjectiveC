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

+(Person*) sharedPersonInstance {
    if (secretPerson == nil) {
        secretPerson = [[Person alloc] init];
        secretPerson.heightInM = @1.75;
        secretPerson.weightInKG = @75;
        secretPerson.gender = @"female";
        secretPerson.age = @26;
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
    if ([self.gender isEqual: @"Male"] || [self.gender isEqual: @"male"]) {
        bmr = (10 * self.weightInKG.doubleValue) + (6.25 * (self.heightInM.doubleValue * 100)) - (5 * self.age.doubleValue) + 5;
    } else if ([self.gender isEqual: @"Female"] || [self.gender isEqual: @"female"]) {
        bmr = (10 * self.weightInKG.doubleValue) + (6.25 * (self.heightInM.doubleValue * 100)) - (5 * self.age.doubleValue) - 161;
    }
    
    return [NSNumber numberWithDouble:(bmr)];
}

@end













