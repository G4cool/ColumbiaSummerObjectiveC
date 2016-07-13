//
//  Currency.h
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currency : NSObject <NSCoding>

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* alphaCode; // USD, CAD, etc.
@property (strong, nonatomic) NSString* symbol;
@property (strong, nonatomic) NSNumber* decimalPlaces;
@property (strong, nonatomic) NSNumberFormatter* formatter;
@property (strong, nonatomic) NSNumber* value;
-(Currency*) initWithName:(NSString*) aName
                alphaCode:(NSString*) aCode
                   symbol:(NSString*) aSymbol
            decimalPlaces:(NSNumber*) places;

@end
