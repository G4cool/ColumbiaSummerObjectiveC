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
    
    self.commissionPercentValueField.placeholder = @"Default: 2";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _pickerData = @[@"USD", @"AOA", @"ARS", @"CAD", @"EUR", @"GBP", @"IQD", @"JPY", @"MAD", @"ZMW"];
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
    [self.commissionPercentValueField resignFirstResponder];
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
        if ([self.commissionPercentValueField.text isEqual: @""]) {
            commissionVal = (0.02) * self.homeCurrency.value.floatValue;
        } else {
            commissionVal = (self.commissionPercentValueField.text.floatValue/100) * self.homeCurrency.value.floatValue;
        }
    } else {
        commissionVal = 0.0;
    }
    
    float roundedVal = floorf((self.foreignCurrency.value.floatValue) * 100 + 0.5) / 100;
    float roundedCommissionVal = floorf((commissionVal) * 100 + 0.5) / 100;
    
    self.foreignField.text = [NSString stringWithFormat:@"%.02f", roundedVal];
    self.commissionValueLabel.text = [NSString stringWithFormat:@"Commission value: %.02f", roundedCommissionVal];
    self.totalLabel.text = [NSString stringWithFormat:@"Total: %.02f", (roundedCommissionVal + (floorf((self.homeCurrency.value.floatValue) * 100 + 0.5) / 100))];
}

- (IBAction)foreignFieldChange:(id)sender {
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    self.foreignCurrency.value = [format numberFromString:self.foreignField.text];
    
    [self getRate];
    
    self.homeCurrency.value = [NSNumber numberWithFloat:(self.foreignCurrency.value.floatValue * (1.0/self.rateView))];
    
    float commissionVal = 0.0;
    
    if (self.commissionSwitch.on) {
        if ([self.commissionPercentValueField.text isEqual: @""]) {
            commissionVal = (0.02) * self.foreignCurrency.value.floatValue;
        } else {
            commissionVal = (self.commissionPercentValueField.text.floatValue/100) * self.foreignCurrency.value.floatValue;
        }
    } else {
        commissionVal = 0.0;
    }
    
    float roundedVal = floorf((self.homeCurrency.value.floatValue) * 100 + 0.5) / 100;
    float roundedCommissionVal = floorf((commissionVal) * 100 + 0.5) / 100;
    
    self.homeField.text = [NSString stringWithFormat:@"%.02f", roundedVal];
    self.commissionValueLabel.text = [NSString stringWithFormat:@"Commission value: %.02f", roundedCommissionVal];
    self.totalLabel.text = [NSString stringWithFormat:@"Total: %.02f", (roundedCommissionVal + (floorf((self.foreignCurrency.value.floatValue) * 100 + 0.5) / 100))];
}

- (IBAction)calculate:(id)sender {
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    format.numberStyle = NSNumberFormatterDecimalStyle;
    self.homeCurrency.value = [format numberFromString:self.homeField.text];
    
    [self getRate];
    
    self.foreignCurrency.value = [NSNumber numberWithFloat:(self.homeCurrency.value.floatValue * self.rateView)];
    
    float commissionVal = 0.0;
    
    if (self.commissionSwitch.on) {
        if ([self.commissionPercentValueField.text isEqual: @""]) {
            commissionVal = (0.02) * self.homeCurrency.value.floatValue;
        } else {
            commissionVal = (self.commissionPercentValueField.text.floatValue/100) * self.homeCurrency.value.floatValue;
        }
    } else {
        commissionVal = 0.0;
    }
    
    float roundedVal = floorf((self.foreignCurrency.value.floatValue) * 100 + 0.5) / 100;
    float roundedCommissionVal = floorf((commissionVal) * 100 + 0.5) / 100;
    
    self.foreignField.text = [NSString stringWithFormat:@"%.02f", roundedVal];
    self.commissionValueLabel.text = [NSString stringWithFormat:@"Commission value: %.02f", roundedCommissionVal];
    self.totalLabel.text = [NSString stringWithFormat:@"Total: %.02f", (roundedCommissionVal + (floorf((self.homeCurrency.value.floatValue) * 100 + 0.5) / 100))];
}

- (IBAction)commissionYesNo:(id)sender {
    if (self.commissionSwitch.on) {
        self.commissionLabel.text = @"Commission: Yes";
    } else {
        self.commissionLabel.text = @"Commission: No";
    }
}

@end











