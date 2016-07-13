//
//  ExchangeRate.h
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Currency.h"

@interface ExchangeRate : NSObject <NSCoding>

@property (strong, nonatomic) Currency* homeCurrency;
@property (strong, nonatomic) Currency* foreignCurrency;
@property (strong, nonatomic) NSDate* expiresOn; // expires on
@property (assign, nonatomic) float rate;

-(bool) updateRate;
-(NSString*) exchangeToHome: (NSNumber*) value;
-(NSString*) exchangeToForeign: (NSNumber*) value;
-(void) reverse;
-(NSString*) name;
-(NSString*) description;
-(ExchangeRate*) initWithHomeCurrency:(Currency*) aHome
                      foreignCurrency:(Currency*) aForeign;
-(NSURL*) exchangeRateURL;
+(NSArray*) allExchangeRates;

@end
