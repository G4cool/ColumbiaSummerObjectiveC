//
//  Currency.m
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "Currency.h"

@implementation Currency

@synthesize name;
@synthesize alphaCode;
@synthesize symbol;
@synthesize decimalPlaces;
@synthesize formatter;
@synthesize value;

-(Currency*) initWithName:(NSString *)aName alphaCode:(NSString *)aCode symbol:(NSString *)aSymbol decimalPlaces:(NSNumber *)places {
    self.name = aName;
    self.alphaCode = aCode;
    self.symbol = aSymbol;
    self.decimalPlaces = places;
    
    return self;
}

@end
