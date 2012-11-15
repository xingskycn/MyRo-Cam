//
//  Temperature.h
//  TemperaturePrototype
//
//  Created by atmstudent on 10/9/12.
//  Copyright (c) 2012 atmstudent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractTemperature.h"

@interface Temperature : NSObject<AbstractTemperature>
@property(nonatomic, retain) NSNumber *temp;

-(NSNumber *) getTemperature ;

@end
