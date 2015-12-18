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
    DisposePO3Battery _disposeAM3Battery;
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
    NSDate *_synchronousTime;

}
@property (retain, nonatomic) NSString *currentUUID;
@property (retain, nonatomic) NSString *serialNumber;
@property (copy,   nonatomic) NSString *isInUpdateProcess;
@property (retain, nonatomic) NSString *firmwareVersion;

//Sync time
/*
 Input Parameters:
 tempUser,includes properties:clientID,clientSecret,userID。 userID,either email or mobile phone number (mobile phone number not yet supported).
 ClientID and clientSecret, the only identification for users of the SDK, requires registration from iHealth administrator, please email: lvjincan@jiuan.com for more information
 Return Parameters:
 disposeAuthenticationBlock: The return parameters of ’‘userid’, ’clientID’,
 and ‘clientSecret’ after verification。 The interpretation for the verification:
 UserAuthen_RegisterSuccess: New-user registration succeeded. UserAuthen_LoginSuccess: User login succeeded.
 UserAuthen_CombinedSuccess: The user is an iHealth user as well, measurement via SDK has been activated, and the data from the measurement belongs to the user. UserAuthen_TrySuccess: Testing without internet connection succeeded. UserAuthen_InvalidateUserInfo: Userid/clientID/clientSecret verification failed. UserAuthen_SDKInvalidateRight: SDK has not been authorized. UserAuthen_UserInvalidateRight: User has not been authorized.
 UserAuthen_InternetError: Internet error, verification failed.
 The measurement via SDK will be operated in the case of 1-4, and will be terminated if any of 5-8 occurs. The interface needs to be re-called after analyzing the return parameters.
 Notice: when a new user registers via SDK, an ‘iHealth disclaimer’ will pop up automatically, and will require the user to agree in order to continue. SDK applications require an Internet connection; there is 10-day trial period if the SDK cannot connect to the internet, the SDK is fully functional during tryout period, but will be terminated without a working internet connection after 10 days.
 disposeSynchronousTimeFinishBlock:Sync completed. Yes = Success, No = Fail. disposeErrorBlock: Communication error codes, see section 5
 */
-(void)commandCreatePO3User:(User *)tempUser Authentication:(BlockUserAuthentication)disposeAuthenticationBlock DisposeResultBlock:(DisposeSynchronousTimeFinishBlock)disposeSynchronousTimeFinishBlock DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;

//Real-time measurements
/*
 Return parameters:
 startPO3MeasureData: Start measurement. Return no for fail, return yes for success. disposePO3MeasureData:SpO2 values, including SpO2, pulse rate, pulse intensity. Corresponding keys are spo2, bpm, wave, and pi.
 finishPO3MeasureData: Finish measurement. No for fail, yes for success.
 disposeErrorBlock: Communication error codes, see section 5
 */
-(void)commandStartPO3MeasureData:(StartPO3MeasureData)startPO3MeasureData Measure:(DisposePO3MeasureData)disposePO3MeasureData  FinishPO3MeasureData:(FinishPO3MeasureData)finishPO3MeasureData  DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;

//Historical data
/*
 Return parameters:
 disposePO3DataCount:Number of historical offline data measurements startTransmission:Start data transmission. Yes for success, no for fail. disposePO3HistoryData:date, spo2, bpm, and wave. disposePO3WaveHistoryData:Pulse intensity, corresponding key: wave progress: Data transmission progress from 0-1.0 finishTransmission:End transmission of data, yes for success, no for fail disposeErrorBlock:Communication error codes, see section 5
 */
-(void)commandDisposePO3DataCount:(DisposePO3DataCount)disposePO3DataCount TransferMemorryData:(StartPO3Transmission)startTransmission Memory:(DisposePO3HistoryData)disposePO3HistoryData DisposePO3WaveHistoryData:(DisposePO3WaveHistoryData)disposePO3WaveHistoryData   DisposeProgress:(DisposePO3ProgressData)progress  FinishTransmission:(FinishPO3Transmission)finishTransmission DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;

//Restore factory settings
/*
 Return parameters:
 disposeBlock: Returns yes for success, no for fail. disposeErrorBlock:Communication error codes, see section 5
 */
-(void)commandResetPO3DeviceDisposeResultBlock:(DisposePO3Block)disposeBlock DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;

//Query power status
/*
 Return parameters:
 disposeBlock: Yes = success, no = fail. disposeErrorBlock:Communication error codes, see section 5
 disposeBattery:Battery %
 */
-(void)commandQueryBatteryInfo:(DisposePO3Block)disposeBlock DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock DisposeBattery:(DisposePO3Battery)disposeBattery;

//Disconnect connection
/*
 Return parameters:
 disposeBlock: Yes = success, no = fail disposeErrorBlock:Communication error codes, see section 5
 */
-(void)commandEndPO3CurrentConnect:(DisposePO3Block)disposeBlock DisposeErrorBlock:(DisposePO3ErrorBlock)disposeErrorBlock;
@end


