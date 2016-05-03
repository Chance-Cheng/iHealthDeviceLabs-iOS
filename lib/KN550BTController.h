//
//  KN550BTController.h
//  testShareCommunication
//
//  Created by my on 8/10/13.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KN550BTController : NSObject{
    NSMutableArray *KN550BTDeviceArray;
}

/**
 * Initialize KN550BT controller class
 */
+(KN550BTController *)shareKN550BTController;

/**
 * Get all KN550BT instance,Access control class instance after receiving KN550BTConnectNoti, then use instance to call KN550BT related communication methods.
 */
-(NSArray *)getAllCurrentKN550BTInstace;

/**
 * Restart search KN550BT
 */
-(void)startSearchKN550BT;

 /**
  * Stop search KN550BT
  */
-(void)stopSearchKN550BT;


@end
