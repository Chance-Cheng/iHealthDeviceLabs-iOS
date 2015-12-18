//
//  AM4.h
//  iHealthApp2
//
//  Created by 小翼 on 14-7-2.
//  Copyright (c) 2014年 andon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AMMacroFile.h"

#define AM4StepNum @"AM4stepNum"
#define AM4StepSize @"AM4stepSize"
#define AM4Calorie @"AM4calorie"
#define AM4Date @"AM4Date"
#define AM4QuerState "AM4QuerState"

#define AM4SleepActiveHistoryDateYear @"SleepActiveHistoryDateYear"
#define AM4SleepActiveHistoryDateMonth @"SleepActiveHistoryDateMonth"
#define AM4SleepActiveHistoryDateDay @"SleepActiveHistoryDateDay"
#define AM4SleepActiveHistoryDateHour @"SleepActiveHistoryDateHour"
#define AM4SleepActiveHistoryDateMinute @"SleepActiveHistoryDateMinute"
#define AM4SleepActiveHistoryDateSeconds @"SleepActiveHistoryDateSeconds"
#define AM4TimeInterval @"TimeInterval"
#define AM4StartActiveHistoryTotoalNum @"StartActiveHistoryTotoalNum"
#define AM4StateFlage @"StateFlage"

#define AM4SwimmingMeasureDate @"SwimmingMeasureDate"
#define AM4SwimmingTimeNumber @"SwimmingTimeNumber"
#define AM4SwimmingTimes @"SwimmingTimes"
#define AM4Swimmingcalories @"Swimmingcalories"
#define AM4SwimmingAct @"SwimmingAct"
#define AM4SwimmingPoollength @"swimmingPoollength"
#define AM4SwimmingCircleCount @"SwimmingCircleCount"

#define AM4Work_outMeasureDate @"Work_outMeasureDate"
#define AM4Work_outTimeNumber @"Work_outTimeNumber"
#define AM4Work_outStepNumber @"Work_outStepNumber"
#define AM4Work_outLengthNumber @"Work_outLengthNumber"
#define AM4Work_outCalories @"Work_outCalories"

#define AM4Sleep_summaryMeasureDate @"Sleep_summaryMeasureDate"
#define AM4Sleep_summarySleepTime @"Sleep_summarySleepTime"
#define AM4Sleep_summarysleepEfficiency @"Sleep_summarysleepEfficiency"
#define AM4Sleep_summarysleepAddMinute @"Sleep_summarysleepAddMinute"

#define AM4ReportState @"ReportState"
#define AM4ActiveminutesMeasureDate @"ActiveminutesMeasureDate"
#define AM4ActiveminutesTime @"ActiveminutesTime"




//增加查询用户ID;
typedef void (^DisposeAM4AskUserIDBlock)(unsigned int userID);
//错误ID
typedef void (^DisposeAM4ErrorBlock)(AM4ErrorID errorID);
//随机数
typedef void (^DisposeAM4SetRandomBlock)(BOOL resetSuc);
//同步时间
typedef void (^DisposeAM4SyncTimeBlock)(BOOL resetSuc);

//查询区域与时间格式
typedef void (^DisposeAM4TimeFormatAndNationBlock)(AM4TimeFormatAndNation  timeFormatAndNation);

//设置区域时间格式
typedef void (^DisposeAM4TimeFormatAndNationSettingBlock)(BOOL timeFormatAndNationSetting);
//设置用户ID
typedef void (^DisposeAM4SetUserIDBlock)(BOOL resetSuc);
//配置个人信息
typedef void (^DisposeAM4SetUserInfoBlock)(BOOL resetSuc);



//开始传输活动数据
typedef void (^DisposeAM4ActiveStartTransmission)(NSDictionary *startDataDictionary);
//运动历史数据
typedef void (^DisposeAM4ActiveHistoryData)(NSArray *historyDataArray);
//运动传输结束
typedef void (^DisposeAM4ActiveFinishTransmission)();

//开始传输睡眠数据
typedef void (^DisposeAM4SleepStartTransmission)(NSDictionary *startDataDictionary);
//睡眠历史数据
typedef void (^DisposeAM4SleepHistoryData)(NSArray *historyDataArray);
//睡眠传输结束
typedef void (^DisposeAM4SleepFinishTransmission)();


//增加查询当前运动信息;@"Step",@"Calories"
typedef void (^DisposeAM4QueryCurrentActiveInfo)(NSDictionary *activeDictionary);



//恢复出厂设置是否成功
typedef void (^DisposeAM4ResetDeviceBlock)(BOOL resetSuc);


//总的闹钟信息
typedef void (^DisposeAM4TotoalAlarmData)(NSMutableArray *totoalAlarmArray);

//设置闹钟
typedef void (^DisposeAM4SetAlarmBlock)(BOOL resetSuc);

//删除闹钟
typedef void (^DisposeAM4DeleteAlarmBlock)(BOOL resetSuc);

//提醒信息
typedef void (^DisposeAM4RemindAM4InfoBlock)(NSArray *remindInfo);

//设置提醒
typedef void (^DisposeAM4SetReminderBlock)(BOOL resetSuc);


//查询的状态
typedef void (^DisposeAM4StateInfoBlock)(AM4QueryState queryState);

//电池电量
typedef void (^DisposeAM4BatteryBlock)(NSNumber *battery);

//断开
typedef void (^DisposeAM4DisconnectBlock)(BOOL resetSuc);




//查询歩距
typedef void (^DisposeAM4StepBlock)(NSNumber * normalStepLength, NSNumber *fastStepLength, NSNumber *slowStepLength);
//设置步距
typedef void (^DisposeAM4SetStepLengthBlock)(BOOL resetSuc);

//查询游泳
typedef void (^DisposeAM4SwimmingBlock)(BOOL swimmingIsOpen, NSNumber * swimmingLaneLength,NSNumber * NOSwimmingTime, AM4SwimmingUnit unit);

//设置游泳
typedef void (^DisposeAM4SettingSwimmingBlock)(BOOL resetSuc);

//查询功能按钮
typedef void (^DisposeAM4QueryActiveminituesBlock)(BOOL resetSuc);

//设置功能按钮
typedef void (^DisposeAM4SettingActiveminituesBlock)(BOOL resetSuc);

//阶段性同步条数
typedef void (^DisposeAM4SyncSportCountBlock)(NSNumber *sportCount);
//阶段性测试条数
typedef void (^DisposeAM4MeasureDataBlock)(NSArray *measureDataArray);
//阶段性数据结束
typedef void (^DisposeAM4WorkoutFinishBlock)(BOOL resetSuc);


//查询图片
typedef void (^DisposeAM4PictureBlock)(AM4Picture picture);
//设置图片
typedef void (^DisposeAM4SettingPictureBlock)(BOOL resetSuc);
//设置状态
typedef void (^DisposeAM4SetStateBlock)(BOOL resetSuc);

//用户信息
typedef void (^DisposeAM4UserInfoBlock)(NSDictionary *userInfo);

@class User;
@interface AM4 : NSObject{
    
    DisposeAM4AskUserIDBlock _disposeAM4AskUserIDBlock;
    DisposeAM4ErrorBlock _disposeAM4ErrorBlock;
    DisposeAM4SetRandomBlock _disposeAM4SetRandomBlock;
    DisposeAM4SyncTimeBlock _disposeAM4SyncTimeBlock;
    DisposeAM4TimeFormatAndNationBlock _disposeAM4TimeFormatAndNationBlock;
    DisposeAM4TimeFormatAndNationSettingBlock _disposeAM4TimeFormatAndNationSettingBlock;
    DisposeAM4SetUserIDBlock _disposeAM4SetUserIDBlock;
    DisposeAM4SetUserInfoBlock _disposeAM4SetUserInfoBlock;
    
    DisposeAM4ActiveStartTransmission _disposeAM4ActiveStartTransmission;
    DisposeAM4ActiveHistoryData _disposeAM4ActiveHistoryData;
    DisposeAM4ActiveFinishTransmission _disposeAM4ActiveFinishTransmission;
    
    DisposeAM4SleepStartTransmission _disposeAM4SleepStartTransmission;
    DisposeAM4SleepHistoryData _disposeAM4SleepHistoryData;
    DisposeAM4SleepFinishTransmission _disposeAM4SleepFinishTransmission;
    
    DisposeAM4QueryCurrentActiveInfo _disposeAM4QueryCurrentActiveInfo;
    DisposeAM4ResetDeviceBlock _disposeAM4ResetDeviceBlock;
    
    
    DisposeAM4TotoalAlarmData _disposeTotoalAlarmData;
    DisposeAM4SetAlarmBlock _disposeAM4SetAlarmBlock;
    DisposeAM4DeleteAlarmBlock  _disposeAM4DeleteAlarmBlock;
    
    
    DisposeAM4RemindAM4InfoBlock _disposeAM4RemindAM4InfoBlock;
    
    DisposeAM4SetReminderBlock _disposeAM4SetReminderBlock;
    
    
    DisposeAM4StateInfoBlock _disposeAM4StateInfoBlock;
    DisposeAM4BatteryBlock _disposeAM4BatteryBlock;
    DisposeAM4DisconnectBlock _disposeAM4DisconnectBlock;
    
    
    DisposeAM4StepBlock _disposeStepBlock;
    DisposeAM4SetStepLengthBlock _disposeAM4SetStepLengthBlock;
    DisposeAM4SwimmingBlock _disposeSwimmingBlock;
    DisposeAM4SettingSwimmingBlock _disposeAM4SettingSwimmingBlock;
    DisposeAM4QueryActiveminituesBlock _disposeAM4QueryActiveminituesBlock;
    DisposeAM4SettingActiveminituesBlock _disposeAM4SettingActiveminituesBlock;
    
    DisposeAM4SyncSportCountBlock _disposeSyncSportCountBlock;
    DisposeAM4MeasureDataBlock _disposeMeasureDataBlock;
    DisposeAM4WorkoutFinishBlock _disposeAM4WorkoutFinishBlock;
    DisposeAM4PictureBlock _disposePictureBlock;
    DisposeAM4SettingPictureBlock _disposeAM4SettingPictureBlock;
    DisposeAM4SetStateBlock _disposeAM4SetStateBlock;
    
    DisposeAM4UserInfoBlock _disposeAM4UserInfoBlock;
    
    BlockUserAuthentication _disposeAuthenticationBlock;
    CurrentSerialNub _currentSerialNub;
    DisposeQueryBinedSerialNub _disposeQueryBinedSerialNubBlock;
    DisposeBinedUserResult _disposeBinedResultBlock;
    DisposeDisBinedUserResult _disposeDisBinedResultBlock;
    DisposeBinedAMSerialNub _disposeBinedAMSerialNubBlock;
    DisposeCurrentSerialNub _disposeCurrentSerialNubBlock;

    
    
    NSNumber *_goalNumber;
    NSMutableArray *_activeDataArray;//存放运动数据
    NSMutableArray *_sleepDataArray;//存放睡眠数据
    NSMutableArray *_sleepSectionArray;//存放睡眠等级数据
    
    NSInteger _AM4ActiveTotoalNum;//运动总条数
    NSInteger _AM4ActiveTimeInterval;//运动时间偏差
    BOOL _AM4ActiveStart;//用来标识一批五分钟数据的开始
    
    NSInteger _AM4SleepTotoalNum;//睡眠总条数
    NSInteger _AM4SleepTimeInterval;//睡眠时间偏差
    uint8_t _AM4SleepCount;//睡眠条数用来有多少段睡眠（数组套数组的格式）
    
    //同步运动数据时计算时间
    uint8_t activeYear;
    uint8_t activeMonth;
    uint8_t activeDay;
    uint8_t activeStepSize;
    
    
    //同步睡眠数据计算时间
    uint8_t sleepYear;
    uint8_t sleepMonth;
    uint8_t sleepDay;
    uint8_t sleepHour;
    uint8_t sleepMinute;
    uint8_t sleepSecond;
    
    
    NSInteger _totoalAlarm;//闹钟总数
    NSInteger _alarmQueryTime;//查询次数
    NSMutableArray *_alarmIDArray;
    NSMutableArray *_alarmDataArray;
    
    NSMutableArray *_stageMeasureDataArray;//阶段性数据
    
    User *_am4User;
    NSString *thirdUserID;
    NSString *clientSDKUserName;
    NSString *clientSDKID;
    NSString *clientSDKSecret;
    BOOL modelVerifyOK;
    
    
}
@property (retain, nonatomic) NSMutableString *am4RandomString;//随机数
@property (retain, nonatomic) NSString *currentUUID;
@property (retain, nonatomic) NSString *serialNumber;
@property (retain, nonatomic) NSString *firmwareVersion;
@property (retain, nonatomic) NSNumber *battery;
@property (copy,   nonatomic) NSString *isInUpdateProcess;


-(void)commandCreateUserManageConnectWithUser:(User *)tempUser Authentication:(BlockUserAuthentication)disposeAuthenticationBlock currentUserSerialNub:(CurrentSerialNub)serialNub amUser:(DisposeAM4AskUserIDBlock)disposeAskUserID binedAMSerialNub:(DisposeBinedAMSerialNub)binedSerialnub currentSerialNub:(DisposeCurrentSerialNub)currentSerialNub DisposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;



//设置随机数
-(void)commandAM4SetRandomBlock:(DisposeAM4SetRandomBlock)disposeSetRandom disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
//绑定用户
-(void)commandSetAM4UserID:(NSNumber*)userID withRandom:(NSString *)tempRandom DisposeBlock:(DisposeAM4SetUserIDBlock)disposeBlock  DisposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
//BMR 同步时间 时间区域  查询状态信息 电池 设置个人信息
-(void)commandSyncUserInfoWithUser:(User *)tempUser andGoal:(NSNumber*)goalNumber DisposeStateInfo:(DisposeAM4StateInfoBlock)disposeStateInfo DisposeBattery:(DisposeAM4BatteryBlock)disposeBattery DisposeBlock:(DisposeAM4TimeFormatAndNationSettingBlock)disposeBlock DisposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
//设置游泳
-(void)commandAM4SetSwimmingState:(BOOL)swimmingIsOpen swimmingPoolLength:(NSNumber *)swimmingPoolLength NOSwimmingTime:(NSDate *)noSwimmingDate unit:(AM4SwimmingUnit)unit resultBlock:(DisposeAM4SettingSwimmingBlock)disposeSetSwimming disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
// 恢复出厂设置
-(void)commandAM4ResetDeviceDisposeResultBlock:(DisposeAM4ResetDeviceBlock)disposeResetDevice disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
// 查询总的闹钟信息
-(void)commandAM4QueryAlarmInfoDisposeTotoalAlarmData:(DisposeAM4TotoalAlarmData)disposeTotoalAlarmData disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
// 设置闹钟
-(void)commandAM4SetAlarmWithAlarmDictionary:(NSDictionary *)alarmDic disposeResultBlock:(DisposeAM4SetAlarmBlock)disposeSetAlarm disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
// 删除闹钟
-(void)commandAM4DeleteAlarmID:(NSNumber *)alarmID disposeResultBlock:(DisposeAM4DeleteAlarmBlock)disposeDeleteAlarm disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
// 查询提醒
-(void)commandAM4QueryReminder:(DisposeAM4RemindAM4InfoBlock)disposeRemindInfo disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
// 设置提醒
-(void)commandAM4SetReminderWithReminderDictionary:(NSDictionary *)reminderDic disposeResultBlock:(DisposeAM4SetReminderBlock)disposeSetReminder disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
// 同步实时数据,运动，睡眠
-(void)commandAM4StartSyncActiveData:(DisposeAM4ActiveStartTransmission)activeTransmission
                   activeHistoryData:(DisposeAM4ActiveHistoryData)activeHistoryData
            activeFinishTransmission:(DisposeAM4ActiveFinishTransmission)activeFinishTransmission
               startSyncAM4SleepData:(DisposeAM4SleepStartTransmission)sleepTransmission
                    sleepHistoryData:(DisposeAM4SleepHistoryData)sleepHistoryData
             sleepFinishTransmission:(DisposeAM4SleepFinishTransmission)sleepFinishTransmission
                   currentActiveInfo:(DisposeAM4QueryCurrentActiveInfo)currentActiveInfo
                   disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
//设置状态
-(void)commandAM4SetState:(AM4ActiveState)activeState disposeBlock:(DisposeAM4SetStateBlock)disposeSetState disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
//阶段性报告数据
-(void)commandAM4SetSyncsportCount:(DisposeAM4SyncSportCountBlock)disposeSyncSportCount disposeMeasureData:(DisposeAM4MeasureDataBlock)disposeMeasureData disposeFinishMeasure:(DisposeAM4WorkoutFinishBlock)disposeFinishMeasure disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;

//断开连接
-(void)commandAM4Disconnect:(DisposeAM4DisconnectBlock)disposeDisconnect disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
@end