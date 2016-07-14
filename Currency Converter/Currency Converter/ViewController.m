//
//  ViewController.m
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ViewController.h"
#import "URLFetcher.h"

@interface ViewController ()

@end

static Currency* myHomeCurrency = nil;
static Currency* myForeignCurrency = nil;

@implementation ViewController

@synthesize homeCurrency;
@synthesize foreignCurrency;
@synthesize exchangeRate;

+ (Currency*) getHomeCurrency {
    return myHomeCurrency;
}

+ (Currency*) getForeignCurrency {
    return myForeignCurrency;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.homeCurrency = [[Currency alloc] init];
    self.foreignCurrency = [[Currency alloc] init];
    self.homeCurrency.alphaCode = @"USD";
    self.foreignCurrency.alphaCode = @"CAD";
    self.homeCurrencyLabel.text = self.homeCurrency.alphaCode;
    self.foreignCurrencyLabel.text = self.foreignCurrency.alphaCode;
    myHomeCurrency = self.homeCurrency;
    myForeignCurrency = self.foreignCurrency;
    self.exchangeRate.homeCurrency = self.homeCurrency;
    self.exchangeRate.foreignCurrency = self.foreignCurrency;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeFieldChange:(id)sender {
    NSLog(@"Home change");
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    self.homeCurrency.value = [format numberFromString:self.homeField.text];
    
    URLFetcher* f = [[URLFetcher alloc] init];
    [f fetch];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    NSDictionary* jsonDictionary = [URLFetcher data];
    NSDictionary* queryDictionary = jsonDictionary[@"query"];
    NSDictionary* resultsDictionary = queryDictionary[@"results"];
    NSDictionary* rateDictionary = resultsDictionary[@"rate"];
    NSString* rateResult = rateDictionary[@"Rate"];
    NSLog(@"rateResult: %@", rateResult);
    self.exchangeRate.rate = rateResult.floatValue;
    
    self.foreignCurrency.value = [NSNumber numberWithFloat:(self.homeCurrency.value.floatValue * rateResult.floatValue)];
    
    self.foreignField.text = [NSString stringWithFormat:@"%f", self.foreignCurrency.value.floatValue];
}

- (IBAction)foreignFieldChange:(id)sender {
    NSLog(@"Foreign change");
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    self.foreignCurrency.value = [format numberFromString:self.foreignField.text];
    
    URLFetcher* f = [[URLFetcher alloc] init];
    [f fetch];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    NSDictionary* jsonDictionary = [URLFetcher data];
    NSDictionary* queryDictionary = jsonDictionary[@"query"];
    NSDictionary* resultsDictionary = queryDictionary[@"results"];
    NSDictionary* rateDictionary = resultsDictionary[@"rate"];
    NSString* rateResult = rateDictionary[@"Rate"];
    NSLog(@"rateResult: %@", rateResult);
    self.exchangeRate.rate = rateResult.floatValue;
    
    self.homeCurrency.value = [NSNumber numberWithFloat:(self.foreignCurrency.value.floatValue * (1.0/rateResult.floatValue))];
    
    self.homeField.text = [NSString stringWithFormat:@"%f", self.homeCurrency.value.floatValue];
}

- (IBAction)usdHomeSelect:(id)sender {
    NSLog(@"Home: USD");
    self.homeCurrency.alphaCode = @"USD";
    myHomeCurrency = self.homeCurrency;
    self.homeCurrencyLabel.text = self.homeCurrency.alphaCode;
    self.exchangeRate.homeCurrency = self.homeCurrency;
}

- (IBAction)cadHomeSelect:(id)sender {
    NSLog(@"Home: CAD");
    self.homeCurrency.alphaCode = @"CAD";
    self.homeCurrencyLabel.text = self.homeCurrency.alphaCode;
    myHomeCurrency = self.homeCurrency;
    self.exchangeRate.homeCurrency = self.homeCurrency;
}

- (IBAction)usdForeignSelect:(id)sender {
    NSLog(@"Foreign: USD");
    self.foreignCurrency.alphaCode = @"USD";
    self.foreignCurrencyLabel.text = self.foreignCurrency.alphaCode;
    myForeignCurrency = self.foreignCurrency;
    self.exchangeRate.foreignCurrency = self.foreignCurrency;
}

- (IBAction)cadForeignSelect:(id)sender {
    NSLog(@"Foreign: CAD");
    self.foreignCurrency.alphaCode = @"CAD";
    self.foreignCurrencyLabel.text = self.foreignCurrency.alphaCode;
    myForeignCurrency = self.foreignCurrency;
    self.exchangeRate.foreignCurrency = self.foreignCurrency;
}

@end











