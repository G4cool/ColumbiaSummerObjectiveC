//
//  TableViewController.m
//  Voice Recorder
//
//  Created by Luca on 7/8/16.
//  Copyright © 2016 Space!, Ink. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"

@interface TableViewController ()

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation TableViewController

@synthesize listOfPresidents;
@synthesize scientists;

/*
-(TableViewController*) initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder: aDecoder];
    if(self) {
        self.listOfPresidents = [[NSMutableArray alloc] init];
        [self.listOfPresidents addObject:@"Washington"];
        [self.listOfPresidents addObject:@"Licoln"];
        [self.listOfPresidents addObject:@"LBJ"];
    }
    
    return self;
}
*/

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.scientists = [[NSMutableArray alloc] init];
        [self.scientists addObject: @"R. Franklin"];
        [self.scientists addObject: @"A. Turing"];
        [self.scientists addObject: @"I. Newton"];
        [self.scientists addObject: @"L. Da Vinci"];
        [self.scientists addObject: @"M. Curie"];
        [self.scientists addObject: @"N. Tesla"];
        [self.scientists addObject: @"S. Hawking"];
        [self.scientists addObject: @"R. Feynmam"];
        [self.scientists addObject: @"A. Einstein"];
        [self.scientists addObject: @"B. Franklin"];
        [self.scientists addObject: @"G. Washington Carver"];
        [self.scientists addObject: @"Euclid"];
        [self.scientists addObject: @"N. Tyson"];
        [self.scientists addObject: @"B. Greene"];
        [self.scientists addObject: @"J. Nash"];
        [self.scientists addObject: @"C. Darwin"];
        [self.scientists addObject: @"Galileo"];
        [self.scientists addObject: @"N. Copernicus"];
        [self.scientists addObject: @"G. Hopper"];
        [self.scientists addObject: @"A. Lovelace"];
        [self.scientists addObject: @"T. Morse"];
        [self.scientists addObject: @"J. Thompson"];
        [self.scientists addObject: @"E. Rutherford"];
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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [self.scientists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.scientists objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Play the audio file that maps onto the cell
    // Recording* r = [sef.recordingsList objectAtIndex: indexPath.row];
    // [self play: r];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES]; // If don't want fade, change animated to NO
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
