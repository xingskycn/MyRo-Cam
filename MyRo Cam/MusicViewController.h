//
//  MusicViewController.h
//  MyRo Cam
//
//  Created by atmstudent on 9/25/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectMusicViewController.h" 

@interface MusicViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, InvulViewControllerDelegate> {
    IBOutlet UITableView *tableView;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;


@end
