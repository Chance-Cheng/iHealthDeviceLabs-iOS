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

- (IBAction)commandUploadHS4MemoryPressed:(id)sender;
- (IBAction)commandUploadHS5MemoryPressed:(id)sender;
- (IBAction)commandDataCloud:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *tipTextView;

@end
