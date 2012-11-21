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

@implementation TemperatureViewController {
    Temperature *temp;
}

@synthesize lblTemperature;
@synthesize tableData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    temp = [[Temperature alloc] init];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    
    
   dispatch_async(queue, ^{
        [self parseJSON];
       
       dispatch_async(dispatch_get_main_queue(), ^{
           lblTemperature.text = [NSString stringWithFormat:@"Temperatuur: %@",[temp getTemperature]];
       });
    
    });
    
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

            
         NSNumber *section2 = [section valueForKey:@"temp_c"];
            
       
    
            
       
           // lblTemperature.text = [NSString stringWithFormat:@"Temperature: %@",section2];

   
            
    //temp.temp = [NSNumber numberWithDouble:12.345];
            temp.temp = section2;
            
        
        }

    }
}
@end
