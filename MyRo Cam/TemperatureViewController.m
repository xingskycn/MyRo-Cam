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
@synthesize tableData;

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
    
    [self parseJSON];
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

-(void)parseJSON {
    NSData *dataUrl = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://api.wunderground.com/api/29c3df9966dfd8c1/conditions/q/CA/Goes.json"]];
    NSInputStream *dataInputStream = [[NSInputStream alloc] initWithData:dataUrl];
    [dataInputStream open];
    if (dataInputStream) {
        
        NSError *parseError = nil;
        
        id jsonObject = [NSJSONSerialization JSONObjectWithStream:dataInputStream options:NSJSONReadingAllowFragments error:&parseError];
        if ([jsonObject respondsToSelector:@selector(objectForKey:)]) {
            
        
            NSDictionary *section = [jsonObject objectForKey:@"current_observation"];
            //NSString temp = [NSString stringWithFormat:@" Temperatuur: %s",];
            
           // NSArray *result = [section objectForKey:@"temp_c"];
            
         NSDictionary *section2 = [section objectForKey:@"temp_c"];
            
             
            
            
        }
        

    }
}
@end
