//
//  PO3.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-11-29.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "POMacroFile.h"


typedef void (^DisposePO3Block)(BOOL resetSuc);//PO3 result
typedef void (^DisposePO3ErrorBlock)(PO3ErrorID errorID);//PO3 error
typedef void (^DisposePO3Battery)(NSNumber *battery);    //PO3 Energy
typedef void (^DisposePO3HistoryData)(NSDictionary *historyDataDic);//Historical data

typedef void (^DisposePO3WaveHistoryData)(NSDictionary *waveHistoryDataDic);//Historical data
typedef void (^DisposePO3ProgressData)(NSNumber *progress);//Memory transmission progress，0.0～1.0.
typedef void (^StartPO3Transmission)(BOOL startData);
typedef void (^FinishPO3Transmission)(BOOL finishData);
typedef void (^DisposePO3DataCount)(NSNumber* dataCount);//Historical data count
typedef void (^DisposePO3MeasureData)(NSDictionary* measureDataDic);//Current data
typedef void (^StartPO3MeasureData)(BOOL startData);//start Memory
typedef void (^FinishPO3MeasureData)(BOOL finishData);//Memory complete
typedef void (^DisposeSynchronousTimeFinishBlock) (BOOL finishSynchronous);//Sync time complete

@interface PO3 : NSObject{
    
    DisposePO3Block _disposeBlock;
    DisposePO3ErrorBlock _disposeErrorBlock;
    DisposePO3Battery _disposePO3Battery;
    DisposePO3DataCount _disposePO3DataCount;
    StartPO3Transmission _startPO3Transmission;
    FinishPO3Transmission _finishPO3Transmission;
    DisposePO3ProgressData _disposePO3ProgressData;
    DisposePO3MeasureData _disposePO3MeasureData;
    StartPO3MeasureData _startPO3MeasureData;
    FinishPO3MeasureData _finishPO3MeasureData;
    DisposePO3HistoryData _disposePO3HistoryData;
    DisposePO3WaveHistoryData _disposePO3WaveHistoryData;
    DisposeSynchronousTimeFinishBlock _disposeSynchronousTimeFinishBlock;
    
    BlockUserAuthentication _disposeAuthenticationBlock;

    
    BOOL isNeedClould;
    BOOL modelVerifyOK;

    
    User *_myUser;
    NSString *_thirdUserID;
    NSString *_clientSDKUserName;
    NSString *_clientSDKID;
    NSString *_clientSDKSecret;

}
@property (retain, nonatomic) NSString *currentUUID;
@property (retain, nonatomic) NSString *serialNumber;
@property (copy,   nonatomic) NSString *isInUpdateProcess;
@property (retain, nonatomic) NSString *firmwareVersion;

/**
 * Restore Sync time
 * @param tempUser TempUser,includes properties:clientID,clientSecret,userID。 userID,either email or mobile phone number (mobile phone number not yet supported).ClientID and clientSecret, the only identification for users of the SDK, requires registration from iHealth administrator, please email: lvjincan@jiuan.com for more information
 * @param disposeAuthenticationBlock The return parameters of ’‘userid’, ’clientID’,and ‘clientSecret’ after verification.
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
 * @param disposeSynchronousTimeFinishBlock Sync completed. Yes = Success, No = Fail.
 * @param disposeErrorBlock Communication error codes, see section 5.
 */
-(void)commandCreatePO3User:(User *)tempUser Authentication:(BlockUserAuthentication)disposeAuthenticationBlock DisposeResultBlock:(DisposeSynchronousTimeFinishBlock)disposeSynchronousTimeFinishBlock DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;


/**
 * Restore Real-time measurements
 * @param startPO3MeasureData  Start measurement, Return no for fail, return yes for success.
 * @param disposePO3MeasureData  SpO2 values, including SpO2, pulse rate, pulse intensity. Corresponding keys are spo2, bpm, wave, and pi.
 * @param finishPO3MeasureData  Finish measurement. No for fail, yes for success.
 * @param disposeErrorBlock Communication error codes, see section 5.
 */
-(void)commandStartPO3MeasureData:(StartPO3MeasureData)startPO3MeasureData Measure:(DisposePO3MeasureData)disposePO3MeasureData  FinishPO3MeasureData:(FinishPO3MeasureData)finishPO3MeasureData  DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;



/**
 * Restore Historical data
 * @param disposePO3DataCount Number of historical offline data measurements.
 * @param startTransmission:Start  data transmission. Yes for success, no for fail.
 * @param disposePO3HistoryData date, spo2, bpm, and wave.
 * @param disposePO3WaveHistoryData Pulse intensity, corresponding key: wave
 * @param progress  Data transmission progress from 0-1.0
 * @param finishTransmission End transmission of data, yes for success, no for fail.
 * @param disposeErrorBlock Communication error codes, see section 5.
 */
-(void)commandDisposePO3DataCount:(DisposePO3DataCount)disposePO3DataCount TransferMemorryData:(StartPO3Transmission)startTransmission Memory:(DisposePO3HistoryData)disposePO3HistoryData DisposePO3WaveHistoryData:(DisposePO3WaveHistoryData)disposePO3WaveHistoryData   DisposeProgress:(DisposePO3ProgressData)progress  FinishTransmission:(FinishPO3Transmission)finishTransmission DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;


/**
 * Restore factory settings
 * @param disposeBlock  Yes = success, no = fail.
 * @param disposeErrorBlock
 */
-(void)commandResetPO3DeviceDisposeResultBlock:(DisposePO3Block)disposeBlock DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;



/**
 * Query power status
 * @param disposeBattery Battery %.
 * @param disposeBlock  Yes = success, no = fail.
 * @param disposeErrorBlock  Communication error codes, see section 5.
 */
-(void)commandQueryBatteryInfo:(DisposePO3Block)disposeBlock DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock DisposeBattery:(DisposePO3Battery)disposeBattery;



/**
 * Disconnect connection
 * @param disposeBlock  Yes = success, no = fail.
 * @param disposeErrorBlock  Communication error codes, see section.
 */
-(void)commandEndPO3CurrentConnect:(DisposePO3Block)disposeBlock DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;
@end


