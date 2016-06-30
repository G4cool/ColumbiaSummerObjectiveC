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
    return self.weightInKG/((self.heightInM.doubleValue)*(self.heightInM.doubleValue));
}

@end
