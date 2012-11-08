//
//  CameraViewController.h
//  MyRo Cam
//
//  Created by atmstudent on 9/25/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *StreamImage;

@property (strong, nonatomic) IBOutlet UISwitch *videoTogleOutlet;
- (IBAction)videoTogle:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *dayNightOutlet;
- (IBAction)dayNightButton:(id)sender;

@end
