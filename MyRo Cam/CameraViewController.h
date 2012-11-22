//
//  CameraViewController.h
//  MyRo Cam
//
//  Created by atmstudent on 9/25/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraViewController : UIViewController<UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *liveStreamImage;

- (IBAction)share:(id)sender;

@property (strong, nonatomic) IBOutlet UISlider *brightnessSlider;
- (IBAction)adjustBrightness:(id)sender;


- (IBAction)camSwitchChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *camOnOffSwitch;

@property (strong, nonatomic) IBOutlet UISegmentedControl *dayNightControl;
- (IBAction)changeDayNight:(id)sender;

@end