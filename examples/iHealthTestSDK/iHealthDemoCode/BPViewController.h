//
//  BPViewController.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-9-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BPHeader.h"

@interface BPViewController : UIViewController
{
    
}

@property (strong, nonatomic) NSString *currentKD926UUIDStr;

@property (weak, nonatomic) IBOutlet UITextView *tipTextView;
@property (strong, nonatomic) IBOutlet UIButton *kd926OfflineDataBtn;
@property (strong, nonatomic) IBOutlet UIButton *kd926EnergyBtn;

-(IBAction)testBattary:(id)sender;

@end
