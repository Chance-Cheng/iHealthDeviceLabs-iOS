//
//  AM3Controller.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-10-15.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AM3Controller : NSObject{
    
    NSMutableArray *AM3Array;
}

/**
 * Initialize AM3 controller class
 */
+(AM3Controller *)shareIHAM3Controller;


/**
 * Access control class instance after receiving AM3ConnectNoti, then use instance to call AM3 related communication methods
 */
-(NSArray *)getAllCurrentAM3Instace;


/**
 * Restart search AM3
 */
-(void)startSearchAM3;


/**
 * Stop search AM3
 */
-(void)stopSearchAM3;


@end
