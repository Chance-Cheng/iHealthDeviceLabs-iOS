//
//  HSViewController.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-9-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import <UIKit/UIKit.h>


@class User;

@interface HSViewController : UIViewController{
    
    User *currentUser;
}

- (IBAction)commandTestHS3Pressed:(id)sender;
- (IBAction)commandTestHS3TurnONPressed:(id)sender;
- (IBAction)commandTestHS3TurnOFFPressed:(id)sender;

- (IBAction)commandUploadHS4MemoryPressed:(id)sender;
- (IBAction)commandUploadHS5MemoryPressed:(id)sender;
- (IBAction)commandDataCloud:(id)sender;

- (IBAction)bangding:(UIButton *)sender;

- (IBAction)setHS6wifi:(UIButton *)sender;

- (IBAction)unbind:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextView *tipTextView;

@end
