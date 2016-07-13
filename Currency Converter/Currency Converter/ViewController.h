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

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *homeField;
@property (strong, nonatomic) IBOutlet UITextField *foreignField;

- (IBAction)homeFieldChange:(id)sender;
- (IBAction)foreignFieldChange:(id)sender;
- (IBAction)usdHomeSelect:(id)sender;
- (IBAction)cadHomeSelect:(id)sender;
- (IBAction)usdForeignSelect:(id)sender;
- (IBAction)cadForeignSelect:(id)sender;

@end

