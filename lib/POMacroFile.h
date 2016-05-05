//
//  POMacroFile.h
//  POSDK
//
//  Created by 小翼 on 14-8-11.
//  Copyright (c) 2014年 hejiasu. All rights reserved.
//

#import "User.h"

#ifndef POSDK_POMacroFile_h
#define POSDK_POMacroFile_h

#define PO3DeviceID @"ID"
#define PO3SDKRightApi  @"OpenApiSpO2"

typedef enum{
    PO3CommError = 0,  // Bluetooth Communication Error
    PO3AccessError,    // Flash (Data) Access Error
    PO3HardwareError,  // Irregular Hardware Error
    PO3PRbpmtestError, // The SpO2 or pulse rate test result is beyond the measurement range of the system
    PO3UnknownError,         //Unknown Interference Detected
    PO3SendCommandFaild,     // Send failed
    PO3DeviceDisConect,      // Device is disconnected
    PO3DataZero,             // No data
    PO3UserInvalidate = 111  // User authentication fails
    
}PO3ErrorID;



typedef void (^BlockUserAuthentication)(UserAuthenResult result);//the result of userID verification

#define PO3Discover       @"PO3Discover"
#define PO3ConnectFailed   @"PO3ConnectFailed"
#define PO3ConnectNoti @"PO3ConnectNoti"
#define PO3DisConnectNoti @"PO3DisConnectNoti"

#endif
