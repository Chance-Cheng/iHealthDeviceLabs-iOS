//
//  HSViewController.m
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-9-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import "HSViewController.h"

#import "HSHeader.h"

@interface HSViewController ()

@end

@implementation HSViewController

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
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForHS3:) name:HS3ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForHS3:) name:HS3DisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForHS4:) name:HS4ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForHS4:) name:HS4DisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForHS5:) name:HS5ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForHS5:) name:HS5DisConnectNoti object:nil];
    [HS3Controller shareIHHs3Controller];
    [HS4Controller shareIHHs4Controller];
    [HS5Controller shareIHHs5Controller];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)DeviceConnectForHS3:(NSNotification *)tempNoti{
    HS3Controller *hsController = [HS3Controller shareIHHs3Controller];
    NSArray *hsArray = [hsController getAllCurrentHS3Instace];
    
    if(hsArray.count>0){
        HS3 *hsInstance = [hsArray objectAtIndex:0];
        User *myUser = [[User alloc]init];
        myUser.clientID = SDKKey;
        myUser.clientSecret = SDKSecret;
        myUser.userID = YourUserName;
        myUser.height = @180;
        [hsInstance commandInitWithUser:myUser Authentication:^(UserAuthenResult result) {
            NSLog(@"UserAuthenResult:%d",result);
        } TransferMemorryData:^(BOOL startTransmission) {
            NSLog(@"startTransmission:%d",startTransmission);
        } UploadDataNum:^(NSNumber *uploadDataNum) {
            NSLog(@"uploadDataNum:%ld",(long)uploadDataNum.integerValue);
        } DisposeProgress:^(float progress) {
            NSLog(@"progress:%f",progress);
        } MemorryData:^(NSDictionary *historyDataDic) {
            NSLog(@"MemorryData:%@",historyDataDic);
        } FinishTransmission:^{
            NSLog(@"FinishTransmission");
        } StableWeight:^(NSNumber *StableWeight) {
            NSLog(@"StableWeight:%@",StableWeight);
        } DisposeErrorBlock:^(HS3DeviceError errorID) {
            NSLog(@"HS3DeviceError:%d",errorID);
        }];
    }
}

-(void)DeviceDisConnectForHS3:(NSNotification *)tempNoti{
    
    
}

-(void)DeviceConnectForHS4:(NSNotification *)tempNoti{
    HS4Controller *hsController = [HS4Controller shareIHHs4Controller];
    NSArray *hsArray = [hsController getAllCurrentHS4Instace];
    
    if(hsArray.count>0){
        HS4 *hsInstance = [hsArray objectAtIndex:0];
        User *myUser = [[User alloc]init];
        myUser.clientID = SDKKey;
        myUser.clientSecret = SDKSecret;
        myUser.userID = YourUserName;
        myUser.height = @180;
        
        [hsInstance commandMeasureWithUint:HSUnit_Kg andUser:myUser Authentication:^(UserAuthenResult result) {
            NSLog(@"UserAuthenResult:%d",result);
        } Weight:^(NSNumber *unStableWeight) {
            NSLog(@"unStableWeight:%@",unStableWeight);
        } StableWeight:^(NSNumber *StableWeight) {
            NSLog(@"StableWeight:%@",StableWeight);
        } DisposeErrorBlock:^(HS4DeviceError errorID) {
            NSLog(@"HS4DeviceError:%d",errorID);
        }];
    }
    
}

- (IBAction)commandUploadHS4MemoryPressed:(id)sender {
    HS4Controller *hsController = [HS4Controller shareIHHs4Controller];
    NSArray *hsArray = [hsController getAllCurrentHS4Instace];
    
    if(hsArray.count>0){
        HS4 *hsInstance = [hsArray objectAtIndex:0];
        User *myUser = [[User alloc]init];
        myUser.clientID = SDKKey;
        myUser.clientSecret = SDKSecret;
        myUser.userID = YourUserName;
        
        [hsInstance commandTransferMemorryWithUser:myUser memoryData:^(NSDictionary *startDataDictionary) {
            NSLog(@"startDataDictionary:%@",startDataDictionary);
        } DisposeProgress:^(NSNumber *progress) {
            NSLog(@"DisposeProgress:%@",progress);
        } MemorryData:^(NSArray *historyDataArray) {
            NSLog(@"MemorryData:%@",historyDataArray);
        } FinishTransmission:^{
            NSLog(@"FinishTransmission");
        } DisposeErrorBlock:^(HS4DeviceError errorID) {
            NSLog(@"HS4DeviceError:%d",errorID);
        }];
    }
}


-(void)DeviceDisConnectForHS4:(NSNotification *)tempNoti{
    
    
}

-(void)DeviceConnectForHS5:(NSNotification *)tempNoti{
    HS5Controller *hsController = [HS5Controller shareIHHs5Controller];
    NSArray *hsArray = [hsController getAllCurrentHS5Instace];
    
    if(hsArray.count>0){
        HS5 *hsInstance = [hsArray objectAtIndex:0];
        User *myUser = [[User alloc]init];
        myUser.clientID = SDKKey;
        myUser.clientSecret = SDKSecret;
        myUser.userID = YourUserName;
        
        [hsInstance commandCreateUserManageConnectWithUser:myUser Authentication:^(UserAuthenResult result) {
            NSLog(@"UserAuthenResult:%d",result);
        } currentUserSerialNub:^(NSInteger serialNub) {
            NSLog(@"serialNub:%ld",(long)serialNub);
            myUser.serialNub = [NSNumber numberWithLong:serialNub];
            currentUser = myUser;
        } deviceUserList:^(NSArray *userListDataArray) {
            NSLog(@"userListDataArray:%@",userListDataArray);
            
            //User exist
            NSMutableArray *positionArray = [[NSMutableArray alloc]init];
            NSMutableArray *serialNubArray = [[NSMutableArray alloc]init];
            for (NSDictionary *tempInfo in userListDataArray) {
                [positionArray addObject:[tempInfo valueForKey:@"position"]];
                [serialNubArray addObject:[tempInfo valueForKey:@"serialNumber"]];
            }
            
            //Old User
            if ([serialNubArray containsObject:[NSNumber numberWithInteger:myUser.serialNub.integerValue]]) {
                //edit user
                int modifyUserInfo = 0;
                //no edit
                if (modifyUserInfo == 0) {
                    //measure
                    myUser.height = @160;
                    [self commandStartMeasure:hsInstance withUser:myUser];
                }
                //modify user
                else if(modifyUserInfo == 1){
                    myUser.height = @160;
                    myUser.sex = UserSex_Female;
                    myUser.birthday = [NSDate dateWithTimeIntervalSince1970:0];
                    myUser.isAthlete = UserIsAthelete_Yes;
                    
                    [hsInstance commandModifyUser:myUser DisposeHS5Result:^(BOOL resetSuc) {
                        NSLog(@"DisposeHS5Result:%d",resetSuc);
                        
                        //measure
                        [self commandStartMeasure:hsInstance withUser:myUser];
                        
                    } Disposehs5ErrorBlock:^(HS5DeviceError errorID) {
                        NSLog(@"HS5DeviceError:%d",errorID);
                    }];
                }
                //del user
                else if (modifyUserInfo == 2){
                    [hsInstance commandDelteUser:myUser DisposeHS5Result:^(BOOL resetSuc) {
                        NSLog(@"DisposeHS5Result:%d",resetSuc);
                    } Disposehs5ErrorBlock:^(HS5DeviceError errorID) {
                        NSLog(@"HS5DeviceError:%d",errorID);
                    }];
                }
            }
            //New User
            else{
                //validate position:0~19
                if (userListDataArray.count<20) {
                    NSMutableArray *validatePositionArray = [[NSMutableArray alloc]init];
                    for (int i=0; i<20; i++) {
                        if (![positionArray containsObject:[NSNumber numberWithInt:i]]) {
                            [validatePositionArray addObject:[NSNumber numberWithInt:i]];
                        }
                    }
                    
                    myUser.birthday = [NSDate dateWithTimeIntervalSince1970:0];
                    myUser.sex = UserSex_Male;
                    myUser.isAthlete = UserIsAthelete_Yes;
                    myUser.height = @180;
                    //create user
                    [hsInstance commandCreateUser:myUser position:[[validatePositionArray objectAtIndex:0]unsignedCharValue]  DisposeHS5Result:^(BOOL resetSuc) {
                        NSLog(@"DisposeHS5Result:%d",resetSuc);
                        
                        //measure
                        [self commandStartMeasure:hsInstance withUser:myUser];
                        
                    } Disposehs5ErrorBlock:^(HS5DeviceError errorID) {
                        NSLog(@"HS5DeviceError:%d",errorID);
                    }];
                }
                
            }
            
            //Yes
            
            
        } Disposehs5ErrorBlock:^(HS5DeviceError errorID) {
            NSLog(@"HS5DeviceError:%d",errorID);
        }];
    }
    
}

-(void)commandStartMeasure:(HS5 *)hsInstance withUser:(User *)tempUser{
    //measure
    [hsInstance commandCreateMeasureWithUser:tempUser unStableWeight:^(NSNumber *unStableWeight){
        NSLog(@"unStableWeight:%@",unStableWeight);
    } MeasureWeight:^(NSNumber *StableWeight) {
        NSLog(@"StableWeight:%@",StableWeight);
    } ImpedanceType:^(NSNumber *ImpedanceWeight) {
        NSLog(@"ImpedanceWeight:%@",ImpedanceWeight);
    } BodyCompositionMeasurements:^(NSDictionary *BodyCompositionInforDic) {
        NSLog(@"BodyCompositionInforDic:%@",BodyCompositionInforDic);
    } Disposehs5ErrorBlock:^(HS5DeviceError errorID) {
        NSLog(@"HS5DeviceError:%d",errorID);
    }];
    
}


- (IBAction)commandUploadHS5MemoryPressed:(id)sender {
    HS5Controller *hsController = [HS5Controller shareIHHs5Controller];
    NSArray *hsArray = [hsController getAllCurrentHS5Instace];
    
    if(hsArray.count>0 && currentUser!=nil){
        HS5 *hsInstance = [hsArray objectAtIndex:0];
        
        [hsInstance commandCreateMemoryWithUser:currentUser uploadConnect:^(BOOL resetSuc) {
            NSLog(@"uploadConnect:%d",resetSuc);
        } TransferMemorryData:^(BOOL startHS5Transmission) {
            NSLog(@"startHS5Transmission:%d",startHS5Transmission);
        } DisposeProgress:^(NSNumber *progress) {
            NSLog(@"DisposeProgress:%@",progress);
        } MemorryData:^(NSDictionary *historyDataDic) {
            NSLog(@"MemorryData:%@",historyDataDic);
        } FinishTransmission:^(BOOL finishHS5Transmission) {
            NSLog(@"FinishTransmission:%d",finishHS5Transmission);
        } Disposehs5ErrorBlock:^(HS5DeviceError errorID) {
            NSLog(@"HS5DeviceError:%d",errorID);
        }];
        
    }
}


-(void)DeviceDisConnectForHS5:(NSNotification *)tempNoti{
    
    
}


- (IBAction)commandDataCloud:(id)sender {
    [[HS5Controller shareIHHs5Controller]getDownloadDataFromCloud:^(NSArray *dataArray) {
        NSLog(@"getDownloadDataFromCloud:%@",dataArray);
    }];
    
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

@end
