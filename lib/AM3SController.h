//
//  AM3SController.h
//  iHealthApp2
//
//  Created by 小翼 on 14-7-2.
//  Copyright (c) 2014年 andon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AM3SController : NSObject
{
    
    NSMutableArray *AM3SArray;
}

/**
 * Initialize AM3S controller class
 */
+(AM3SController *)shareIHAM3SController;

/**
 * Access control class instance after receiving AM3SConnectNoti, then use instance to call AM3s related communication methods
 */
-(NSArray *)getAllCurrentAM3SInstace;


/**
 * Restart search AM3S
 */
-(void)startSearchAM3S;


/**
 * Stop search AM3S
 */
-(void)stopSearchAM3S;


@end