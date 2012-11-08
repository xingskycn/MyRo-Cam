//
//  CameraViewController.m
//  MyRo Cam
//
//  Created by atmstudent on 9/25/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

@synthesize StreamImage, videoTogleOutlet, dayNightOutlet;

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)videoTogle:(id)sender {
    [self showStream];
}

- (IBAction)dayNightButton:(id)sender {
    if (dayNightOutlet.selected) {
       [dayNightOutlet setSelected:NO];
    } else {
        [dayNightOutlet setSelected:YES];
    }
    [self showStream];
}

- (void)showStream {
    if (videoTogleOutlet.on) {
        if (dayNightOutlet.selected) {
            
            //night view
            StreamImage.image = [UIImage imageNamed:@"streamNight.png"];
            
        } else {
            
            //day view
            StreamImage.image = [UIImage imageNamed:@"stream.png"];
            
        }
    } else {
        
        StreamImage.image = [UIImage imageNamed:@"noStream.png"];
        
    }
}
@end
