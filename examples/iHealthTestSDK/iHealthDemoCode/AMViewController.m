//
//  AMViewController.m
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-9-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import "AMViewController.h"

@interface AMViewController ()

@end

@implementation AMViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tempIsAM3S = YES;
    
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForAM3:) name:AM3ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForAM3:) name:AM3DisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForAM3S:) name:AM3SConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForAM3S:) name:AM3SDisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForAM3S:) name:AM4ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForAM3S:) name:AM4DisConnectNoti object:nil];
    
    
    
//    [AM3Controller shareIHAM3Controller];
    [[AM3SController shareIHAM3SController]commandSetYourDeviceID:@"004D3202F2A0"];
//    [[AM3SController shareIHAM3SController]commandCanConnectOtherDevice:YES];
    [[AM4Controller shareIHAM4Controller]commandCanConnectOtherDevice:YES];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - AM3

-(void)DeviceConnectForAM3:(NSNotification *)tempNoti{
    AM3Controller *amController = [AM3Controller shareIHAM3Controller];
    [amController commandCanConnectAM:NO];
    NSArray *amArray = [amController getAllCurrentAM3Instace];
    
    if(amArray.count==1){
        AM3 *amInstance = [amArray objectAtIndex:0];
        tempAM3Instance = amInstance;
        User *myUser = [[User alloc]init];
        myUser.clientID = SDKKey;
        myUser.clientSecret = SDKSecret;
        myUser.userID = YourUserName;
        __block NSInteger yourUserSerialNub = 0;
        __block NSInteger amUserSerialNub = 0;
        __block NSString *yourBinedAMSerialNub = nil;
        [amInstance commandCreateUserManageConnectWithUser:myUser Authentication:^(UserAuthenResult result) {
            NSLog(@"UserAuthenResult:%d",result);
        } currentUserSerialNub:^(NSInteger serialNub) {
            NSLog(@"serialNub:%ld",(long)serialNub);
            yourUserSerialNub = serialNub;
        } amUser:^(unsigned int userID) {
            
            NSLog(@"userID:%d",userID);
            amUserSerialNub = userID;
            
        } binedAMSerialNub:^(NSString *binedSerialNub) {
            
            NSLog(@"binedSerialNub:%@",binedSerialNub);
            yourBinedAMSerialNub = binedSerialNub;
            
        } currentSerialNub:^(NSString *currentSerialNub) {
            NSLog(@"currentSerialNub:%@",currentSerialNub);
            //Your am
            if (yourUserSerialNub == amUserSerialNub) {
                //Your have more than one am, this is old one.
                if (yourBinedAMSerialNub.length>0 && ![yourBinedAMSerialNub isEqualToString:currentSerialNub]) {
                    //You should reset am , then use it again.
                    [amInstance commandResetDeviceDisposeResultBlock:^(BOOL resetSuc) {
                        
                        //connect other am
                        [amController commandCanConnectAM:YES];
                        
                    } DisposeErrorBlock:^(AMErrorID errorID) {
                        
                    }];
                }
                else{
                    //Your current am
                    NSInteger action = 1;
                    if (action == 0) {
                        //update userInfo
                        [self commandUpdateUserInfo:myUser forAM:amInstance];
                    }
                    else if(action == 1){
                        //upload sport data and sleep  data
                        [amInstance commandSyncAllAMData:^(NSDictionary *startDataDictionary) {
                            NSLog(@"startDataDictionary:%@",startDataDictionary);
                        } DisposeProgress:^(NSNumber *progress) {
                            NSLog(@"DisposeProgress:%@",progress);
                        } historyData:^(NSArray *historyDataArray) {
                            NSLog(@"historyData:%@",historyDataArray);
                        } FinishTransmission:^{
                            NSLog(@"FinishTransmission");
                        } startsleepdata:^(NSDictionary *startDataDictionary) {
                            NSLog(@"startsleepdata:%@",startDataDictionary);
                        } DisposeSleepProgress:^(NSNumber *progress) {
                            NSLog(@"DisposeProgress:%@",progress);
                        } sleephistoryData:^(NSArray *historyDataArray) {
                            NSLog(@"historyData:%@",historyDataArray);
                        } FinishSleepTransmission:^{
                            NSLog(@"FinishSleepTransmission");
                        } CurrentActiveInfo:^(NSDictionary *activeDictionary) {
                            NSLog(@"CurrentActiveInfo:%@",activeDictionary);
                        } DisposeErrorBlock:^(AMErrorID errorID) {
                            NSLog(@"AMErrorID:%d",errorID);
                        } AM3IsOnTransmission:^(BOOL isTransmiting) {
                            ;
                        } SleepIsOnTransmission:^(BOOL isTransmiting) {
                            ;
                        }];
                    }
                }
            }
            //new am
            else if(amUserSerialNub == 0){
                [amInstance commandsetAM3UserID:[NSNumber numberWithLong:yourUserSerialNub] DisposeBlock:^(BOOL resetSuc) {
                    NSLog(@"Bined user:%d",resetSuc);
                    if (resetSuc == true) {
                        //update userInfo
                        [self commandUpdateUserInfo:myUser forAM:amInstance];
                    }
                } DisposeErrorBlock:^(AMErrorID errorID) {
                    NSLog(@"Bined user error:%d",errorID);
                }];
            }
            //not your am, disconnect
            else{
                [amInstance commandDisconnectDisposeBlock:^(BOOL resetSuc) {
                    NSLog(@"commandDisconnectDisposeBlock:%d",resetSuc);
                    
                    //connect other am
                    [amController commandCanConnectAM:YES];
                    
                } DisposeErrorBlock:^(AMErrorID errorID) {
                    
                }];
            }
            
        } DisposeErrorBlock:^(AMErrorID errorID) {
            NSLog(@"AMErrorID:%d",errorID);
        }];
        
    }
}

-(void)commandUpdateUserInfo:(User *)myUser forAM:(AM3 *)amInstance{
    myUser.birthday = [NSDate dateWithTimeIntervalSince1970:0];
    myUser.sex = UserSex_Male;
    myUser.height = @165;
    myUser.weight = @55;
    myUser.bmr = @120;
    myUser.lengthUnit = LengthUnit_Mile;
    [amInstance commandSyncUserInfoWithUser:myUser andGoal:@1000 DisposeStateInfo:^(QueryAM3State queryState) {
        NSLog(@"QueryAM3State:%d",queryState);
    } DisposeBattery:^(NSNumber *battery) {
        NSLog(@"battery:%@",battery);
    } DisposeBlock:^(BOOL resetSuc) {
        NSLog(@"resetSuc:%d",resetSuc);
    } DisposeErrorBlock:^(AMErrorID errorID) {
        NSLog(@"AMErrorID:%d",errorID);
    }];
}

-(void)DeviceDisConnectForAM3:(NSNotification *)tempNoti{
    
    
}

- (IBAction)AM3_ClockQuery:(id)sender {
    if (tempAM3Instance != nil) {
        [tempAM3Instance commandQueryAlarmInfo:^(NSMutableArray *totoalAlarmArray) {
            NSLog(@"totoalAlarmArray:%@",totoalAlarmArray);
            
            //set clock
            NSDictionary *tempClockDic = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"AlarmId",@1,@"Sun",@"17:45",@"Time",@1,@"IsRepeat",@1,@"Switch",nil];
            [tempAM3Instance commandSetAlarmWithAlarmDictionary:tempClockDic DisposeResultBlock:^(BOOL resetSuc) {
                NSLog(@"DisposeResultBlock:%d",resetSuc);
            } DisposeErrorBlock:^(AMErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
            
        } DisposeErrorBlock:^(AMErrorID errorID) {
            NSLog(@"AMErrorID:%d",errorID);
        }];
    }
}

- (IBAction)AM3_ReminderQuery:(id)sender {
    if (tempAM3Instance != nil) {
        [tempAM3Instance commandQueryReminder:^(NSArray *remindInfo) {
            NSLog(@"remindInfo:%@",remindInfo);
            
            NSDictionary *tempReminderDic = [NSDictionary dictionaryWithObjectsAndKeys:@"00:01",@"Time",@1,@"Switch",nil];
            //Set reminder
            
            [tempAM3Instance commandSetReminderwithReminderDictionary:tempReminderDic DisposeResultBlock:^(BOOL resetSuc) {
                NSLog(@"DisposeResultBlock:%d",resetSuc);
            } DisposeErrorBlock:^(AMErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
        } DisposeErrorBlock:^(AMErrorID errorID) {
            NSLog(@"AMErrorID:%d",errorID);
        }];
    }
}

- (IBAction)AM3_Reset:(id)sender {
    if (tempAM3Instance != nil) {
        [tempAM3Instance commandResetDeviceDisposeResultBlock:^(BOOL resetSuc) {
            NSLog(@"ResetDevic:%d",resetSuc);
        } DisposeErrorBlock:^(AMErrorID errorID) {
            NSLog(@"AMErrorID:%d",errorID);
        }];
    }
}


#pragma mark - AM3S

-(void)DeviceConnectForAM3S:(NSNotification *)DeviceName{
    
    NSString *deviceName = [[DeviceName userInfo] objectForKey:@"DeviceName"];
    
    if ([deviceName isEqualToString:@"AM3S"])
    {
        tempIsAM3S = YES;
        AM3SController *amController = [AM3SController shareIHAM3SController];
        NSArray *amArray = [amController getAllCurrentAM3SInstace];
        
        if(amArray.count==1){
            AM3S *amInstance = [amArray objectAtIndex:0];
            tempAM3SInstance = amInstance;
            User *myUser = [[User alloc]init];
            myUser.clientID = SDKKey;
            myUser.clientSecret = SDKSecret;
            myUser.userID = YourUserName;
            __block NSInteger yourUserSerialNub = 0;
            __block NSInteger amUserSerialNub = 0;
            __block NSString *yourBinedAMSerialNub = nil;
            [amInstance commandCreateUserManageConnectWithUser:myUser Authentication:^(UserAuthenResult result) {
                NSLog(@"UserAuthenResult:%d",result);
            } currentUserSerialNub:^(NSInteger serialNub) {
                NSLog(@"serialNub:%ld",(long)serialNub);
                yourUserSerialNub = serialNub;
                tempCloudUserSerialNub = serialNub;
            } amUser:^(unsigned int userID) {
                NSLog(@"userID:%d",userID);
                amUserSerialNub = userID;
                
            } binedAMSerialNub:^(NSString *binedSerialNub) {
                NSLog(@"binedSerialNub:%@",binedSerialNub);
                yourBinedAMSerialNub = binedSerialNub;
            } currentSerialNub:^(NSString *currentSerialNub) {
                NSLog(@"currentSerialNub:%@",currentSerialNub);
                
                //Your am
                if (yourUserSerialNub == amUserSerialNub) {
                    //Your have more than one am, this is old one.
                    if (yourBinedAMSerialNub.length>0 && ![yourBinedAMSerialNub isEqualToString:currentSerialNub]) {
                        //You should reset am , then use it again.
                        [amInstance commandResetDeviceDisposeResultBlock:^(BOOL resetSuc) {
                            
                        } DisposeErrorBlock:^(AM3SErrorID errorID) {
                            
                        }];
                    }
                    else{
                        NSInteger action = 1;
                        if (action == 0) {
                            //update userInfo
                            [self commandUpdateUserInfo:myUser forAM3S:amInstance];
                        }
                        else if(action == 1){
                            //upload sport data and sleep  data
                            [amInstance commandSyncAllAM3SData:^(NSDictionary *startDataDictionary) {
                                NSLog(@"startDataDictionary:%@",startDataDictionary);
                            } DisposeProgress:^(NSNumber *progress) {
                                NSLog(@"DisposeProgress:%@",progress);
                            } historyData:^(NSArray *historyDataArray) {
                                NSLog(@"historyData:%@",historyDataArray);
                            } FinishTransmission:^{
                                NSLog(@"FinishTransmission");
                            } startsleepdata:^(NSDictionary *startDataDictionary) {
                                NSLog(@"startsleepdata:%@",startDataDictionary);
                            } DisposeSleepProgress:^(NSNumber *progress) {
                                NSLog(@"DisposeProgress:%@",progress);
                            } sleephistoryData:^(NSArray *historyDataArray) {
                                NSLog(@"historyData:%@",historyDataArray);
                            } FinishSleepTransmission:^{
                                NSLog(@"FinishSleepTransmission");
                            } CurrentActiveInfo:^(NSDictionary *activeDictionary) {
                                NSLog(@"CurrentActiveInfo:%@",activeDictionary);
                                //Upload report
                                
                                [self commandUploadReportForAM3S:amInstance];
                                
                            } DisposeErrorBlock:^(AM3SErrorID errorID) {
                                NSLog(@"AMErrorID:%d",errorID);
                            } AM3SIsOnTransmission:^(BOOL isTransmiting) {
                                ;
                            } SleepIsOnTransmission:^(BOOL isTransmiting) {
                                ;
                            }];
                        }
                    }
                }
                //new am or other persion's am
                //not your am, send randomString, then read randomString from AM, bined user again
                else{
                    [amInstance commandSetRandomString:^(BOOL resetSucSetting) {
                        NSLog(@"resetSucSetting:%d",resetSucSetting);
                        //read randomString from AM, bined user again
                        //.....- (IBAction)AM3S_BinedUser:(id)sender
                        
                    } DisposeErrorBlock:^(AM3SErrorID errorID) {
                        NSLog(@"AMErrorID:%d",errorID);
                    }];
                }
                
            } DisposeErrorBlock:^(AM3SErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
            
        }

    }
    else if([deviceName isEqualToString:@"AM4"])
    {
        tempIsAM3S = NO;
        AM4Controller *amController = [AM4Controller shareIHAM4Controller];
        NSArray *amArray = [amController getAllCurrentAM4Instace];
        
        if(amArray.count==1){
            AM4 *amInstance = [amArray objectAtIndex:0];
            tempAM4Instance = amInstance;
            User *myUser = [[User alloc]init];
            myUser.clientID = SDKKey;
            myUser.clientSecret = SDKSecret;
            myUser.userID = YourUserName;
            __block NSInteger yourUserSerialNub = 0;
            __block NSInteger amUserSerialNub = 0;
            __block NSString *yourBinedAMSerialNub = nil;
            [amInstance commandCreateUserManageConnectWithUser:myUser Authentication:^(UserAuthenResult result) {
                NSLog(@"UserAuthenResult:%d",result);
            } currentUserSerialNub:^(NSInteger serialNub) {
                NSLog(@"serialNub:%ld",(long)serialNub);
                yourUserSerialNub = serialNub;
                tempCloudUserSerialNub = serialNub;
            } amUser:^(unsigned int userID) {
                NSLog(@"userID:%d",userID);
                amUserSerialNub = userID;
                
            } binedAMSerialNub:^(NSString *binedSerialNub) {
                NSLog(@"binedSerialNub:%@",binedSerialNub);
                yourBinedAMSerialNub = binedSerialNub;
            } currentSerialNub:^(NSString *currentSerialNub) {
                NSLog(@"currentSerialNub:%@",currentSerialNub);
                
                //Your am
                if (yourUserSerialNub == amUserSerialNub) {
                    //Your have more than one am, this is old one.
                    if (yourBinedAMSerialNub.length>0 && ![yourBinedAMSerialNub isEqualToString:currentSerialNub]) {
                        //You should reset am , then use it again.
                        [amInstance commandAM4ResetDeviceDisposeResultBlock:^(BOOL resetSuc) {
                            
                        } disposeErrorBlock:^(AM4ErrorID errorID) {
                            
                        }];
                    }
                    else{
                        NSInteger action = 0;
                        if (action == 0) {
                            //update userInfo
                            [self commandUpdateUserInfo:myUser forAM4:amInstance];
                            [amInstance commandAM4SetSwimmingState:YES swimmingPoolLength:@110 NOSwimmingTime:[NSDate date] unit:AM4SwimmingUnit_km resultBlock:^(BOOL resetSuc) {
                                
                            } disposeErrorBlock:^(AM4ErrorID errorID) {
                                
                            }];
                        }
                        else if(action == 1){
                            //upload sport data and sleep  data
                            
                            [amInstance commandAM4StartSyncActiveData:^(NSDictionary *startDataDictionary) {
                                NSLog(@"startDataDictionary:%@",startDataDictionary);
                            } activeHistoryData:^(NSArray *historyDataArray) {
                                NSLog(@"historyData:%@",historyDataArray);
                            } activeFinishTransmission:^{
                                NSLog(@"FinishTransmission");
                            } startSyncAM4SleepData:^(NSDictionary *startDataDictionary) {
                                NSLog(@"startsleepdata:%@",startDataDictionary);
                            } sleepHistoryData:^(NSArray *historyDataArray) {
                                NSLog(@"historyData:%@",historyDataArray);
                            } sleepFinishTransmission:^{
                                NSLog(@"FinishSleepTransmission");
                            } currentActiveInfo:^(NSDictionary *activeDictionary) {
                                NSLog(@"CurrentActiveInfo:%@",activeDictionary);

                                //Upload report
                                [self commandUploadReportForAM4:amInstance];
                                
                            } disposeErrorBlock:^(AM4ErrorID errorID) {
                                NSLog(@"AMErrorID:%d",errorID);
                            }];
                        }
                    }
                }
                //new am or other persion's am
                //not your am, send randomString, then read randomString from AM, bined user again
                else{
                    [amInstance commandAM4SetRandomBlock:^(BOOL resetSuc) {
                        NSLog(@"resetSucSetting:%d",resetSuc);
                        //read randomString from AM, bined user again
                        //.....- (IBAction)AM3S_BinedUser:(id)sender
                    } disposeErrorBlock:^(AM4ErrorID errorID) {
                        NSLog(@"AMErrorID:%d",errorID);
                    }];
                }
                
            } DisposeErrorBlock:^(AM4ErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
            
        }
    }
}

- (IBAction)AM3S_BinedUser:(id)sender {
    
    [self.randomTextField resignFirstResponder];

    if (tempIsAM3S == YES)
    {
        if (tempAM3SInstance != nil) {
            [tempAM3SInstance commandSetAM3SUserID:[NSNumber numberWithLong:tempCloudUserSerialNub] withRandom:self.randomTextField.text DisposeBlock:^(BOOL resetSuc) {
                NSLog(@"Bined user:%d",resetSuc);
            } DisposeErrorBlock:^(AM3SErrorID errorID) {
                NSLog(@"Bined user error:%d",errorID);
            }];
        }

    }
    else if(tempIsAM3S == NO)
    {
        if (tempAM4Instance != nil) {
            
            [tempAM4Instance commandSetAM4UserID:[NSNumber numberWithLong:tempCloudUserSerialNub] withRandom:self.randomTextField.text DisposeBlock:^(BOOL resetSuc) {
                NSLog(@"Bined user:%d",resetSuc);
            } DisposeErrorBlock:^(AM4ErrorID errorID) {
                NSLog(@"Bined user error:%d",errorID);
            }];
        }

    }
}


-(void)DeviceDisConnectForAM3S:(NSNotification *)tempNoti{
    
    if(tempIsAM3S == YES)
    {
        tempAM3SInstance = nil;
    }
    else if(tempIsAM3S == NO)
    {
        tempAM4Instance = nil;
    }
}


-(void)commandUpdateUserInfo:(User *)myUser forAM3S:(AM3S *)amInstance{
    myUser.birthday = [NSDate dateWithTimeIntervalSince1970:0];
    myUser.sex = UserSex_Male;
    myUser.height = @165;
    myUser.weight = @55;
    myUser.bmr = @120;
    myUser.lengthUnit = LengthUnit_Kilometer;
    [amInstance commandSyncUserInfoWithUser:myUser andGoal:@30 DisposeStateInfo:^(QueryAM3SState queryState) {
        NSLog(@"QueryAM3State:%d",queryState);
    } DisposeBattery:^(NSNumber *battery) {
        NSLog(@"battery:%@",battery);
    } DisposeBlock:^(BOOL resetSuc) {
        NSLog(@"resetSuc:%d",resetSuc);
    } DisposeErrorBlock:^(AM3SErrorID errorID) {
        NSLog(@"AMErrorID:%d",errorID);
    }];
}
-(void)commandUploadReportForAM3S:(AM3S *)amInstance{
    [amInstance commandSetSyncsportCount:^(NSNumber *sportCount) {
        NSLog(@"sportCount:%@",sportCount);
    } DisposeMeasureData:^(NSArray *measureDataArray) {
        NSLog(@"measureDataArray:%@",measureDataArray);
    } disposeFinishMeasure:^(BOOL finishUpload) {
        NSLog(@"finishUpload:%d",finishUpload);
    } DisposeErrorBlock:^(AM3SErrorID errorID) {
        NSLog(@"AMErrorID:%d",errorID);
    }];
}


- (IBAction)AM3S_ClockQuery:(id)sender {
    
    if (tempIsAM3S == YES)
    {
        if (tempAM3SInstance != nil) {
            [tempAM3SInstance commandQueryAlarmInfo:^(NSMutableArray *totoalAlarmArray) {
                NSLog(@"totoalAlarmArray:%@",totoalAlarmArray);
                
                //set clock
                NSDictionary *tempClockDic = [NSDictionary dictionaryWithObjectsAndKeys:@2,@"AlarmId",@1,@"Sun",@"16:45",@"Time",@1,@"IsRepeat",@1,@"Switch",nil];
                [tempAM3SInstance commandSetAlarmWithAlarmDictionary:tempClockDic DisposeResultBlock:^(BOOL resetSuc) {
                    NSLog(@"DisposeResultBlock:%d",resetSuc);
                } DisposeErrorBlock:^(AM3SErrorID errorID) {
                    NSLog(@"AMErrorID:%d",errorID);
                }];
                
            } DisposeErrorBlock:^(AM3SErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
        }
    }
    else if(tempIsAM3S == NO)
    {
        if (tempAM4Instance != nil)
        {
            [tempAM4Instance commandAM4QueryAlarmInfoDisposeTotoalAlarmData:^(NSMutableArray *totoalAlarmArray) {
                NSLog(@"totoalAlarmArray:%@",totoalAlarmArray);
                
                //set clock
                NSDictionary *tempClockDic = [NSDictionary dictionaryWithObjectsAndKeys:@2,@"AlarmId",@1,@"Sun",@"16:45",@"Time",@1,@"IsRepeat",@1,@"Switch",nil];
                
                [tempAM4Instance commandAM4SetAlarmWithAlarmDictionary:tempClockDic disposeResultBlock:^(BOOL resetSuc) {
                    NSLog(@"DisposeResultBlock:%d",resetSuc);
                } disposeErrorBlock:^(AM4ErrorID errorID) {
                    NSLog(@"AMErrorID:%d",errorID);
                }];
            } disposeErrorBlock:^(AM4ErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
        }
    }
    
    
}

- (IBAction)AM3S_ReminderQuery:(id)sender {
    
    if (tempIsAM3S == YES)
    {
        if (tempAM3SInstance != nil) {
            [tempAM3SInstance commandQueryReminder:^(NSArray *remindInfo) {
                NSLog(@"remindInfo:%@",remindInfo);
                
                NSDictionary *tempReminderDic = [NSDictionary dictionaryWithObjectsAndKeys:@"00:01",@"Time",@1,@"Switch",nil];
                //Set reminder
                
                [tempAM3SInstance commandSetReminderwithReminderDictionary:tempReminderDic DisposeResultBlock:^(BOOL resetSuc) {
                    NSLog(@"DisposeResultBlock:%d",resetSuc);
                } DisposeErrorBlock:^(AM3SErrorID errorID) {
                    NSLog(@"AMErrorID:%d",errorID);
                }];
            } DisposeErrorBlock:^(AM3SErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
        }
    }
    else if (tempIsAM3S == NO)
    {
        if (tempAM4Instance != nil)
        {
            [tempAM4Instance commandAM4QueryReminder:^(NSArray *remindInfo) {
                NSLog(@"remindInfo:%@",remindInfo);
                
                NSDictionary *tempReminderDic = [NSDictionary dictionaryWithObjectsAndKeys:@"00:01",@"Time",@1,@"Switch",nil];
                //Set reminder
                
                [tempAM4Instance commandAM4SetReminderWithReminderDictionary:tempReminderDic disposeResultBlock:^(BOOL resetSuc) {
                    NSLog(@"DisposeResultBlock:%d",resetSuc);
                } disposeErrorBlock:^(AM4ErrorID errorID) {
                    NSLog(@"AMErrorID:%d",errorID);
                }];
            } disposeErrorBlock:^(AM4ErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
        }
    }
    
}

- (IBAction)AM3S_Reset:(id)sender {
    
    if (tempIsAM3S == YES)
    {
        if (tempAM3SInstance != nil) {
            [tempAM3SInstance commandResetDeviceDisposeResultBlock:^(BOOL resetSuc) {
                NSLog(@"ResetDevic:%d",resetSuc);
            } DisposeErrorBlock:^(AM3SErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
        }
    }
    else if(tempIsAM3S == NO)
    {
        if (tempAM4Instance != nil) {
            
            [tempAM4Instance commandAM4ResetDeviceDisposeResultBlock:^(BOOL resetSuc) {
                NSLog(@"ResetDevic:%d",resetSuc);

            } disposeErrorBlock:^(AM4ErrorID errorID) {
                NSLog(@"AMErrorID:%d",errorID);
            }];
        }
    }
    
   
}
- (IBAction)touchBackgroundPressed:(id)sender {
    [self.randomTextField resignFirstResponder];
}


#pragma mark- AM4
-(void)commandUpdateUserInfo:(User *)myUser forAM4:(AM4 *)amInstance{
    myUser.birthday = [NSDate dateWithTimeIntervalSince1970:0];
    myUser.sex = UserSex_Male;
    myUser.height = @165;
    myUser.weight = @55;
    myUser.bmr = @120;
    myUser.lengthUnit = LengthUnit_Kilometer;
    
    [amInstance commandSyncUserInfoWithUser:myUser andGoal:@30 DisposeStateInfo:^(AM4QueryState queryState) {
        NSLog(@"QueryAM3State:%d",queryState);
    } DisposeBattery:^(NSNumber *battery) {
        NSLog(@"battery:%@",battery);
    } DisposeBlock:^(BOOL timeFormatAndNationSetting) {
        NSLog(@"resetSuc:%d",timeFormatAndNationSetting);
    } DisposeErrorBlock:^(AM4ErrorID errorID) {
        NSLog(@"AMErrorID:%d",errorID);
    }];
}
-(void)commandUploadReportForAM4:(AM4 *)amInstance{
    
    [amInstance commandAM4SetSyncsportCount:^(NSNumber *sportCount) {
        NSLog(@"sportCount:%@",sportCount);
        
    } disposeMeasureData:^(NSArray *measureDataArray) {
        NSLog(@"measureDataArray:%@",measureDataArray);
        
    } disposeFinishMeasure:^(BOOL resetSuc) {
        NSLog(@"finishUpload:%d",resetSuc);
    } disposeErrorBlock:^(AM4ErrorID errorID) {
        NSLog(@"AMErrorID:%d",errorID);
    }];
}
@end
