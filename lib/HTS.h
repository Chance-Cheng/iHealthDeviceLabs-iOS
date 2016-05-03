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

 /* @param battary HTM battery percentage, from 0～100.*/
-(void)commandGetBattary:(GetHTSBattary)battary DisposeErrorBlock:(DisposeHTSErrorBlock)disposeErrorBlock;

/*  Establish  measurement connection*/
/*
 Import Parameters:
 tempUser included properties: clientID, clientSecret, userID
 userID: either email or mobile phone number (mobile phone number is not currently supported yet)
 clientID & clientSecret: the only identification for users of the SDK, requires registration from iHealth administrator, please email: lvjincan@jiuan.com for more information.
 
 Return Parameters:
 disposeAuthenticationBlock: The return parameters of ’‘userid’, ’clientID’, and ‘clientSecret’ after verification
 
 The interpretation for the verification:
 UserAuthen_RegisterSuccess: New-user registration succeeded.
 UserAuthen_LoginSuccess: User login succeeded.
 UserAuthen_CombinedSuccess: The user is an iHealth user as well, measurement via SDK has been activated, and the data from the measurement belongs to the user.
 UserAuthen_TrySuccess: Testing without internet connection succeeded.
 UserAuthen_InvalidateUserInfo: Userid/clientID/clientSecret verification failed.
 UserAuthen_SDKInvalidateRight: SDK has not been authorized.
 UserAuthen_UserInvalidateRight: User has not been authorized.
 UserAuthen_InternetError: Internet error, verification failed.
 The measurement via SDK will be operated in the case of 1-4, and will be terminated if any of 5-8 occurs. The interface needs to be re-called after analyzing the return parameters.
 Notice: when a new user registers via SDK, an ‘iHealth disclaimer’ will pop up automatically, and will require the user to agree in order to continue. SDK applications require an Internet connection; there is 10-day trial period if the SDK cannot connect to the internet, the SDK is fully functional during tryout period, but will be terminated without a working internet connection after 10 days.
 
 DisposeHTSResult：HTS result
 disposeErrorBlock：Error code in measurement process
 error code definition：refer to ‘error’ in HTSDeviceError: HTS error instructions.
 
 */

-(void)commandTestHTSWithUser:(User *)tempUser Authentication:(BlockHTSUserAuthentication)disposeAuthenticationBlock  DisposeHTSResult:(DisposeHTSResult)DisposeHTSResult DisposeErrorBlock:(DisposeHTSErrorBlock)disposeErrorBlock;

@end
