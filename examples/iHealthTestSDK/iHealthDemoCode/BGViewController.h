//
//  BGViewController.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-9-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CodeStr @"024C565F4C5614322D1200A02F3485B6F314378BACD619011F72003608A9"

@interface BGViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *tipTextView;

- (IBAction)getBG5Memory:(id)sender;

@end
