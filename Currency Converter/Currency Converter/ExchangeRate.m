//
//  ExchangeRate.m
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ExchangeRate.h"
#import "ViewController.h"

@implementation ExchangeRate

@synthesize homeCurrency;
@synthesize foreignCurrency;
@synthesize expiresOn; // expires on
@synthesize rate;

-(ExchangeRate*) initWithHomeCurrency:(Currency *)aHome foreignCurrency:(Currency *)aForeign {
    self.homeCurrency = aHome;
    self.foreignCurrency = aForeign;
    
    return self;
}

-(bool) updateRate {
    // Actually do this
    return YES;
}

-(NSURL*) exchangeRateURL
{
    self.homeCurrency = [ViewController getHomeCurrency];
    self.foreignCurrency = [ViewController getForeignCurrency];
    NSString* urlString = [NSString stringWithFormat: @"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.xchange%%20where%%20pair%%20in%%20(%%22%@%@%%22)&format=json&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys&callback=", self.homeCurrency.alphaCode, self.foreignCurrency.alphaCode];
    return [NSURL URLWithString: urlString];
}

+(NSArray*) allExchangeRates
{
    NSMutableArray* allRates = [[NSMutableArray alloc] init];
    Currency* homeCurrencyForThis = [[Currency alloc] initWithName:@"US Dollar" alphaCode:@"USD" symbol:@"$" decimalPlaces:[NSNumber numberWithInt:2]];
    Currency* foreignCurrencyForThis = [[Currency alloc] initWithName:@"Canadian Dollar" alphaCode:@"CAD" symbol:@"$" decimalPlaces:[NSNumber numberWithInt:2]];
    /*
    Currency* homeCurrencyForThis = [[Currency alloc] init];
    homeCurrencyForThis.name = @"US Dollar";
    homeCurrencyForThis.alphaCode = @"USD";
    homeCurrencyForThis.symbol = @"$";
    homeCurrencyForThis.decimalPlaces = [NSNumber numberWithInt:2];
    Currency* foreignCurrencyForThis = [[Currency alloc] init];
    foreignCurrencyForThis.name = @"US Dollar";
    foreignCurrencyForThis.alphaCode = @"USD";
    foreignCurrencyForThis.symbol = @"$";
    foreignCurrencyForThis.decimalPlaces = [NSNumber numberWithInt:2];
     */
    NSLog(@"before");
    [allRates addObject: [[ExchangeRate alloc] initWithHomeCurrency: homeCurrencyForThis foreignCurrency: foreignCurrencyForThis]];
    NSLog(@"after");
    return (NSArray*)allRates;
}

@end
