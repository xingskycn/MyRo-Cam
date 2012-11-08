//
//  SelectMusicViewController.m
//  MyRo Cam
//
//  Created by atmstudent on 9/28/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import "SelectMusicViewController.h"
#import "Track.h"
#import "TrackCell.h"

@interface SelectMusicViewController ()

@end

@implementation SelectMusicViewController
{
    NSMutableArray *musicLibrary;
    NSMutableArray *selectedIndexPaths;
    NSMutableArray *selectedIndexes;
}

@synthesize delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    selectedIndexPaths = [[NSMutableArray alloc]init];
    selectedIndexes = [[NSMutableArray alloc] init];

    musicLibrary = [[NSMutableArray alloc] init];
    
    Track *track = [[Track alloc]init];
    track.title = @"Stop";
    track.artist = @"Kinderen voor kinderen";
    track.duration = @"1.4";    
    [musicLibrary addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"Tietenlied";
    track.artist = @"Kinderen voor kinderen";
    track.duration = @"1.4";
    [musicLibrary addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"Zusje van me zus";
    track.artist = @"Kinderen voor kinderen";
    track.duration = @"1.4";
    [musicLibrary addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"Een nieuwe jas";
    track.artist = @"Kinderen voor kinderen";
    track.duration = @"1.4";
    [musicLibrary addObject:track];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [musicLibrary count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectMusicCell";
    
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSInteger row = indexPath.row;
    Track *track = [musicLibrary objectAtIndex:row];
    cell.titleLabel.text = track.title;
    cell.artistLabel.text = track.artist;
    cell.durationLabel.text = track.duration;
    
    
    if([self.checkedIndexPath isEqual:indexPath]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    /*NSUInteger selectedIndex = [musicLibrary indexOfObject:track];
    if(indexPath.row == ){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }*/
    
    // Configure the cell...
    
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //NSUInteger selectedIndex = [musicLibrary indexOfObject:track];
    //static NSString *CellIdentifier = @"SelectMusicCell";
    //TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    //NSString *keyString = [NSString stringWithFormat:@"%d", indexPath.row];
    

    /*
     
    //werkt goed voor 1 cell
     
    if(self.checkedIndexPath)
    {
        UITableViewCell *uncheckCell = [tableView cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if([self.checkedIndexPath isEqual:indexPath]){
        self.checkedIndexPath = nil;
    }
    else
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.checkedIndexPath = indexPath;
    }*/

    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */

    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [selectedIndexes addObject:[NSNumber numberWithInt:indexPath.row]];
        
    }
    else {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
        [selectedIndexes removeObject:[NSNumber numberWithInt:indexPath.row]];
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

- (IBAction)donePressed:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
    [[self delegate] selectingDone: selectedIndexes];
}
@end
