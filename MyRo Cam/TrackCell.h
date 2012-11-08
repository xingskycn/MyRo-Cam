//
//  TrackCell.h
//  MyRo Cam
//
//  Created by atmstudent on 9/28/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *artistLabel;
@property (nonatomic, strong) IBOutlet UILabel *durationLabel;

@end
