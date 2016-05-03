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
#define AM4EnterSwimmingTime @"EnterSwimmingTime"
#define AM4OutSwimmingTime @"OutSwimmingTime"
#define AM4SwimmingProcessMark @"SwimmingProcessMark"

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





typedef void (^DisposeAM4AskUserIDBlock)(unsigned int userID);//userID

typedef void (^DisposeAM4ErrorBlock)(AM4ErrorID errorID);//Communication error codes, see AM4 error descriptions.

typedef void (^DisposeAM4SetRandomBlock)(BOOL resetSuc);

typedef void (^DisposeAM4SyncTimeBlock)(BOOL resetSuc);//SyncTime

typedef void (^DisposeAM4TimeFormatAndNationBlock)(AM4TimeFormatAndNation  timeFormatAndNation);//dateFormatter

typedef void (^DisposeAM4TimeFormatAndNationSettingBlock)(BOOL timeFormatAndNationSetting);//setdateFormatter

typedef void (^DisposeAM4SetUserIDBlock)(BOOL resetSuc);//set user ID

typedef void (^DisposeAM4SetUserInfoBlock)(BOOL resetSuc);//set user infomation


typedef void (^DisposeAM4ActiveStartTransmission)(NSDictionary *startDataDictionary);//Start uploading motion data
typedef void (^DisposeAM4ActiveHistoryData)(NSArray *historyDataArray);//sportData
typedef void (^DisposeAM4ActiveFinishTransmission)();//Upload motion complete

typedef void (^DisposeAM4SleepStartTransmission)(NSDictionary *startDataDictionary);//Start uploading sleep data
typedef void (^DisposeAM4SleepHistoryData)(NSArray *historyDataArray);//sleepData
typedef void (^DisposeAM4SleepFinishTransmission)();//Upload sleep complete

typedef void (^DisposeAM4QueryCurrentActiveInfo)(NSDictionary *activeDictionary);//Total calories and steps for today, including parameters：Step、Calories、TotalCalories


typedef void (^DisposeAM4ResetDeviceBlock)(BOOL resetSuc);//Restore factory settings.


typedef void (^DisposeAM4TotoalAlarmData)(NSMutableArray *totoalAlarmArray);//Alarm array contains up to 3 alarms, each one needs the following parameters：AlarmId、Time、IsRepeat、Switch、（Sun、Mon、Tue、Wed、Thu、Fri、Sat)

typedef void (^DisposeAM4SetAlarmBlock)(BOOL resetSuc);//set Alarm

typedef void (^DisposeAM4DeleteAlarmBlock)(BOOL resetSuc);//delete Alarm

typedef void (^DisposeAM4RemindInfoBlock)(NSArray *remindInfo);//remind

typedef void (^DisposeAM4SetReminderBlock)(BOOL resetSuc);// set remind

typedef void (^DisposeAM4StateInfoBlock)(AM4QueryState queryState);//query State

typedef void (^DisposeAM4BatteryBlock)(NSNumber *battery);//AM battery percentage, from 0～100.

typedef void (^DisposeAM4DisconnectBlock)(BOOL resetSuc);//disconnect


typedef void (^DisposeAM4StepBlock)(NSNumber * normalStepLength, NSNumber *fastStepLength, NSNumber *slowStepLength);//query StepLength

typedef void (^DisposeAM4SetStepLengthBlock)(BOOL resetSuc);//set StepLength

typedef void (^DisposeAM4SwimmingBlock)(BOOL swimmingIsOpen, NSNumber * swimmingLaneLength,NSNumber * NOSwimmingTime, AM4SwimmingUnit unit);//query swimming

typedef void (^DisposeAM4SettingSwimmingBlock)(BOOL resetSuc);//set swimming

typedef void (^DisposeAM4QueryActiveminituesBlock)(BOOL resetSuc);//Query Activeminitues
typedef void (^DisposeAM4SettingActiveminituesBlock)(BOOL resetSuc);

typedef void (^DisposeAM4SyncSportCountBlock)(NSNumber *sportCount);//
typedef void (^DisposeAM4MeasureDataBlock)(NSArray *measureDataArray);
typedef void (^DisposeAM4WorkoutFinishBlock)(BOOL resetSuc);


typedef void (^DisposeAM4PictureBlock)(AM4Picture picture);
typedef void (^DisposeAM4SettingPictureBlock)(BOOL resetSuc);
typedef void (^DisposeAM4SetStateBlock)(BOOL resetSuc);
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
    
    
    DisposeAM4RemindInfoBlock _disposeAM4RemindInfoBlock;
    
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
    NSMutableArray *_activeDataArray;
    NSMutableArray *_sleepDataArray;
    NSMutableArray *_sleepSectionArray;
    
    NSInteger _AM4ActiveTotoalNum;
    NSInteger _AM4ActiveTimeInterval;
    BOOL _AM4ActiveStart;
    
    NSInteger _AM4SleepTotoalNum;
    NSInteger _AM4SleepTimeInterval;
    uint8_t _AM4SleepCount;
    
   
    uint8_t activeYear;
    uint8_t activeMonth;
    uint8_t activeDay;
    uint8_t activeStepSize;
    
    
    uint8_t sleepYear;
    uint8_t sleepMonth;
    uint8_t sleepDay;
    uint8_t sleepHour;
    uint8_t sleepMinute;
    uint8_t sleepSecond;
    
    
    NSInteger _totoalAlarm;
    NSInteger _alarmQueryTime;
    NSMutableArray *_alarmIDArray;
    NSMutableArray *_alarmDataArray;
    
    NSMutableArray *_stageMeasureDataArray;
    
    User *_am4User;
    NSString *thirdUserID;
    NSString *clientSDKUserName;
    NSString *clientSDKID;
    NSString *clientSDKSecret;
    BOOL modelVerifyOK;
    
    NSNumber *_sportCount;//阶段条数
    NSMutableArray *_amSportArray;
    NSMutableArray *_amSportSectionArray;
    NSMutableArray *_amSleepArray;
    NSMutableArray *_amSleepSectionArray;
    NSNumber *lastUploadSleepTS;
}
@property (retain, nonatomic) NSMutableString *am4RandomString;
@property (retain, nonatomic) NSString *currentUUID;
@property (retain, nonatomic) NSString *serialNumber;
@property (retain, nonatomic) NSString *firmwareVersion;
@property (retain, nonatomic) NSNumber *battery;
@property (copy,   nonatomic) NSString *isInUpdateProcess;



/**
 * Establish memory and measurement connection,Only after verification through this interface can we move onto using other API's.
 * @param tempUser includes properties：clientID，clientSecret，userID.userID，either email or mobile phone number (mobile phone number not yet supported).ClientID and clientSecret, the only identification for users of the SDK, requires registration from iHealth administrator, please email:lvjincan@jiuan.com for more information
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
 *  The measurement via SDK will be operated in the case of 1-3, and will be terminated if any of 4-8 occurs. The interface needs to be re-called after analyzing the return parameters.
 *  @Notice  Notice: when a new user registers via SDK, an ‘iHealth disclaimer’ will pop up automatically, and will require the user to agree in order to continue. SDK applications require an Internet connection.
 * @param serialNub Uniquely identifies the user, the SDK requires this to be stored. This ID will be sent to the AM4 and will allow the AM4 to pair with only this user.
 * @param disposeAskUserID The user ID that is stored on the AM4, 0 indicates that there is no user inf
 * @param binedSerialnub The user's AM4's MAC Address
 * @param currentSerialNub The connected user's MAC Address
 * @param disposeErrorBlock Communication error codes, see AM4 error descriptions.
 */
-(void)commandCreateUserManageConnectWithUser:(User *)tempUser Authentication:(BlockUserAuthentication)disposeAuthenticationBlock currentUserSerialNub:(CurrentSerialNub)serialNub amUser:(DisposeAM4AskUserIDBlock)disposeAskUserID binedAMSerialNub:(DisposeBinedAMSerialNub)binedSerialnub currentSerialNub:(DisposeCurrentSerialNub)currentSerialNub DisposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;





/**
 * Sending a random number,This API sends a random number to the AM4. Only when the random number matches the number displayed on the AM4 screen can the device be bound to the device.
 * @param disposeSetRandom True: Sent successfully，False: Failed。Random number is six digits, ranging from 0 – 999999. AM4 will receive the random number and display on screen. The user will have to enter it into the app.
 * @param disposeErrorBlock see AM4 error descriptions.
 */
-(void)commandAM4SetRandomBlock:(DisposeAM4SetRandomBlock)disposeSetRandom disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;


/**
 * Binding AM4 to user,Account binding requires an active internet connection.
 * @param userID userID
 * @param tempRandom the 6 random numbers displayed on the AM4。
 * @param disposeBlock YES: Binding successful, NO: Failed.
 * @param disposeErrorBlock see AM4 error descriptions.
 */
-(void)commandSetAM4UserID:(NSNumber*)userID withRandom:(NSString *)tempRandom DisposeBlock:(DisposeAM4SetUserIDBlock)disposeBlock  DisposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;



/**
 * AM4 initialization,Must be called the first time to ensure that the AM4 has correct user information, goals, time, battery checks, etc.
 * @param tempUser User information, needs to include the following：birthday、height、weight、bmr、sex、lengthUnit.birthday，NSDate.height，(cm).weight，(kg).bmr，user basal metabolic rate.sex，UserSex_Female or UserSex_Male.lengthUnit，total distance，LengthUnit_Mile is imperial units.LengthUnit_Kilometer for metric units.
 * @param goalNumber User goal number of steps. Default is 10,000
 * @param disposeStateInfo AM status，State_wrist  (AM4 being worn on the wrist)，State_waist (AM4 worn with belt clip).
 * @param disposeBattery AM battery percentage, from 0～100.
 * @param disposeBlock True: Success， False: Failed.
 * @param disposeErrorBlock see AM4 error descriptions.
 */
-(void)commandSyncUserInfoWithUser:(User *)tempUser andGoal:(NSNumber*)goalNumber DisposeStateInfo:(DisposeAM4StateInfoBlock)disposeStateInfo DisposeBattery:(DisposeAM4BatteryBlock)disposeBattery DisposeBlock:(DisposeAM4SetUserInfoBlock)disposeBlock DisposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;



/**
 * Set Swimming
 *@param swimmingIsOpen YES:open swimming function NO:close swimming function default:no
 *@param swimmingPoolLength swimming Pool Length
 *@param noSwimmingDate automatic drop out swim duration
 *@param unit swim unit
 *@param disposeSetSwimming True: Success， False: Failed.
 *@param disposeErrorBlock see AM4 error descriptions.
 */
-(void)commandAM4SetSwimmingState:(BOOL)swimmingIsOpen swimmingPoolLength:(NSNumber *)swimmingPoolLength NOSwimmingTime:(NSDate *)noSwimmingDate unit:(AM4SwimmingUnit)unit resultBlock:(DisposeAM4SettingSwimmingBlock)disposeSetSwimming disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;




/**
 * Restore factory settings.
 * @param disposeResetDevice True: Success， False: Failed.
 * @param disposeErrorBlock see AM4 error descriptions.
 */
-(void)commandAM4ResetDeviceDisposeResultBlock:(DisposeAM4ResetDeviceBlock)disposeResetDevice disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;




/**
 * Query Alarm
 * @param disposeTotoalAlarmData Alarm array contains up to 3 alarms, each one needs the following parameters：AlarmId、Time、IsRepeat、Switch、（Sun、Mon、Tue、Wed、Thu、Fri、Sat)AlarmId：1, 2, 3.Time：HH:mm.IsRepeat：Repeat alarm， True: Repeat， False: Don't repeat.Switch：Alarm on/off. True: On, False: Off.Sun、Mon、Tue、Wed、Thu、Fri、Sat：True.
 * @param disposeErrorBlock see AM4 error descriptions.
 */
-(void)commandAM4QueryAlarmInfoDisposeTotoalAlarmData:(DisposeAM4TotoalAlarmData)disposeTotoalAlarmData disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;

/**
 * Set Alarm.
 * @param alarmDic Alarm information, include parameters：AlarmId、Time、IsRepeat、Switch、（Sun、Mon、Tue、Wed、Thu、Fri、Sat)
 * @param disposeSetAlarm True: Alarm set successfully，False: Failed.
 * @param disposeErrorBlock see AM4 error descriptions.
 */
-(void)commandAM4SetAlarmWithAlarmDictionary:(NSDictionary *)alarmDic disposeResultBlock:(DisposeAM4SetAlarmBlock)disposeSetAlarm disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;



/**
 * Delete alarm.
 * @param alarmID alarmID：1, 2, 3.
 * @param disposeDeleteAlarm True: Delete successful，False: Failed
 * @param disposeErrorBlock see AM4 error descriptions.
 */
-(void)commandAM4DeleteAlarmID:(NSNumber *)alarmID disposeResultBlock:(DisposeAM4DeleteAlarmBlock)disposeDeleteAlarm disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;


/**
 * Query reminder.
 * @param disposeRemindInfo Array containing following parameters：Time、Switch.Time：format HH:mm, time between reminders (HH*60+mm) minutes.Switch：Reminder on/off，True: On， False: Off.
 * @param disposeErrorBlock see AM4 error descriptions
 */
-(void)commandAM4QueryReminder:(DisposeAM4RemindInfoBlock)disposeRemindInfo disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;


/**
 * Disconnect Set reminders.
 * @param reminderDic Array containing collowing parameters：Time、Switch。
 * @param disposeSetReminder YES: Successfully set, NO: Failed.
 * @param disposeErrorBlock see AM4 error descriptions
 */
-(void)commandAM4SetReminderWithReminderDictionary:(NSDictionary *)reminderDic disposeResultBlock:(DisposeAM4SetReminderBlock)disposeSetReminder disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;

/**
 * Upload AM4 data,Data type: 5 minutes of motion data, 5 minutes of sleep data, total number of steps for the day, and total calories. Also includes the number of steps for the 5 minutes of motion data, total calories for the current time, calories of the steps, and total calories. If calculations for every 5 minutes of motion data is required, you will need to calculate the difference between two records.
 * @param activeTransmission activeTransmission: Start uploading motion data, including parameters：StartActiveHistoryDate、StepSize、StartActiveHistoryTotoalNum.
 * @param activeHistoryData Start date，yyyy-MM-dd.StepSize：Length of each step, cm.StartActiveHistoryTotoalNum：Number of records.AM4historyData data，including the following parameters：AMDate、AMCalorie、AMStepNum.AMDate：Workout time， NSDate.AMCalorie: Current time total calories.AMStepNum：Total number of steps.
 * @param activeFinishTransmission Upload complete.
 * @param sleepTransmission Start uploading sleep data, including parameters：SleepActiveHistoryDate、StartActiveHistoryTotoalNum.SleepActiveHistoryDate：Sleep start time，yyyy-MM-dd HH:mm:ss.StartActiveHistoryTotoalNum: Number of records
 * @param sleepHistoryData Sleep data, including the following parameters:：AMDate、SleepData.AMDate：Sleep time, NSDate.SleepData: Sleep grade, 0: awake, 1: light sleep, 2: deep sleep.
 * @param sleepFinishTransmission Upload complete.
 * @param currentActiveInfo Total calories and steps for today, including parameters：Step、Calories、TotalCalories.Step：Number of steps taken today.Calories：Number of calories burned today.TotalCalories：Sum calories burned and bmr today.
 * @param disposeErrorBlock see AM4 error descriptions
 */
-(void)commandAM4StartSyncActiveData:(DisposeAM4ActiveStartTransmission)activeTransmission
                   activeHistoryData:(DisposeAM4ActiveHistoryData)activeHistoryData
            activeFinishTransmission:(DisposeAM4ActiveFinishTransmission)activeFinishTransmission
               startSyncAM4SleepData:(DisposeAM4SleepStartTransmission)sleepTransmission
                    sleepHistoryData:(DisposeAM4SleepHistoryData)sleepHistoryData
             sleepFinishTransmission:(DisposeAM4SleepFinishTransmission)sleepFinishTransmission
                   currentActiveInfo:(DisposeAM4QueryCurrentActiveInfo)currentActiveInfo
                   disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;





/**
 * Upload AM4 report data.
 * @param disposeSyncSportCount Total report number.
 * @param disposeMeasureData Report data, including parameters: ReportStage_Swimming、ReportStage_Work_out、ReportStage_Sleep_summary、ReportStage_Activeminute. Currently only supports ReportStage_Work_out、ReportStage_Sleep_summar.Workout contains properties：ReportState、Work_outMeasureDate、Work_outTimeNumber、Work_outStepNumber、Work_outLengthNumber、Work_outCalories.ReportState：ReportStage_Work_out.Work_outMeasureDate：Start time.Work_outTimeNumber：Length of workout (mins).Work_outStepNumber：Workout number of steps.Work_outLengthNumber：Workout distance (km).Work_outCalories：Workout calories burned.Sleep contains properties：ReportState、Sleep_summaryMeasureDate、Sleep_summarySleepTime、Sleep_summarysleepEfficiency、Sleep_summarysleepAddMinute.ReportState：ReportStage_Sleep_summary.Sleep_summaryMeasureDate：Sleep start time.Sleep_summarySleepTime: Sleep duration (mins).Sleep_summarysleepEfficiency：Sleep efficiency percentage, range is 0-100.Sleep_summarysleepAddMinute：Correct sleep duration length. Change the length of time from before falling asleep to add onto the time awake.
 * @param disposeFinishMeasure YES: Success，NO: Failed.
 * @param disposeErrorBlock see AM4 error descriptions
 */
-(void)commandAM4SetSyncsportCount:(DisposeAM4SyncSportCountBlock)disposeSyncSportCount disposeMeasureData:(DisposeAM4MeasureDataBlock)disposeMeasureData disposeFinishMeasure:(DisposeAM4WorkoutFinishBlock)disposeFinishMeasure disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;


/**
 * Disconnect AM4 connection.
 * @param disposeBlock  True: Success，False: Failed.
 * @param disposeErrorBlock see AM4 error descriptions
 */
-(void)commandAM4Disconnect:(DisposeAM4DisconnectBlock)disposeDisconnect disposeErrorBlock:(DisposeAM4ErrorBlock)disposeErrorBlock;
@end