//
//  AMViewController.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-9-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMHeader.h"

@interface AMViewController : UIViewController{
    AM3 *tempAM3Instance;
    AM3S *tempAM3SInstance;
    NSInteger tempCloudUserSerialNub;
}

@property (weak, nonatomic) IBOutlet UITextView *tipTextView;

@property (weak, nonatomic) IBOutlet UITextField *randomTextField;

- (IBAction)AM3_ClockQuery:(id)sender;
- (IBAction)AM3_ReminderQuery:(id)sender;
- (IBAction)AM3_Reset:(id)sender;

- (IBAction)AM3S_BinedUser:(id)sender;
- (IBAction)AM3S_ClockQuery:(id)sender;
- (IBAction)AM3S_ReminderQuery:(id)sender;
- (IBAction)AM3S_Reset:(id)sender;
- (IBAction)touchBackgroundPressed:(id)sender;


@end
