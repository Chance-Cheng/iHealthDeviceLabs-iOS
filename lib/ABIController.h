//
//  ABIController.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-11-18.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ABI.h"

#define IOS8Flag   ([UIDevice currentDevice].systemVersion.intValue>=8)?YES:NO

@interface ABIController : NSObject{
    NSString *currentArmUUID;
    NSString *currentLegUUID;
    ABI *currentABIInstance;
    
    NSString *armSerialNumber;
    NSString *legSerialNumber;
    
    ABI *currentArmInstance;
}

/**
 * Initialize ABI controller class
 */
+(ABIController *)shareABIController;

/**
 * Get all ABI instance,Access control class instance after receiving ABIConnectNoti, then use instance to call ABI related communication methods.
 */
-(ABI *)getCurrentABIInstace;

/**
 * Get all ABI-Arm instance,Access control class instance after receiving DeviceAuthenSuccess, then use instance to call ABI-Arm related communication methods.
 */
-(ABI *)getCurrentArmInstance;

@end
