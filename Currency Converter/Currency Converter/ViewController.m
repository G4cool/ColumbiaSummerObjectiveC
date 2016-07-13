//
//  ViewController.m
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

/*
 Stuff:
 
 @interface ExchangeRate : NSObject <NSCoding>
 
 @property (strong, nonatomic) Currency* home;
 @property (strong, nonatomic) Currency* foreign;
 @property (strong, nonatomic) NSDate* expiresOn; // expires on
 @property (assign, nonatomic) float rate;
 
 -(bool) updateRate;
 @end
 
 
 // Exchange rate object:
 -(NSString*) exchangeToHome: (NSNumber*) value;
 -(NSString*) exchangeToForeign: (NSNumber*) value;
 -(void) reverse;
 -(NSString*) nume;
 -(NSString*) description;
 -(EXchangeRate*) initWithHome:(Currency*) aHome
    foreign: (Currency*) aForeign // ???
 
 // Currency:
 @interface Currency NSObject <NSCoding>
 @property (strong, nonatomic) NSString* name;
 @property (strong, nonatomic) NSString* alphaCode;
 @property (strong, nonatomic) NSString* symbol;
 @property (strong, nonatomic) NSNumberFormatter* formatter;
 -(Currency* initWithName:(NSString*) aName
    alphaCode:(NSString*) aCode
    symbol:(NSString*) aSymbol
    decimalPLaces:(NSNumber*) places;
 
 
 ExchangeRate* exchangeRate = ...; // Exchange rate already allocated and initialized
 NSString* urlString = [NSString stringWithFormat: "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.xchange%20where%20pair%20in%20(%22%@%@%22)&format=json&diagnostics=true&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=", exchangeRate.home.alphaCode, exchangeRate.foreign.alphaCode];
 
*/

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.homeCurrency = [[Currency alloc] init];
    self.foreignCurrency = [[Currency alloc] init];
    //Currency* foreignCurrencyHere = [[Currency alloc] init];
    //ExchangeRate* exchangeRate = [[ExchangeRate alloc]init];
    self.exchangeRate.home = self.homeCurrency;
    self.exchangeRate.foreign = self.foreignCurrency;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeFieldChange:(id)sender {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    self.homeCurrency.value = [f numberFromString:self.homeField.text];
}

- (IBAction)foreignFieldChange:(id)sender {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    self.foreignCurrency.value = [f numberFromString:self.foreignField.text];
}

- (IBAction)usdHomeSelect:(id)sender {
    self.homeCurrency.alphaCode = @"USD";
}

- (IBAction)cadHomeSelect:(id)sender {
    self.homeCurrency.alphaCode = @"CAD";
}

- (IBAction)usdForeignSelect:(id)sender {
    self.foreignCurrency.alphaCode = @"USD";
}

- (IBAction)cadForeignSelect:(id)sender {
    self.foreignCurrency.alphaCode = @"CAD";
}

@end











