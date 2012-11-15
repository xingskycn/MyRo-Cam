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

@implementation CameraViewController {
    UISwipeGestureRecognizer *Swipe;
    NSTimer *timer;
    int activeBrightness;
    int color;
}

@synthesize liveStreamImage;

@synthesize camIp, camUsername, camPassword, camAuthHeader, brightnessSlider;
@synthesize camOn;
@synthesize camOnOffSwitch;
@synthesize dayNightControl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    camIp = @"145.48.128.202";
    camUsername = @"mad";
    camPassword = @"bigbrother";
    
    color = 1;
    
    NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", camUsername, camPassword];
    NSData *authData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedLoginData = [authData base64Encoding];
    camAuthHeader = [@"Basic " stringByAppendingFormat:@"%@", encodedLoginData];
    
    activeBrightness = (int)roundf(brightnessSlider.value);
    
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
    
    if(camOn)
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
    camOn = YES;
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
    camOn = NO;
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
    
    if(camOnOffSwitch.on == YES)
    {
        NSLog(@"Camera On");
        [self setCameraOn];
    }
    else
    {
        
        [self setCameraOff];
        NSLog(@"Camera Off");
    }
}

- (void)loadVideoStream:(NSTimer *)theTimer
{
    dispatch_queue_t myQueue = dispatch_queue_create("streamLoadThread", NULL);
    
    dispatch_async(myQueue, ^{
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/axis-cgi/jpg/image.cgi?resolution=CIF&color=%d", camIp, color]];
        NSError *myError = nil;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url
                                                               cachePolicy: NSURLRequestReloadIgnoringCacheData
                                                           timeoutInterval: 3];
        [request addValue:camAuthHeader forHTTPHeaderField:@"Authorization"];
        NSURLResponse *response;
        NSData *imageData = [NSURLConnection
                             sendSynchronousRequest: request
                             returningResponse: &response
                             error: &myError];
        
        UIImage *image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"New Frame");
            if(camOn)
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
    [self camCommand:@"move" :@"right"];
    NSLog(@"right");
}

- (void)swipeRight:(id)sender {
    [self camCommand:@"move" :@"left"];
    NSLog(@"left");
}

- (void)swipeUp:(id)sender {
    [self camCommand:@"move" :@"down"];
    NSLog(@"down");
}

- (void)swipeDown:(id)sender {
    [self camCommand:@"move" :@"up"];
    NSLog(@"up");
}

- (IBAction)adjustBrightness:(id)sender {
    int brightNess = (int)roundf(brightnessSlider.value);
    if (brightNess < activeBrightness || brightNess > activeBrightness) {
        activeBrightness = brightNess;
        NSString *brightnessValue = [NSString stringWithFormat:@"%i", brightNess];
        NSLog(@"Brightness changed to: %@", brightnessValue);
        [self camCommand:@"brightness" :brightnessValue];
    }
}

- (IBAction)changeDayNight:(id)sender
{
    
    if (dayNightControl.selectedSegmentIndex == 0)
    {
        NSLog(@"Day");
        color = 1;    }
    else
    {
        NSLog(@"night");
        color = 0;
    }
}

- (void)pinchAction:(UIPinchGestureRecognizer *)sender {
    if ([sender state] == UIGestureRecognizerStateBegan || [sender state] == UIGestureRecognizerStateChanged) {
        double scale = [sender scale];
        if (scale > 1.0) {
            [self camCommand:@"rzoom" :@"100"];
            NSLog(@"zoom in");
        } else {
            [self camCommand:@"rzoom" :@"-100"];
            NSLog(@"zoom out");
        }
    }
}

- (void)camCommand:(NSString*)parameter:(NSString*)value
{
    if(camOn)
    {
        dispatch_queue_t myQueue = dispatch_queue_create("moveCamTreath", NULL);
        
        dispatch_async(myQueue, ^{
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/axis-cgi/com/ptz.cgi?%@=%@", camIp, parameter, value]];
            NSError *myError = nil;
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url
                                                                   cachePolicy: NSURLRequestReloadIgnoringCacheData
                                                               timeoutInterval: 3];
            [request addValue:camAuthHeader forHTTPHeaderField:@"Authorization"];
            NSURLResponse *response;
            
            
            NSData *returnData = [NSURLConnection
                                  sendSynchronousRequest: request
                                  returningResponse: &response
                                  error: &myError];
        });
    }
}


//share on twitter, facebook, mail
- (IBAction)share:(id)sender {
    if(camOn) {
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

