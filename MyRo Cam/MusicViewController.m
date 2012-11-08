//
//  MusicViewController.m
//  MyRo Cam
//
//  Created by atmstudent on 9/25/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import "MusicViewController.h"
#import "Track.h" 
#import "SelectMusicViewController.h" 
#import "TrackCell.h" 

@interface MusicViewController ()

@end

@implementation MusicViewController {
    NSMutableArray *trackList;
}

@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    trackList = [[NSMutableArray alloc] init];
    
    
    Track *track = [[Track alloc]init];
    track.title = @"ADHD";
    track.artist = @"Kinderen voor kinderen";
    track.duration = @"3.15";

    [trackList addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"Waar zijn die engeltjes";
    track.artist = @"K3";
    track.duration = @"3.61";
    
    [trackList addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"Papa Doe niet zo idioot";
    track.artist = @"Kinderen voor kinderen";
    track.duration = @"2.22";
    
    [trackList addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"Hallo!";
    track.artist = @"Djumbo";
    track.duration = @"3.27";
    
    [trackList addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"In bad";
    track.artist = @"Kabouter plop";
    track.duration = @"3.27";
    
    [trackList addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"Bananenlied";
    track.artist = @"Boswachters";
    track.duration = @"3.27";
    
    [trackList addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"Smurfenlied";
    track.artist = @"Vader Abraham";
    track.duration = @"3.27";
    
    [trackList addObject:track];
    
    track = [[Track alloc]init];
    track.title = @"Regenboog";
    track.artist = @"K3";
    track.duration = @"3.27";
    
    [trackList addObject:track];
    

	// Do any additional setup after loading the view.
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
    //return [trackList count];
    return 7;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   // SelectMusicViewController *ivc = segue.destinationViewController;
    //ivc.delegate = self;
}

-(void) selectingDone:(NSString *)airport
{
    //trackList = airport;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MusicCell";
    TrackCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    NSInteger row = indexPath.row;
    Track *track = [trackList objectAtIndex:row];
    cell.titleLabel.text = track.title;
    cell.artistLabel.text = track.artist;
    cell.durationLabel.text = track.duration;
    // Configure the cell...
    
    return cell;
}

@end
