//
//  SavesViewController.m
//  Voice Recorder
//
//  Created by Luca on 7/7/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "SavesViewController.h"
#import "ViewController.h"

@interface SavesViewController ()

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end



@implementation SavesViewController

@synthesize listOfPresidents;

-(SavesViewController*) initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if(self) {
        self.listOfPresidents = [[NSMutableArray alloc] init];
        [self.listOfPresidents addObject:@"Washington"];
        [self.listOfPresidents addObject:@"Licoln"];
        [self.listOfPresidents addObject:@"LBJ"];
    }
    
    return self;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ViewController* pvc = (ViewController*) segue.destinationViewController;
    pvc.otherListOfPresidents = self.listOfPresidents;
}

- (void) viewWillDisappear:(BOOL)animated {
    NSLog(@"Archive my list of recordings to a file!");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.addressLabel.text = [NSString stringWithFormat:@"%p", self];
    NSLog(@"%@", self.listOfPresidents.description);
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
