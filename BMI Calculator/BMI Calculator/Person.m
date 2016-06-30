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

+(Person*) sharedPersonInstance {
    if (secretPerson == nil) {
        secretPerson = [[Person alloc] init];
        secretPerson.heightInM = @1.75;
        secretPerson.weightInKG = @75;
    }
    
    return secretPerson;
}

-(NSString*) description {
    return [NSString stringWithFormat:@"%p %@ %@", self, self.weightInKG, self.heightInM];
}

-(NSNumber*) bmi {
    return [NSNumber numberWithDouble:self.weightInKG.doubleValue/((self.heightInM.doubleValue)*(self.heightInM.doubleValue))];
}

-(NSNumber*) weightClassification: (NSNumber*) bmi {
    NSNumber* weightClass;
    if (bmi.doubleValue < 18.5) {
        weightClass = @1;
    } else if (bmi.doubleValue >= 18.5 && bmi.doubleValue < 25.0) {
        weightClass = @2;
    } else if (bmi.doubleValue >= 25.0 && bmi.doubleValue < 30.0) {
        weightClass = @3;
    } else if (bmi.doubleValue >= 30.0 && bmi.doubleValue < 35.0) {
        weightClass = @4;
    } else if (bmi.doubleValue >= 35.0 && bmi.doubleValue < 39.9) {
        weightClass = @5;
    } else if (bmi.doubleValue >= 40.0) {
        weightClass = @6;
    }
    
    return weightClass;
}

@end













