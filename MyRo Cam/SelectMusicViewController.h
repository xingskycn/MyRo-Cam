//
//  SelectMusicViewController.h
//  MyRo Cam
//
//  Created by atmstudent on 9/28/12.
//  Copyright (c) 2012 wittyworx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InvulViewControllerDelegate <NSObject>
-(void) selectingDone: (NSMutableArray *) airport;
@end

@interface SelectMusicViewController : UITableViewController
    {
        id <InvulViewControllerDelegate> delegate;
    
        NSIndexPath *checkedIndexPath;
    
}


@property(nonatomic, strong) id delegate;
@property (nonatomic, retain) NSIndexPath *checkedIndexPath;
- (IBAction)donePressed:(id)sender;

@end
