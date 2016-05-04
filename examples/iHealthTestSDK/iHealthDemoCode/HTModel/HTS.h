//
//  HTS.h
//  Contina_BP
//
//  Created by XuJianbo on 15/6/29.
//  Copyright (c) 2015年 XuJianbo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "User.h"

typedef enum{
    HTSDeviceDisconnect, //Device disconnect
    HTSUserInvalidate = 111//User verify error
}HTSDeviceError;

typedef void (^DisposeHTSResult)(NSDictionary* resetDic);

typedef void (^DisposeHTSErrorBlock)(HTSDeviceError errorID);

typedef void (^GetHTSBattary)(NSNumber* battary);

typedef void (^BlockHTSUserAuthentication)(UserAuthenResult result);


@interface HTS : NSObject
{
    DisposeHTSErrorBlock _DisposeHTSErrorBlock;
    
    GetHTSBattary _GetHTSBattary;
    
    DisposeHTSResult _DisposeHTSResult;
    
    BlockHTSUserAuthentication _BlockHTSUserAuthentication;
    
    
    User *htsUser;
    NSString *thirdUserID;
    NSString *clientSDKUserName;
    NSString *clientSDKID;
    NSString *clientSDKSecret;
    
     BOOL modelVerifyOK;
}

@property (strong, nonatomic) NSString *currentUUID;
@property (strong, nonatomic) NSString *deviceID;
@property (retain, nonatomic) NSString *firmwareVersion;


-(void)commandGetBattary:(GetHTSBattary)battary DisposeErrorBlock:(DisposeHTSErrorBlock)disposeErrorBlock;


-(void)commandTestHTSWithUser:(User *)tempUser Authentication:(BlockHTSUserAuthentication)disposeAuthenticationBlock  DisposeHTSResult:(DisposeHTSResult)DisposeHTSResult DisposeErrorBlock:(DisposeHTSErrorBlock)disposeErrorBlock;

@end
