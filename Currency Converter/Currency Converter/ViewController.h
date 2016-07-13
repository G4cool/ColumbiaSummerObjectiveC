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

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *homeField;
@property (strong, nonatomic) IBOutlet UITextField *foreignField;

@property (strong, nonatomic) Currency* homeCurrency;
@property (strong, nonatomic) Currency* foreignCurrency;
@property (strong, nonatomic) ExchangeRate* exchangeRate;

- (IBAction)homeFieldChange:(id)sender;
- (IBAction)foreignFieldChange:(id)sender;
- (IBAction)usdHomeSelect:(id)sender;
- (IBAction)cadHomeSelect:(id)sender;
- (IBAction)usdForeignSelect:(id)sender;
- (IBAction)cadForeignSelect:(id)sender;

@end

