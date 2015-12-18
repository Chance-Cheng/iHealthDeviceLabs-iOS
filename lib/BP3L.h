//
//  BP3L.h
//  testShareCommunication
//
//  Created by my on 14/10/13.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BPMacroFile.h"
#import <UIKit/UIKit.h>

typedef enum {
    BP3LNormalError = 1,//下位机传上来的错误信息
    BP3LOverTimeError,//底层发的超时
    BP3LNoRespondError,//一定时间内没收到响应的，一般是蓝牙堵塞
    BP3LBeyondRangeError,//超范围的
    BP3LDidDisconnect,//下位机断开
    //    BP3LAskToShut,//下位机请求关机
    BP3LAskToStopMeasure//下位机请求中断测量
    
}BP3LDeviceError;

typedef void (^BlockEnergyValue)(NSNumber *energyValue);
typedef void(^BlockError)(BPDeviceError error);
typedef void(^BlockDeviceFounction)(NSDictionary *dic);
typedef void(^BlockBlueSet)(BOOL isOpen);
typedef void(^BlockAngle)(NSDictionary *dic);
typedef void(^BlockPressure)(NSArray *pressureArr);
typedef void(^BlockXioaboWithHeart)(NSArray *xiaoboArr);
typedef void(^BlockXioaboNoHeart)(NSArray *xiaoboArr);
typedef void(^BlockZero)(BOOL isComplete);
typedef void(^BlockMesureResult)(NSDictionary *dic);

typedef void(^BlockBachCount)(NSNumber *num);
typedef void(^BlockBachProgress)(NSNumber *pregress);
typedef void(^BlockBachArray)(NSArray *array);

typedef void(^BlockStopSuccess)();

@interface BP3L :NSObject{
    
    BlockEnergyValue _blockEnergyValue;
    BlockError _blockError;
    BlockDeviceFounction _blockFounction;
    BlockBlueSet _blockBlueSet;
    BlockAngle _blockAngle;
    
    BlockXioaboWithHeart _blockXiaoboArr;
    BlockXioaboNoHeart _blockXiaoboArrNoHeart;
    BlockPressure _blockPressureArr;
    BlockMesureResult _blockMesureResult;
    
    BlockBachCount _blockBachCount;
    BlockBachProgress _blockBachProgress;
    BlockBachArray _blockBachArray;
    BlockStopSuccess _blockStopSuccess;
    
    BlockUserAuthentication _blockUserAnthen;
    
    UIAlertView * Erroralert;
    
    BOOL isCompleteZero;
    int totalBatchCount;
    BOOL isResived;
    int uploadCountSum;
    int wavePackageCnt;
    BOOL beMeasuringFlg;
    
    NSString *thirdUserID;
    
    NSString *clientSDKUserName;
    NSString *clientSDKID;
    NSString *clientSDKSecret;
    
    NSMutableArray *totalHistoryArray;
}

@property (strong, nonatomic) NSString *currentUUID;
//‘serialNumber’ is for separating different device when multiple device have been connected.
@property (strong, nonatomic) NSString *serialNumber;
@property (strong, nonatomic) NSTimer *startMeasureTimer;

/**
 * Establish measurement connection and start BP measurement.
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
 * @param Pressure  Pressure value in the process of measurement, the unit is ‘mmHg’.
 * @param xiaobo  Wavelet data set including pulse rate
 * @param xiaoboNoHeart   Wavelet data set without pulse rate
 * @param result   result of the measurement, including systolic pressure, diastolic pressure, pulse rate and irregular judgment. Relevant key: SYS, DIA, heartRate, irregular
 * @param error   Return error codes.
 * Specification:
 *   1.  BPNormalError:  device error, error message displayed automatically.
 *   2.  BPOverTimeError:   communication over time error.
 *   3.  BPNoRespondError:   abnormal communication.
 *   4.  BPBeyondRangeError:   device is out of communication range.
 *   5.  BPDidDisconnect:   device is disconnected.
 *   6.  BPAskToStopMeasure:   measurement has been stopped.
 */
-(void)commandStartMeasureWithUser:(NSString *)userID clientID:(NSString *)clientID clientSecret:(NSString *)clientSecret Authentication:(BlockUserAuthentication)disposeAuthenticationBlock pressure:(BlockPressure)pressure xiaoboWithHeart:(BlockXioaboWithHeart)xiaobo xiaoboNoHeart:(BlockXioaboNoHeart)xiaoboNoHeart  result:(BlockMesureResult)result errorBlock:(BlockError)error;

/**
 * Measurement termination and stop BP3L measurement
 * @param success  The block return means measurement has been terminated.
 * @param error  A block to return the error in ‘Establish measurement connection’ in BP3L.
 */
-(void)stopBPMeassureErrorBlock:(BlockStopSuccess)success errorBlock:(BlockError)error;

/**
 * Synchronize time and judge if the device supports BT auto-connection, offline detection, and if the function on or off, corresponding KEY as haveBlue, haveOffline, blueOpen, offlineOpen. ‘True’ means yes or on, ‘False’ means no or off
 * @param Function  A block to return the function and states that the device supports.
 * @param error  A block to refer ‘error’ in ‘Establish measurement connection’ in BP7S.
 */
-(void)commandFounction:(BlockDeviceFounction)founction errorBlock:(BlockError)error;

/**
 * Query battery remaining energy
 * @param energyValue  A block to return the device battery remaining energy percentage, ‘80’ stands for 80%.
 * @param error  A block to return the error in ‘Establish measurement connection’.
 */
-(void)commandEnergy:(BlockEnergyValue)energyValue errorBlock:(BlockError)error;

/**
 *Disconnect current device
 */
-(void)commandDisconnectDevice;

@end
