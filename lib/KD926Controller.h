//
//  KD926ViewController.h
//  testShareCommunication
//
//  Created by my on 14/10/13.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KD926Controller : NSObject{
NSMutableArray *KD926DeviceArray;
}

/**
 * Initialize KD926 controller class
 */
+(KD926Controller *)shareKD926Controller;
/**
 * Get all KD926 instance,Access control class instance after receiving KD926ConnectNoti, then use instance to call KD926 related communication methods.
 */
-(NSArray *)getAllCurrentKD926Instace;
@end
