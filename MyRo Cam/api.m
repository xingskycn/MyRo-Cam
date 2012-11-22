//
//  api.m
//  MyRo Cam
//
//  Created by Stefan on 11/15/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import "api.h"

@implementation api

@synthesize camIp, camAuthHeader, camBrightness, camOn, camDayVision;

- (void)initialize {
    if (camAuthHeader == nil) {
        
        // config
        camIp = @"145.48.128.202";
        NSString *camUsername = @"mad";
        NSString *camPassword = @"bigbrother";
        // end config
        
        camBrightness = [NSNumber numberWithInt:2000];
        camOn = [NSNumber numberWithBool:NO];
        camDayVision = [NSNumber numberWithBool:YES];
        
        NSMutableString *loginString = (NSMutableString*)[@"" stringByAppendingFormat:@"%@:%@", camUsername, camPassword];
        NSData *authData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
        NSString *encodedLoginData = [authData base64Encoding];
        camAuthHeader = [@"Basic " stringByAppendingFormat:@"%@", encodedLoginData];
        
    }
}

- (void)camCommand:(NSString*)parameter:(NSString*)value
{
    [self initialize];
    
    NSLog(@"%@ : %@", parameter, value);
    
    if(camOn)
    {
        dispatch_queue_t myQueue = dispatch_queue_create("moveCamTreath", NULL);
        
        dispatch_async(myQueue, ^{
            
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/axis-cgi/com/ptz.cgi?%@=%@", camIp, parameter, value]];
            
            NSError *myError = nil;
            NSURLResponse *response;
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url
                                                                   cachePolicy: NSURLRequestReloadIgnoringCacheData
                                                               timeoutInterval: 3];
            [request addValue:camAuthHeader forHTTPHeaderField:@"Authorization"];
                        
            [NSURLConnection sendSynchronousRequest: request
                                  returningResponse: &response
                                              error: &myError];
        });
    }
}

- (void)camSetBrightness:(NSNumber *)brightness {
    [self initialize];
    if ([brightness intValue] < [camBrightness intValue] || [brightness intValue] > [camBrightness intValue]) {
        camBrightness = brightness;
        [self camCommand:@"brightness" : [NSString stringWithFormat:@"%@", camBrightness]];
    }
}

- (void)camSetDayVision {
    [self initialize];
    camDayVision = [NSNumber numberWithBool:YES];
}
- (void)camSetNightVision {
    [self initialize];
    camDayVision = [NSNumber numberWithBool:NO];
}

- (void)camSetCamOn {
    [self initialize];
    camOn = [NSNumber numberWithBool:YES];
}
- (void)camSetCamOff {
    [self initialize];
    camOn = [NSNumber numberWithBool:NO];
}

- (UIImage *)camGetImage {
    [self initialize];
    int color = 0;
    if ([camDayVision isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        color = 1;
    }
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
    
    return [UIImage imageWithData:imageData];
}

@end
