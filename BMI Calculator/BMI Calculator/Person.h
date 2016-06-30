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

+(Person*) sharedPersonInstance;
-(NSNumber*) bmi;
-(NSString*) description;

@end
