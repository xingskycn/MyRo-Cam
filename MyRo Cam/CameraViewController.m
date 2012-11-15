//
//  CameraViewController.m
//  MyRo Cam
//
//  Created by atmstudent on 9/25/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import "CameraViewController.h"
#import "api.h"

@interface CameraViewController ()

@end

@implementation CameraViewController {
    UISwipeGestureRecognizer *Swipe;
    NSTimer *timer;
    api *apiConnection;
}

@synthesize liveStreamImage;

@synthesize brightnessSlider;
@synthesize camOnOffSwitch;
@synthesize dayNightControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    apiConnection = [[api alloc] init];
    
    // swipe left
    Swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    Swipe.direction = (UISwipeGestureRecognizerDirectionLeft);
    [self.view addGestureRecognizer:Swipe];
    // end swipe left
    
    // swipe right
    Swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    Swipe.direction = (UISwipeGestureRecognizerDirectionRight);
    [self.view addGestureRecognizer:Swipe];
    // end swipe right
    
    // swipe up
    Swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeUp:)];
    Swipe.direction = (UISwipeGestureRecognizerDirectionUp);
    [self.view addGestureRecognizer:Swipe];
    // end swipe up
    
    // swipe down
    Swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeDown:)];
    Swipe.direction = (UISwipeGestureRecognizerDirectionDown);
    [self.view addGestureRecognizer:Swipe];
    // end swipe down
    
    // pinch
    UIPinchGestureRecognizer *Pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [self.view addGestureRecognizer:Pinch];
    // end pinch
    
    if([apiConnection.camOn isEqualToNumber:[NSNumber numberWithBool:YES]])
    {
        [self setCameraOn];
    }
    else
    {
        [self setCameraOff];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setCameraOn
{
    [apiConnection camSetCamOn];
    if(timer == nil)
    {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.05f
                                                 target:self
                                               selector:@selector(loadVideoStream:)
                                               userInfo:nil
                                                repeats:YES];
    }
    
    brightnessSlider.userInteractionEnabled = YES;
    dayNightControl.userInteractionEnabled = YES;
    
}

- (void) setCameraOff
{
    [apiConnection camSetCamOff];
    if(timer != nil)
    {
        [timer invalidate];
        timer = nil;
        
        liveStreamImage.image = [UIImage imageNamed:@"nostream.jpg"];
        
    }
    brightnessSlider.userInteractionEnabled = NO;
    dayNightControl.userInteractionEnabled = NO;
}

- (IBAction)camSwitchChanged:(id)sender {

    NSLog(@"Change Switch");
    if(camOnOffSwitch.on == YES)
    {
        [self setCameraOn];
    }
    else
    {
        [self setCameraOff];
    }
}

- (void)loadVideoStream:(NSTimer *)theTimer
{
    dispatch_queue_t myQueue = dispatch_queue_create("streamLoadThread", NULL);
    
    dispatch_async(myQueue, ^{
        
        UIImage *image = [apiConnection camGetImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if([apiConnection.camOn isEqualToNumber:[NSNumber numberWithBool:YES]])
            {
                liveStreamImage.image = image;
            }
        });
    });
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
- (void)swipeLeft:(id)sender {
    [apiConnection camCommand:@"move" :@"right"];
    NSLog(@"right");
}

- (void)swipeRight:(id)sender {
    [apiConnection camCommand:@"move" :@"left"];
    NSLog(@"left");
}

- (void)swipeUp:(id)sender {
    [apiConnection camCommand:@"move" :@"down"];
    NSLog(@"down");
}

- (void)swipeDown:(id)sender {
    [apiConnection camCommand:@"move" :@"up"];
    NSLog(@"up");
}

- (IBAction)adjustBrightness:(id)sender {
    [apiConnection camSetBrightness:[NSNumber numberWithInt:(int)roundf(brightnessSlider.value)]];
}

- (IBAction)changeDayNight:(id)sender
{
    
    if (dayNightControl.selectedSegmentIndex == 0)
    {
        NSLog(@"Day");
        [apiConnection setCamDayVision:[NSNumber numberWithBool:YES]];
    }
    else
    {
        NSLog(@"night");
        [apiConnection setCamDayVision:[NSNumber numberWithBool:NO]];
    }
}

- (void)pinchAction:(UIPinchGestureRecognizer *)sender {
    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged) {
        double scale = [sender scale];
        if (scale > 1.0) {
            [apiConnection camCommand:@"rzoom" :@"100"];
        } else {
            [apiConnection camCommand:@"rzoom" :@"-100"];
        }
    }
}


//share on twitter, facebook, mail
- (IBAction)share:(id)sender {
    if([apiConnection.camOn isEqualToNumber:[NSNumber numberWithBool:YES]])
    {
        [self shareAction];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Oeps!" message:@"Start eerst de stream om te kunnen delen" delegate:self cancelButtonTitle:@"Annuleren" otherButtonTitles:@"Stream Starten",nil];
        [alertView show];
    }
}
- (void)shareAction
{
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[liveStreamImage.image, @"Aaah wat kijkt hij toch schattig! #wittyworks"] applicationActivities:nil];
    activityViewController.excludedActivityTypes = @[UIActivityTypeCopyToPasteboard, UIActivityTypePostToWeibo, UIActivityTypeAssignToContact];
    [self presentViewController:activityViewController
                       animated:YES completion:nil];
}
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"%d", buttonIndex);
    if (buttonIndex == 1)
    {
        camOnOffSwitch.on = YES;
        [self setCameraOn];
        [self shareAction];
    }
}
//end share on twitter, facebook, mail

@end

