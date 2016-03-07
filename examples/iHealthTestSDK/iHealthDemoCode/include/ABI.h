//
//  ABI.h
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-11-18.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPMacroFile.h"

@interface ABI : NSObject{
    //ZeroFlag
    BOOL armZeroFlag;
    BOOL legZeroFlag;
    
    //ResultFlag
    BOOL armResultFlag;
    BOOL legResultFlag;
    
    //recTimer
    NSTimer *armTimer;
    NSTimer *legTimer;
    
    //Energy
    BlockEnergyValue _disposeArmEnergyBlock;
    BlockEnergyValue _disposeLegEnergyBlock;
    BlockError _disposeErrorBlock;
    
    //Measure
    BlockUserAuthentication _disposeAuthenBlock;
    BlockPressure _disposeArmPressureBlock;
    BlockPressure _disposeLegPressureBlock;
    BlockXioaboWithHeart _disposeArmXiaoboWithHeartBlock;
    BlockXioaboWithHeart _disposeLegXiaoboWithHeartBlock;
    BlockXioaboNoHeart _disposeArmXiaoboNoHeartBlock;
    BlockXioaboNoHeart _disposeLegXiaoboNoHeartBlock;
    BlockMesureResult _disposeArmMeasureResultBlock;
    BlockMesureResult _disposeLegMeasureResultBlock;
    
    //Stop measure
    BlockStopSuccess _disposeStopBlock;
    
    NSString *thirdUserID;
    
    NSString *clientSDKUserName;
    NSString *clientSDKID;
    NSString *clientSDKSecret;
    
    ABIMeasureType measureType;
}

@property (strong, nonatomic) NSString *currentArmUUID;
@property (strong, nonatomic) NSString *currentLegUUID;
//‘serialNumber’ is for separating different device when multiple device have been connected.
@property (strong, nonatomic) NSString *armSerialNumber;
@property (strong, nonatomic) NSString *legSerialNumber;


/**
 * Query battery remaining energy
 * @param armEnergy  A block to return battery ratio of upper-arm BPM, 80 means 80%.
 * @param legEnergy  A block to return battery ratio of ankle BPM, 80 means 80%.
 * @param error   A block to return the error in ‘Establish measurement connection’.
 */
-(void)commandQueryEnergy:(BlockEnergyValue)armEnergy leg:(BlockEnergyValue)legEnergy errorBlock:(BlockError)error;


/**
 * Establish measurement connection and start BP measurement
 * @param userID  The only identification for the user，by the form of email or cell phone #(cell-phone-# form is not supported temperately).
 * @param clientID  See param 'clientsecret'.
 * @param clientsecret  ‘clientID’ and ‘clientsecret’ are the only identification for user of SDK, are required registration from iHealth administrator, please email: lvjincan@jiuan.com for more information.
 * @param disposeAuthenticationBlock   A block to return parameter of ‘userid’, ’clientID’, ’clientSecret’ after the verification.
 * The interpretation for the verification:
 *  1. UserAuthen_RegisterSuccess, New-user registration succeeded.
 *  2. UserAuthen_LoginSuccess， User login succeeded.
 *  3. UserAuthen_CombinedSuccess, The user is iHealth user as well, measurement via SDK has been activated, and the data from the measurement belongs to the user.
 *  4. UserAuthen_TrySuccess, testing without Internet connection succeeded.
 *  5. UserAuthen_InvalidateUserInfo, Userid/clientID/clientSecret verification failed.
 *  6. UserAuthen_SDKInvalidateRight, SDK has not been authorized.
 *  7. UserAuthen_UserInvalidateRight,User has not been authorized.
 *  8. UserAuthen_InternetError, Internet error, verification failed.
 *  --PS:  
 *  The measurement via SDK will be operated in the case of 1-4, and will be terminated if any of 5-8 occurs. The interface needs to be re-called after analyzing the return parameters.
 *  @Notice   By the first time of new user register via SDK, ‘iHealth disclaimer’ will pop up automatically, and require the user agrees to continue. SDK application requires Internet connection; there is 10-day tryout if SDK cannot connect Internet, SDK is fully functional during tryout period, but will be terminated without verification through Internet after 10 days.
 * @param armPressure  Return Upper-arm blood pressure value during measurement, unit as mmHg
 * @param legPressure  Return Ankle blood pressure value during measurement, unit as mmHg.
 * @param armXiaobo  Return Wavelet value of upper-arm BPM, with heartbeats.
 * @param legXiaobo  Return Wavelet value of ankle BPM, with heartbeats.
 * @param armXiaoboNoHeart  Return Wavelet value of upper-arm BPM, without heartbeats.
 * @param legXiaoboNoHeart  Return Wavelet value of ankle BPM, without heartbeats.
 * @param armResult   Return BP value of upper-arm BPM, including SYS, DIA, heart rate and irregular heartbeat
 * @param legResult  Return BP value of ankle BPM, including SYS, DIA, heart rate and irregular heartbeat.
 * @param error  Return error codes in BlockError.
 */
-(void)commandStartMeasureWithUser:(NSString *)userID clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret Authentication:(BlockUserAuthentication)disposeAuthenticationBlock armPressure:(BlockPressure)armPressure legPressure:(BlockPressure)legPressure armXiaoboWithHeart:(BlockXioaboWithHeart)armXiaobo legXiaoboWithHeart:(BlockXioaboWithHeart)legXiaobo armXiaoboNoHeart:(BlockXioaboNoHeart)armXiaoboNoHeart legXiaoboNoHeart:(BlockXioaboNoHeart)legXiaoboNoHeart  armResult:(BlockMesureResult)armResult legResult:(BlockMesureResult)legResult errorBlock:(BlockError)error;


/**
 * Measurement termination and stop ABI measurement
 * @param success  The block return ‘YES’ means measurement has been terminated,  return ‘NO’ means termination failed.
 * @param error  A block to return the error in ‘Establish measurement connection’ in ABI.
 */
-(void)stopABIMeassureErrorBlock:(BlockStopSuccess)success errorBlock:(BlockError)error;



#pragma mark - Arm Measure Api
/**
 * Query battery remaining energy
 * @param armEnergy  A block to return battery ratio of upper-arm BPM, 80 means 80%.
 * @param error   A block to return the error in ‘Establish measurement connection.
 */
-(void)commandQueryEnergy:(BlockEnergyValue)armEnergy errorBlock:(BlockError)error;


/**
 * Establish measurement connection and Start upper-arm BPM measurement.
 * @param userID  The only identification for the user，by the form of email or cell phone #(cell-phone-# form is not supported temperately).
 * @param clientID
 * @param clientsecret ‘clientID’ and ‘clientsecret’ are the only identification for user of SDK, are required registration from iHealth administrator, please email: lvjincan@jiuan.com for more information.
 * @param disposeAuthenticationBlock  A block to return parameter of ‘userid’, ’clientID’, ’clientSecret’ after the verification.
 * @param armPressure  Return Upper-arm blood pressure value during measurement, unit as mmHg.
 * @param armXiaobo  The Wavelet value of upper-arm BPM, with heartbeats.
 * @param armXiaoboNoHeart  The Wavelet value of upper-arm BPM, without heartbeats.
 * @param armResult  The BP value of upper-arm BPM, including SYS, DIA, heart rate and irregular heartbeat.
 * @param error  Error codes in BlockError.
 */
-(void)commandStartMeasureWithUser:(NSString *)userID clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret Authentication:(BlockUserAuthentication)disposeAuthenticationBlock armPressure:(BlockPressure)armPressure  armXiaoboWithHeart:(BlockXioaboWithHeart)armXiaobo  armXiaoboNoHeart:(BlockXioaboNoHeart)armXiaoboNoHeart armResult:(BlockMesureResult)armResult errorBlock:(BlockError)error;

/**
 * Measurement termination and stop upper-arm BPM measurement
 * @param result  The block return ‘YES’ means measurement has been terminated, return ‘NO’ means termination failed.
 * @param error   A block to return the error in ‘Establish measurement connection' in ABI.
 */
-(void)stopABIArmMeassureBlock:(BlockStopResult)result errorBlock:(BlockError)error;

@end
