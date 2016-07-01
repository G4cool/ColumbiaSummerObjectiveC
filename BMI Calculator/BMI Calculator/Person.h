//
//  Person.h
//  BMI Calculator
//
//  Created by Luca on 6/30/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSNumber* weightInKG;
@property (strong, nonatomic) NSNumber* heightInM;
@property (strong, nonatomic) NSString* gender;
@property (strong, nonatomic) NSNumber* age;
@property (strong, nonatomic) NSString* units;
@property (strong, nonatomic) NSNumber* weightClass;

+(Person*) sharedPersonInstance;
-(NSString*) description;
-(NSNumber*) bmi;
-(NSNumber*) bmr;
-(NSNumber*) weightToChangePerWeek;

@end
