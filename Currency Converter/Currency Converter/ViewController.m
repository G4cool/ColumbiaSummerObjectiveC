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
 
*/

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)homeFieldChange:(id)sender {
    
}

- (IBAction)foreignFieldChange:(id)sender {
    
}

- (IBAction)usdHomeSelect:(id)sender {
    
}

- (IBAction)cadHomeSelect:(id)sender {
    
}

- (IBAction)usdForeignSelect:(id)sender {
    
}

- (IBAction)cadForeignSelect:(id)sender {
    
}

@end











