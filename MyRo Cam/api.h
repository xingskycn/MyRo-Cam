//
//  api.h
//  MyRo Cam
//
//  Created by Stefan on 11/15/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+Additions.h"

@interface api : NSObject


@property (strong, nonatomic) NSString *camIp;
@property (strong, nonatomic) NSString *camAuthHeader;
@property (strong, nonatomic) NSNumber *camBrightness;
@property (strong, nonatomic) NSNumber *camOn;
@property (strong, nonatomic) NSNumber *camDayVision;

- (void)camCommand:(NSString*)parameter:(NSString*)value;

- (void)camSetBrightness:(NSNumber *)brightness;

- (void)camSetDayVision;
- (void)camSetNightVision;

- (void)camSetCamOn;
- (void)camSetCamOff;

- (UIImage *)camGetImage;

@end
