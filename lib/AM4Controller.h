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
 * Restart search AM4
 */
-(void)startSearchAM4;


/**
 * Stop search AM4
 */
-(void)stopSearchAM4;

@end