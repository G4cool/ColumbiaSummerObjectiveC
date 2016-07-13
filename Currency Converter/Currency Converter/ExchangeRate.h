//
//  ExchangeRate.h
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import "Currency.h"

@interface ExchangeRate : NSObject <NSCoding

@property (strong, nonatomic) Currency* home;
@property (strong, nonatomic) Currency* foreign;
@property (strong, nonatomic) NSDate* expiresOn; // expires on
@property (assign, nonatomic) float rate;

-(bool) updateRate;
-(NSString*) exchangeToHome: (NSNumber*) value;
-(NSString*) exchangeToForeign: (NSNumber*) value;
-(void) reverse;
-(NSString*) name;
-(NSString*) description;
-(ExchangeRate*) initWithHome:(Currency*) aHome
                      foreign:(Currency*) aForeign;

@end
