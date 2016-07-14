//
//  ViewController.h
//  Currency Converter
//
//  Created by Luca on 7/13/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Currency.h"
#import "ExchangeRate.h"
#import "URLFetcher.h"

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    Currency* homeCurrencyForTransfer;
    Currency* foreignCurrencyForTransfer;
}

@property (strong, nonatomic) IBOutlet UILabel *homeCurrencyLabel;
@property (strong, nonatomic) IBOutlet UILabel *foreignCurrencyLabel;

@property (strong, nonatomic) IBOutlet UITextField *homeField;
@property (strong, nonatomic) IBOutlet UITextField *foreignField;

@property (strong, nonatomic) IBOutlet UIPickerView *homeCurrencyPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *foreignCurrencyPicker;

@property (strong, nonatomic) Currency* homeCurrency;
@property (strong, nonatomic) Currency* foreignCurrency;
@property (strong, nonatomic) ExchangeRate* exchangeRate;

@property (assign, nonatomic) float rateView;

+ (Currency*) getHomeCurrency;
+ (Currency*) getForeignCurrency;

- (void) getRate;

- (IBAction)homeFieldChange:(id)sender;
- (IBAction)foreignFieldChange:(id)sender;

- (IBAction)calculate:(id)sender;

@end

