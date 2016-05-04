//
//  BGViewController.m
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-9-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import "BGViewController.h"
#import "BGHeader.h"

@interface BGViewController ()

@end

@implementation BGViewController

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForBG1:) name:BG1ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForBG1:) name:BG1DisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForBG3:) name:BG3ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForBG3:) name:BG3DisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForBG5:) name:BG5ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForBG5:) name:BG5DisConnectNoti object:nil];
    [AudioBG1Communication audioCommunicationObject];
    [BG5Controller shareIHBg5Controller];
    [BG3Controller shareIHBg3Controller];
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
-(void)DeviceConnectForBG1:(NSNotification *)tempNoti{
    AudioBG1Communication *bgInstance = [AudioBG1Communication audioCommunicationObject];
    if(bgInstance != nil){
        [bgInstance commandCreateConnectWithUserID:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            if(result== UserAuthen_CombinedSuccess || result== UserAuthen_LoginSuccess || result== UserAuthen_RegisterSuccess || result== UserAuthen_TrySuccess){
                NSLog(@"verify success");
            }
            else{
                NSLog(@"Verify failed");
            }
        } DisposeDiscoverBGBlock:^(BOOL result) {
            NSLog(@"DisposeDiscoverBGBlock:%d",result);
        } DisposeBGIDPSBlock:^(NSDictionary *idpsDic) {
            NSLog(@"idpsDic:%@",idpsDic);
        } DisposeConnectBGBlock:^(BOOL result) {
            NSLog(@"DisposeConnectBGBlock:%d",result);
            if(result==true){
                [bgInstance commandCreateBGtestWithCode:CodeStr DisposeBGSendCodeBlock:^(BOOL sendOk) {
                    NSLog(@"DisposeBGSendCodeBlock:%d",sendOk);
                } DisposeBGStripInBlock:^(BOOL stripIn) {
                    NSLog(@"stripIn:%d",stripIn);
                } DisposeBGBloodBlock:^(BOOL blood) {
                    NSLog(@"blood:%d",blood);
                } DisposeBGResultBlock:^(NSDictionary *result) {
                    NSLog(@"result:%@",result);
                }DisposeBGStripOutBlock:^(BOOL stripOut) {
                    NSLog(@"stripOut:%d",stripOut);
                } DisposeBGErrorBlock:^(NSNumber *errorID) {
                    NSLog(@"errorID:%@",errorID);
                }];
            }
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            NSLog(@"errorID:%@",errorID);
        }];
    }
}

-(void)DeviceDisConnectForBG1:(NSNotification *)tempNoti{
    
}

-(void)DeviceConnectForBG3:(NSNotification *)tempNoti{
    _tipTextView.text = [[tempNoti userInfo]description];
    BG3 *bgInstance = [[BG3Controller shareIHBg3Controller]getCurrentBG3Instace];
    
    if(bgInstance != nil){
        [bgInstance commandCreateBG3TestModel:BGMeasureMode_Blood CodeString:CodeStr UserID:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            _tipTextView.text = [NSString stringWithFormat:@"%@\n UserAuthenResult:%d",_tipTextView.text,result];
        } DisposeBGSendCodeBlock:^(BOOL sendOk) {
            _tipTextView.text = [NSString stringWithFormat:@"%@\n sendOk:%d",_tipTextView.text,sendOk];
        } DisposeBGStripInBlock:^(BOOL stripIn) {
            _tipTextView.text = [NSString stringWithFormat:@"%@\n stripIn:%d",_tipTextView.text,stripIn];
        } DisposeBGBloodBlock:^(BOOL blood) {
            _tipTextView.text = [NSString stringWithFormat:@"%@\n blood:%d",_tipTextView.text,blood];
        } DisposeBGResultBlock:^(NSDictionary *result) {
            _tipTextView.text = [NSString stringWithFormat:@"%@\n result:%@",_tipTextView.text,result];
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            _tipTextView.text = [NSString stringWithFormat:@"%@\n errorID:%@",_tipTextView.text,errorID];
        }];
    }
    else{
        _tipTextView.text = @"Invalidate BG3 Info";
    }
}

-(void)DeviceDisConnectForBG3:(NSNotification *)tempNoti{
    
}

-(void)DeviceConnectForBG5:(NSNotification *)tempNoti{
    BG5Controller *bgController = [BG5Controller shareIHBg5Controller];
    NSArray *bgArray = [bgController getAllCurrentBG5Instace];
    
    if(bgArray.count>0){
        BG5 *bgInstance = [bgArray objectAtIndex:0];
        
        NSDictionary *codeDic = [bgInstance codeStripStrAnalysis:CodeStr];
        NSNumber *yourBottle = [codeDic valueForKey:@"BottleID"];
        
        
        [bgInstance commandInitBGSetUnit:BGUnit_mmolPL BGUserID:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            if(result== UserAuthen_CombinedSuccess || result== UserAuthen_LoginSuccess || result== UserAuthen_RegisterSuccess || result== UserAuthen_TrySuccess){
                NSLog(@"verify success");
            }
            else{
                NSLog(@"Verify failed");
            }
        } DisposeBGBottleID:^(NSNumber *bottleID) {
            //same code
            if (bottleID.integerValue == yourBottle.integerValue) {
                //read code
                [bgInstance commandReadBGCodeDic:^(NSDictionary *codeDic) {
                    NSLog(@"codeDic:%@",codeDic);
                    [self commandSendCode:bgInstance];
                } DisposeBGErrorBlock:^(NSNumber *errorID) {
                    NSLog(@"errorID:%@",errorID);
                }];
            }
            //different code
            else{
                NSLog(@"codeDic:%@",codeDic);
                [self commandSendCode:bgInstance];
            }
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            NSLog(@"errorID:%@",errorID);
        }];
    }
}

-(void)DeviceDisConnectForBG5:(NSNotification *)tempNoti{
    
}

-(void)commandSendCode:(BG5 *)bgInstance{
    NSDictionary *codeDic = [bgInstance codeStripStrAnalysis:CodeStr];
    NSNumber *yourBottle = [codeDic valueForKey:@"BottleID"];
    NSDate *yourValidDate = [codeDic valueForKey:@"DueDate"];
    NSNumber *yourRemainNub = [codeDic valueForKey:@"StripNum"];
    
    //send code
    [bgInstance commandSendBGCodeString:CodeStr bottleID:yourBottle validDate:yourValidDate remainNum:yourRemainNub DisposeBGSendCodeBlock:^(BOOL sendOk) {
        NSLog(@"send code success");
    } DisposeBGStartModel:^(BGOpenMode model) {
        NSLog(@"BGOpenMode:%d",model);
        //strip open mode
        if (model==BGOpenMode_Hand) {
            //start measure mode 0
            [bgInstance commandCreateBGtestModel:BGMeasureMode_Blood DisposeBGStripInBlock:^(BOOL stripIn) {
                NSLog(@"stripIn");
            } DisposeBGBloodBlock:^(BOOL blood) {
                NSLog(@"blood");
            } DisposeBGResultBlock:^(NSDictionary *result) {
                NSLog(@"result:%@",result);
            } DisposeBGTestModelBlock:^(BGMeasureMode model) {
                //0
                //1 blood mode
                NSLog(@"BGMeasureMode:%d",model);
            } DisposeBGErrorBlock:^(NSNumber *errorID) {
                NSLog(@"errorID:%@",errorID);
            }];
        }
        else{
            //start measure mode 1
            [bgInstance commandCreateBGtestStripInBlock:^(BOOL stripIn) {
                NSLog(@"stripIn");
            } DisposeBGBloodBlock:^(BOOL blood) {
                NSLog(@"blood");
            } DisposeBGResultBlock:^(NSDictionary *result) {
                NSLog(@"result:%@",result);
            } DisposeBGTestModelBlock:^(BGMeasureMode model) {
                //0
                //1 blood mode
                NSLog(@"BGMeasureMode:%d",model);
            } DisposeBGErrorBlock:^(NSNumber *errorID) {
                NSLog(@"errorID:%@",errorID);
            }];
        }
        
    } DisposeBGErrorBlock:^(NSNumber *errorID) {
        NSLog(@"errorID:%@",errorID);
    }];
    
}


- (IBAction)getBG5Memory:(id)sender {
    BG5Controller *bgController = [BG5Controller shareIHBg5Controller];
    NSArray *bgArray = [bgController getAllCurrentBG5Instace];
    
    if(bgArray.count>0){
        BG5 *bgInstance = [bgArray objectAtIndex:0];
        [bgInstance commandTransferMemorryData:^(NSNumber *dataCount) {
            NSLog(@"dataCount:%@",dataCount);
        } DisposeBGHistoryData:^(NSDictionary *historyDataDic) {
            NSLog(@"historyDataDic:%@",historyDataDic);
            [bgInstance commandDeleteMemorryData:^(BOOL deleteOk) {
                NSLog(@"deleteOk:%d",deleteOk);
            }];
        } DisposeBGErrorBlock:^(NSNumber *errorID) {
            NSLog(@"errorID:%@",errorID);
        }];
    }
}

@end
