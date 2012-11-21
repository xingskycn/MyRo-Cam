//
//  TemperatureViewController.h
//  MyRo Cam
//
//  Created by atmstudent on 11/9/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemperatureViewController : UIViewController{
       NSArray *tableData;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTemperature;
@property (nonatomic, retain) NSArray *tableData;

-(void) parseJSON;

@end
