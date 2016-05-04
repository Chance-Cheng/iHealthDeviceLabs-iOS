//
//  POViewController.m
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-9-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import "POViewController.h"
#import "POHeader.h"

@interface POViewController ()

@end

@implementation POViewController

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForPO3:) name:PO3ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForPO3:) name:PO3DisConnectNoti object:nil];
    [PO3Controller shareIHPO3Controller];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)DeviceDisConnectForPO3:(NSNotification *)info
{
    
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
-(void)DeviceConnectForPO3:(NSNotification*)info
{
    PO3Controller *po3Controller = [PO3Controller shareIHPO3Controller];
    NSArray *po3Array = [po3Controller getAllCurrentPO3Instace];
    
    if(po3Array.count>0)
    {
        PO3 *po3Instance = [po3Array objectAtIndex:0];
        User *myUser = [[User alloc]init];
        
        myUser.clientID = SDKKey;
        myUser.clientSecret = SDKSecret;
        myUser.userID = YourUserName;
        
        NSLog(@"成功=====================");
    }
}



- (IBAction)ScanPO3:(UIButton*)sender {
    
    PO3Controller *po3Controller = [PO3Controller shareIHPO3Controller];
    NSArray *po3Array = [po3Controller getAllCurrentPO3Instace];
    User *myUser = [[User alloc]init];
    
    PO3 *po3Instance;
    if(po3Array.count>0)
    {
        po3Instance = [po3Array objectAtIndex:0];
        
        myUser.clientID = SDKKey;
        myUser.clientSecret = SDKSecret;
        myUser.userID = YourUserName;
    }
    
    
    switch (sender.tag)
    {
        case 0:
        {
            NSLog(@"在线");
            [po3Instance commandStartPO3MeasureData:^(BOOL startData) {
                NSLog(@"startData---%d",startData);
                
            } Measure:^(NSDictionary *measureDataDic) {
                
                NSLog(@"measureDataDic---%@",measureDataDic);
                
                self.tipTextView.text =[NSString stringWithFormat:@"%@",measureDataDic];
                
            } FinishPO3MeasureData:^(BOOL finishData) {
                NSLog(@"finishData---%d",finishData);
                
            } DisposeErrorBlock:^(PO3ErrorID errorID) {
                NSLog(@"errorID---%d",errorID);
                
            }];
        }
            break;
        case 1:
        {
            NSLog(@"离线");
            
            [po3Instance commandDisposePO3DataCount:^(NSNumber *dataCount) {
                NSLog(@"dataCount---%d",[dataCount intValue]);
                
            } TransferMemorryData:^(BOOL startData) {
                NSLog(@"startData---%d",startData);
                
            } Memory:^(NSDictionary *historyDataDic) {
                NSLog(@"historyDataDic---%@",historyDataDic);
                
            } DisposePO3WaveHistoryData:^(NSDictionary *waveHistoryDataDic) {
                NSLog(@"waveHistoryDataDic---%@",waveHistoryDataDic);
                
            } DisposeProgress:^(NSNumber *progress) {
                NSLog(@"progress---%@",progress);
                
            } FinishTransmission:^(BOOL finishData) {
                NSLog(@"finishData---%d",finishData);
                
            } DisposeErrorBlock:^(PO3ErrorID errorID) {
                NSLog(@"errorID---%d",errorID);
                
            }];
            
        }
            break;
        case 2:
        {
            NSLog(@"电量");
            
            [po3Instance commandQueryBatteryInfo:^(BOOL resetSuc) {
                NSLog(@"resetSuc---%d",resetSuc);
                
            } DisposeErrorBlock:^(PO3ErrorID errorID) {
                NSLog(@"errorID---%d",errorID);
                
            } DisposeBattery:^(NSNumber *battery) {
                NSLog(@"battery---%d",battery.intValue);
                
            }];
        }
            break;
        case 3:
        {
            NSLog(@"出厂");
            [po3Instance commandResetPO3DeviceDisposeResultBlock:^(BOOL resetSuc) {
                NSLog(@"resetSuc---%d",resetSuc);
                
            } DisposeErrorBlock:^(PO3ErrorID errorID) {
                NSLog(@"errorID---%d",errorID);
                
            }];
        }
            break;
        case 4:
        {
            NSLog(@"时间");
            [po3Instance commandCreatePO3User:myUser Authentication:^(UserAuthenResult result) {
                NSLog(@"UserAuthenResult---%d——————",result);
                
            } DisposeResultBlock:^(BOOL finishSynchronous) {
                NSLog(@"finishSynchronous---%d",finishSynchronous);
                
            } DisposeErrorBlock:^(PO3ErrorID errorID) {
                NSLog(@"errorID---%d",errorID);
                
            }];
        }
            break;
        case 5:
        {
            NSLog(@"断开");
            
            [po3Instance commandEndPO3CurrentConnect:^(BOOL resetSuc) {
                NSLog(@"resetSuc---%d",resetSuc);
                
            } DisposeErrorBlock:^(PO3ErrorID errorID) {
                NSLog(@"errorID---%d",errorID);
                
            }];
        }
            break;
            
        default:
            break;
    }
    
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
