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

{
    NSArray *_pickerData;
}

@end

static Currency* myHomeCurrency = nil;
static Currency* myForeignCurrency = nil;

@implementation ViewController

// Commissions: Use 2.0%

@synthesize homeCurrency;
@synthesize foreignCurrency;
@synthesize exchangeRate;
@synthesize rateView;

+ (Currency*) getHomeCurrency {
    return myHomeCurrency;
}

+ (Currency*) getForeignCurrency {
    return myForeignCurrency;
}

- (void) getRate {
    URLFetcher* f = [[URLFetcher alloc] init];
    [f fetch];
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    NSDictionary* jsonDictionary = [URLFetcher data];
    NSDictionary* queryDictionary = jsonDictionary[@"query"];
    NSDictionary* resultsDictionary = queryDictionary[@"results"];
    NSDictionary* rateDictionary = resultsDictionary[@"rate"];
    NSString* rateResult = rateDictionary[@"Rate"];
    self.exchangeRate.rate = rateResult.floatValue;
    self.rateView = rateResult.floatValue;
    
    self.homeField.placeholder = @"1.00";
    self.foreignField.placeholder = @"1.00";
    
    self.commissionValueField.placeholder = @"Default: 2";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _pickerData = @[@"USD", @"CAD", @"EUR", @"GBP", @"JPY"];
    // Connect data
    self.homeCurrencyPicker.dataSource = self;
    self.homeCurrencyPicker.delegate = self;
    self.foreignCurrencyPicker.dataSource = self;
    self.foreignCurrencyPicker.delegate = self;
    
    self.homeCurrency = [[Currency alloc] init];
    self.foreignCurrency = [[Currency alloc] init];
    self.homeCurrency.alphaCode = @"USD";
    self.foreignCurrency.alphaCode = @"USD";
    self.homeCurrencyLabel.text = self.homeCurrency.alphaCode;
    self.foreignCurrencyLabel.text = self.foreignCurrency.alphaCode;
    myHomeCurrency = self.homeCurrency;
    myForeignCurrency = self.foreignCurrency;
    self.exchangeRate.homeCurrency = self.homeCurrency;
    self.exchangeRate.foreignCurrency = self.foreignCurrency;
    
    [self getRate];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.homeField resignFirstResponder];
    [self.foreignField resignFirstResponder];
    [self.commissionValueField resignFirstResponder];
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}

// Catpure the picker view selection
/*
- (void)pickerViewHome:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"picked home");
    
    self.homeCurrency.alphaCode = _pickerData[row];
    myHomeCurrency = self.homeCurrency;
    self.homeCurrencyLabel.text = self.homeCurrency.alphaCode;
    self.exchangeRate.homeCurrency = self.homeCurrency;
    
    [self getRate];
}

- (void)pickerViewForeign:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"picked foreign");
    
    self.foreignCurrency.alphaCode = _pickerData[row];
    self.foreignCurrencyLabel.text = self.foreignCurrency.alphaCode;
    myForeignCurrency = self.foreignCurrency;
    self.exchangeRate.foreignCurrency = self.foreignCurrency;
    
    [self getRate];
}
*/

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if([pickerView isEqual: self.homeCurrencyPicker]){
        self.homeCurrency.alphaCode = _pickerData[row];
        myHomeCurrency = self.homeCurrency;
        self.homeCurrencyLabel.text = self.homeCurrency.alphaCode;
        self.exchangeRate.homeCurrency = self.homeCurrency;
        
        [self getRate];
    }
    
    if([pickerView isEqual: self.foreignCurrencyPicker]){
        self.foreignCurrency.alphaCode = _pickerData[row];
        self.foreignCurrencyLabel.text = self.foreignCurrency.alphaCode;
        myForeignCurrency = self.foreignCurrency;
        self.exchangeRate.foreignCurrency = self.foreignCurrency;
        
        [self getRate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeFieldChange:(id)sender {
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    self.homeCurrency.value = [format numberFromString:self.homeField.text];
    
    [self getRate];
    
    self.foreignCurrency.value = [NSNumber numberWithFloat:(self.homeCurrency.value.floatValue * self.rateView)];
    
    float commissionVal = 0.0;
    
    if (self.commissionSwitch.on) {
        commissionVal = (self.commissionValueField.text.floatValue/100) * self.foreignCurrency.value.floatValue;
    } else {
        commissionVal = 0.0;
    }
    
    float roundedVal = floorf((self.foreignCurrency.value.floatValue + commissionVal) * 100 + 0.5) / 100;
    
    self.foreignField.text = [NSString stringWithFormat:@"%.02f", roundedVal];
}

- (IBAction)foreignFieldChange:(id)sender {
    NSLog(@"Foreign change");
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    self.foreignCurrency.value = [format numberFromString:self.foreignField.text];
    
    [self getRate];
    
    self.homeCurrency.value = [NSNumber numberWithFloat:(self.foreignCurrency.value.floatValue * (1.0/self.rateView))];
    
    float commissionVal = 0.0;
    
    if (self.commissionSwitch.on) {
        commissionVal = (self.commissionValueField.text.floatValue/100) * self.homeCurrency.value.floatValue;
    } else {
        commissionVal = 0.0;
    }
    
    float roundedVal = floorf((self.homeCurrency.value.floatValue + commissionVal) * 100 + 0.5) / 100;
    
    self.homeField.text = [NSString stringWithFormat:@"%.02f", roundedVal];
}

- (IBAction)calculate:(id)sender {
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    self.homeCurrency.value = [format numberFromString:self.homeField.text];
    
    [self getRate];
    
    self.foreignCurrency.value = [NSNumber numberWithFloat:(self.homeCurrency.value.floatValue * self.rateView)];
    
    float commissionVal = 0.0;
    
    if (self.commissionSwitch.on) {
        commissionVal = (self.commissionValueField.text.floatValue/100) * self.foreignCurrency.value.floatValue;
    } else {
        commissionVal = 0.0;
    }
    
    float roundedVal = floorf((self.foreignCurrency.value.floatValue + commissionVal) * 100 + 0.5) / 100;
    
    self.foreignField.text = [NSString stringWithFormat:@"%.02f", roundedVal];
}

- (IBAction)commissionYesNo:(id)sender {
    if (self.commissionSwitch.on) {
        self.commissionLabel.text = @"Commission: Yes";
    } else {
        self.commissionLabel.text = @"Commission: No";
    }
}

@end











