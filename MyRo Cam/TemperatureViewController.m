//
//  TemperatureViewController.m
//  MyRo Cam
//
//  Created by atmstudent on 11/9/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import "TemperatureViewController.h"
#import "Temperature.h"

@interface TemperatureViewController ()

@end

@implementation TemperatureViewController

@synthesize lblTemperature;

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
    Temperature *temp = [[Temperature alloc] init];
    
    lblTemperature.text = [NSString stringWithFormat:@"Temperature: %f",temp.getTemperature];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setLblTemperature:nil];
    [super viewDidUnload];
}
@end
