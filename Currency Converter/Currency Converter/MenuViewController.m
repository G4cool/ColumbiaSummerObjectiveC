//
//  MenuViewController.m
//  Currency Converter
//
//  Created by Luca on 7/15/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSBundle *myBundle = [NSBundle mainBundle];
    NSString* path = [myBundle pathForResource:@"Currency Converter Menu" ofType:@".png"];
    UIImage* newImage = [UIImage imageWithContentsOfFile:path];
    self.menuImageView.image = newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
