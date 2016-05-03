//
//  AM4Controller.h
//  iHealthApp3
//
//  Created by 小翼 on 15/5/22.
//  Copyright (c) 2015年 iHealth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AM4Controller : NSObject
{
    NSMutableArray *_AM4Array;
}



/**
 * Initialize AM4 controller class
 */
+(AM4Controller *)shareIHAM4Controller;


/**
 * Access control class instance after receiving AM4ConnectNoti, then use instance to call AM4 related communication methods
 */
-(NSArray *)getAllCurrentAM4Instace;

/**
 * To specify a specific AM4 device to improve the efficiency of the connection, use the following API. Specify the AM4 unique ID (MAC Address). 
 */
-(void)commandSetYourDeviceID:(NSString *)tempDeviceID;


/**
 * If already connected to the correct AM4, can stop connections to any other AM4's with the following API. True: Can connect to AM4's. False: Stop connecting to other AM4's.
 */
-(void)commandCanConnectOtherDevice:(BOOL)tempFlag;


/**
 * Restart search AM4
 */
-(void)startSearchAM4;


/**
 * Stop search AM4
 */
-(void)stopSearchAM4;

@end