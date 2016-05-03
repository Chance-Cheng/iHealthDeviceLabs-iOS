//
//  BP3LViewController.h
//  testShareCommunication
//
//  Created by my on 14/10/13.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BP3LController : NSObject{
    
    NSMutableArray *BP3LDeviceArray;
}

/**
 * Initialize BP3L controller class
 */
+(BP3LController *)shareBP3LController;

/**
 * Get all BP3L instance,Access control class instance after receiving BP3LConnectNoti then use instance to call BP3L related communication methods.
 */
-(NSArray *)getAllCurrentBP3LInstace;

/**
 * Restart search BP3L
 */
-(void)startSearchBP3L;

/**
 * Stop search BP3L
 */
-(void)stopSearchBP3L;

@end
