//
//  BPViewController.m
//  iHealthDemoCode
//
//  Created by zhiwei jing on 14-9-23.
//  Copyright (c) 2014年 zhiwei jing. All rights reserved.
//

#import "BPViewController.h"
#import "BPHeader.h"
#import "HTSHeader.h"

@interface BPViewController ()

@end

@implementation BPViewController

@synthesize currentKD926UUIDStr;

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
    
    _tipTextView.editable=NO;
    
    self.kd926OfflineDataBtn.hidden= YES;
    self.kd926EnergyBtn.hidden=YES;
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForBP3:) name:BP3ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForBP3:) name:BP3DisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForBP5:) name:BP5ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForBP5:) name:BP5DisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForBP7:) name:BP7ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForBP7:) name:BP7DisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForBP3L:) name:BP3LConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForBP3L:) name:BP3LDisConnectNoti object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForBP7S:) name:BP7SConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForBP7S:) name:BP7SDisConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForKN550BT:) name:KN550BTConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForKN550BT:) name:KN550BTDisConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForKD926:) name:KD926ConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForKD926:) name:KD926DisConnectNoti object:nil];
    
    //ABI Noti(Contains Arm and Leg)
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForABI:) name:ABIConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForABI:) name:ABIDisConnectNoti object:nil];
    //ABI Noti(Contains Arm only)
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceConnectForArm:) name:ArmConnectNoti object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(DeviceDisConnectForArm:) name:ArmDisConnectNoti object:nil];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HTSResultShow:) name:@"HTSResultShow" object:nil];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HTSBatteryLevelShow:) name:@"batteryLevelShow" object:nil];
    
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HTSBatteryLeve:) name:@"DeviceOpenSession" object:nil];
    
    [BP3Controller shareBP3Controller];
    
    [HTSController shareIHHTSController];
    
    [BP5Controller shareBP5Controller];
    [BP7Controller shareBP7Controller];
    [ABIController shareABIController];
    [BP3LController shareBP3LController];
    [BP7SController shareBP7SController];
    [KN550BTController shareKN550BTController];
    [KD926Controller shareKD926Controller];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)HTSBatteryLeve:(NSNotification*)notic{
    
    NSArray*attay=[[HTSController shareIHHTSController] getAllCurrentHTSInstace];
    
    if (attay.count>0) {
        
        HTS*hts=[attay objectAtIndex:0];
        
        User*user=[[User alloc] init];;
                
        user.clientSecret=@"2407103b306943fcb33ef2863ae84988";
        
        user.clientID=@"e8776dc12c3d4a6796a722971b1cc0b4";
        
        user.userID=@"w@w.w";
        //HTS 获取温度数据
        [hts commandTestHTSWithUser:user Authentication:^(UserAuthenResult result) {
            
            
        } DisposeHTSResult:^(NSDictionary *resetDic) {
            _tipTextView.text=[NSString stringWithFormat:@"HTS Result:%@",resetDic];
            
        } DisposeErrorBlock:^(HTSDeviceError errorID) {
            
        }];
        //HTS要电量
        [hts commandGetBattary:^(NSNumber *battary) {
            _tipTextView.text=[NSString stringWithFormat:@"%@\nHTS Battery:%@",_tipTextView.text,battary];
        } DisposeErrorBlock:^(HTSDeviceError errorID) {
            
        }];
        
    }
    
}

-(void)HTSResultShow:(NSNotification *)notify
{
    NSDictionary *tempDic = notify.object;
    
    NSString *cTemperatureStr=[tempDic objectForKey:@"cTemperature"];
    NSString *fTemperatureStr=[tempDic objectForKey:@"fTemperature"];
    NSString *timeTextStr=[tempDic objectForKey:@"timeStamp"];
    NSString *typeTextStr=[tempDic objectForKey: @"measurePosition"];
    
    _tipTextView.text=[NSString stringWithFormat:@"Temperature: %@  %@\nTime: %@\nPosition: %@ \n%@",cTemperatureStr,fTemperatureStr,timeTextStr,typeTextStr,_tipTextView.text];
    
}

-(void)HTSBatteryLevelShow:(NSNotification *)notify
{
    NSDictionary *tempDic = notify.object;
    
    NSString *batteryLevelStr=[tempDic objectForKey:@"batteryLevelShow"];
    
    _tipTextView.text=[NSString stringWithFormat:@"Battery Level: %@\n %@",batteryLevelStr,_tipTextView.text];
    
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

#pragma mark - BP3
-(void)DeviceConnectForBP3:(NSNotification *)tempNoti{
    BP3Controller *controller = [BP3Controller shareBP3Controller];
    NSArray *bpDeviceArray = [controller getAllCurrentBP3Instace];
    if(bpDeviceArray.count){
        BP3 *bpInstance = [bpDeviceArray objectAtIndex:0];
        [bpInstance commandStartMeasureWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            NSLog(@"Authentication Result:%d",result);
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
        } pressure:^(NSArray *pressureArr) {
            _tipTextView.text = [NSString stringWithFormat:@"pressureArr%@",pressureArr];
        } xiaoboWithHeart:^(NSArray *xiaoboArr) {
            
        } xiaoboNoHeart:^(NSArray *xiaoboArr) {
            
        } result:^(NSDictionary *dic) {
            NSLog(@"dic:%@",dic);
            _tipTextView.text = [NSString stringWithFormat:@"result:%@",dic];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error:%d",error);
            _tipTextView.text = [NSString stringWithFormat:@"error:%d",error];
        }];
    }
    else{
        NSLog(@"log...");
        _tipTextView.text = [NSString stringWithFormat:@"date:%@",[NSDate date]];
    }
    
}

-(void)DeviceDisConnectForBP3:(NSNotification *)tempNoti{
    NSLog(@"info:%@",[tempNoti userInfo]);
}



#pragma mark - BP3L
-(void)DeviceConnectForBP3L:(NSNotification *)tempNoti{
    BP3LController *controller = [BP3LController shareBP3LController];
    NSArray *bpDeviceArray = [controller getAllCurrentBP3LInstace];
    if(bpDeviceArray.count){
        BP3L *bpInstance = [bpDeviceArray objectAtIndex:0];
        //@"jing@30.com"
        [bpInstance commandStartMeasureWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            NSLog(@"Authentication Result:%d",result);
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
        } pressure:^(NSArray *pressureArr) {
            _tipTextView.text = [NSString stringWithFormat:@"pressureArr%@",pressureArr];
        } xiaoboWithHeart:^(NSArray *xiaoboArr) {
            
        } xiaoboNoHeart:^(NSArray *xiaoboArr) {
            
        } result:^(NSDictionary *dic) {
            NSLog(@"dic:%@",dic);
            _tipTextView.text = [NSString stringWithFormat:@"result:%@",dic];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error:%d",error);
            _tipTextView.text = [NSString stringWithFormat:@"error:%d",error];
        }];
    }
    else{
        NSLog(@"log...");
        _tipTextView.text = [NSString stringWithFormat:@"date:%@",[NSDate date]];
    }
    
}

-(void)DeviceDisConnectForBP3L:(NSNotification *)tempNoti{
    NSLog(@"info:%@",[tempNoti userInfo]);
}


#pragma mark - BP5
-(void)DeviceConnectForBP5:(NSNotification *)tempNoti{
    BP5Controller *controller = [BP5Controller shareBP5Controller];
    NSArray *bpDeviceArray = [controller getAllCurrentBP5Instace];
    if(bpDeviceArray.count){
        BP5 *bpInstance = [bpDeviceArray objectAtIndex:0];
        //@"jing@30.com"
        [bpInstance commandStartMeasureWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            NSLog(@"Authentication Result:%d",result);
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
        } pressure:^(NSArray *pressureArr) {
            _tipTextView.text = [NSString stringWithFormat:@"pressureArr%@",pressureArr];
        } xiaoboWithHeart:^(NSArray *xiaoboArr) {
            
        } xiaoboNoHeart:^(NSArray *xiaoboArr) {
            
        } result:^(NSDictionary *dic) {
            NSLog(@"dic:%@",dic);
            _tipTextView.text = [NSString stringWithFormat:@"result:%@",dic];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error:%d",error);
            _tipTextView.text = [NSString stringWithFormat:@"error:%d",error];
        }];
    }
    else{
        NSLog(@"log...");
        _tipTextView.text = [NSString stringWithFormat:@"date:%@",[NSDate date]];
    }
    
}

-(void)DeviceDisConnectForBP5:(NSNotification *)tempNoti{
    NSLog(@"info:%@",[tempNoti userInfo]);
}

#pragma mark - BP7
-(void)DeviceConnectForBP7:(NSNotification *)tempNoti{
    BP7Controller *controller = [BP7Controller shareBP7Controller];
    NSArray *bpDeviceArray = [controller getAllCurrentBP7Instace];
    if(bpDeviceArray.count){
        BP7 *bpInstance = [bpDeviceArray objectAtIndex:0];
        [bpInstance commandStartGetAngleWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
            NSLog(@"Authentication Result:%d",result);
        } angle:^(NSDictionary *dic) {
            NSLog(@"angle:%@",dic);
            _tipTextView.text = [NSString stringWithFormat:@"angle:%@",dic];
            NSNumber *angleDigital = [dic valueForKey:@"angle"];
            if(angleDigital.intValue>10 && angleDigital.intValue<30){
                [bpInstance commandStartMeasure:^(NSArray *pressureArr) {
                    
                } xiaoboWithHeart:^(NSArray *xiaoboArr) {
                    
                } xiaoboNoHeart:^(NSArray *xiaoboArr) {
                    
                } result:^(NSDictionary *dic) {
                    _tipTextView.text = [NSString stringWithFormat:@"result:%@",dic];
                    NSLog(@"dic:%@",dic);
                } errorBlock:^(BPDeviceError error) {
                    NSLog(@"error:%d",error);
                    _tipTextView.text = [NSString stringWithFormat:@"error:%d",error];
                }];
            }
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error:%d",error);
        }];
    }
    else{
        NSLog(@"log...");
        _tipTextView.text = [NSString stringWithFormat:@"date:%@",[NSDate date]];
    }
    
}

-(void)DeviceDisConnectForBP7:(NSNotification *)tempNoti{
    NSLog(@"info:%@",[tempNoti userInfo]);
}

#pragma mark - BP7S
-(void)DeviceConnectForBP7S:(NSNotification *)tempNoti{
    BP7SController *controller = [BP7SController shareBP7SController];
    NSArray *bpDeviceArray = [controller getAllCurrentBP7SInstace];
    if(bpDeviceArray.count){
        BP7S *bpInstance = [bpDeviceArray objectAtIndex:0];
        
        [bpInstance commandTransferMemoryDataWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
            NSLog(@"Authentication Result:%d",result);
        }totalCount:^(NSNumber *num){
            NSLog(@"上传总条数；%@",num);
            _tipTextView.text = [NSString stringWithFormat:@"%@\n历史数量为:%@ ",_tipTextView.text,num];
        } pregress:^(NSNumber *progress){
            _tipTextView.text = [NSString stringWithFormat:@"%@\n进度为:%@ ",_tipTextView.text,progress];
            NSLog(@"上传进度为：%@",progress);
        } dataArray:^(NSArray *array){
            
            _tipTextView.text = [NSString stringWithFormat:@"%@\n历史记录:%@ ",_tipTextView.text,array];
            NSLog(@"历史记录为：%@",array);
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error:%d",error);
        }];

        
    }
    else{
        NSLog(@"log...");
        _tipTextView.text = [NSString stringWithFormat:@"date:%@",[NSDate date]];
    }
    
}

-(void)DeviceDisConnectForBP7S:(NSNotification *)tempNoti{
    NSLog(@"info:%@",[tempNoti userInfo]);
}

#pragma mark - KN550BT
-(void)DeviceConnectForKN550BT:(NSNotification *)tempNoti{
    KN550BTController *controller = [KN550BTController shareKN550BTController];
    NSArray *bpDeviceArray = [controller getAllCurrentKN550BTInstace];
    if(bpDeviceArray.count){
        KN550BT *bpInstance = [bpDeviceArray objectAtIndex:0];
        
        [bpInstance commandTransferMemoryDataWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
            NSLog(@"Authentication Result:%d",result);
        }totalCount:^(NSNumber *num){
            NSLog(@"上传总条数；%@",num);
            _tipTextView.text = [NSString stringWithFormat:@"%@\n历史数量为:%@ ",_tipTextView.text,num];
        } pregress:^(NSNumber *progress){
            _tipTextView.text = [NSString stringWithFormat:@"%@\n进度为:%@ ",_tipTextView.text,progress];
            NSLog(@"上传进度为：%@",progress);
        } dataArray:^(NSArray *array){
            
            _tipTextView.text = [NSString stringWithFormat:@"%@\n历史记录:%@ ",_tipTextView.text,array];
            NSLog(@"历史记录为：%@",array);
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error:%d",error);
        }];
        
        
    }
    else{
        NSLog(@"log...");
        _tipTextView.text = [NSString stringWithFormat:@"date:%@",[NSDate date]];
    }
    
}

-(void)DeviceDisConnectForKN550BT:(NSNotification *)tempNoti{
    NSLog(@"info:%@",[tempNoti userInfo]);
    
    
}

#pragma mark - KD926
-(void)DeviceConnectForKD926:(NSNotification *)tempNoti{
    
    NSDictionary *infoDic = [tempNoti userInfo];
    self.currentKD926UUIDStr = [infoDic objectForKey:@"ID"];
    
    self.kd926EnergyBtn.hidden=NO;
    self.kd926OfflineDataBtn.hidden=NO;
}

-(void)DeviceDisConnectForKD926:(NSNotification *)tempNoti{
    NSLog(@"info:%@",[tempNoti userInfo]);
    NSDictionary *infoDic = [tempNoti userInfo];
    NSString *uuidString = [infoDic objectForKey:@"ID"];
     if([self.currentKD926UUIDStr isEqualToString:uuidString]){
         self.kd926OfflineDataBtn.hidden= YES;
         self.kd926EnergyBtn.hidden=YES;
     }
    
}
- (IBAction)KD926GetOfflinData:(id)sender {
    
    KD926Controller *controller = [KD926Controller shareKD926Controller];
    NSArray *bpDeviceArray = [controller getAllCurrentKD926Instace];
    if(bpDeviceArray.count){
        KD926 *bpInstance = [bpDeviceArray objectAtIndex:0];

        [bpInstance commandTransferMemoryDataWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
            NSLog(@"Authentication Result:%d",result);
        }totalCount:^(NSNumber *num){
            NSLog(@"上传总条数；%@",num);
            _tipTextView.text = [NSString stringWithFormat:@"%@\n历史数量为:%@ ",_tipTextView.text,num];
        } pregress:^(NSNumber *progress){
            _tipTextView.text = [NSString stringWithFormat:@"%@\n进度为:%@ ",_tipTextView.text,progress];
            NSLog(@"上传进度为：%@",progress);
        } dataArray:^(NSArray *array){
            
            _tipTextView.text = [NSString stringWithFormat:@"%@\n历史记录:%@ ",_tipTextView.text,array];
            NSLog(@"历史记录为：%@",array);
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error:%d",error);
        }];
        
        
    }
    else{
        NSLog(@"log...");
        _tipTextView.text = [NSString stringWithFormat:@"date:%@",[NSDate date]];
    }

    
}
- (IBAction)KD926GetEnergy:(id)sender {
    KD926Controller *controller = [KD926Controller shareKD926Controller];
    NSArray *bpDeviceArray = [controller getAllCurrentKD926Instace];
    if(bpDeviceArray.count){
        KD926 *bpInstance = [bpDeviceArray objectAtIndex:0];
        
        [bpInstance commandEnergy:^(NSNumber *energyValue) {
            _tipTextView.text = [NSString stringWithFormat:@"energyValue:%@",energyValue];
        } errorBlock:^(BPDeviceError error) {
            
        }];
    } 
}

#pragma mark - ABI
-(void)DeviceConnectForABI:(NSNotification *)tempNoti{
    ABI *abiInstance = [[ABIController shareABIController]getCurrentABIInstace];
    //Detect CurrentABIInstace
    if (abiInstance != nil) {
        
//        [abiInstance commandQueryEnergy:^(NSNumber *energyValue) {
//            NSLog(@"energyValue:%d",energyValue.integerValue);
//        } leg:^(NSNumber *energyValue) {
//            NSLog(@"energyValue:%d",energyValue.integerValue);
//        } errorBlock:^(BPDeviceError error) {
//            
//        }];
//        
//        return;
        
        [abiInstance commandStartMeasureWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
            NSLog(@"Authentication Result:%d",result);
        } armPressure:^(NSArray *pressureArr) {
            NSLog(@"armPressure:%@",pressureArr);
        } legPressure:^(NSArray *pressureArr) {
            NSLog(@"legPressure:%@",pressureArr);
        } armXiaoboWithHeart:^(NSArray *xiaoboArr) {
            NSLog(@"armXiaoboWithHeart:%@",xiaoboArr);
        } legXiaoboWithHeart:^(NSArray *xiaoboArr) {
            NSLog(@"legXiaoboWithHeart:%@",xiaoboArr);
        } armXiaoboNoHeart:^(NSArray *xiaoboArr) {
            NSLog(@"armXiaoboNoHeart:%@",xiaoboArr);
        } legXiaoboNoHeart:^(NSArray *xiaoboArr) {
            NSLog(@"legXiaoboNoHeart:%@",xiaoboArr);
        } armResult:^(NSDictionary *dic) {
            _tipTextView.text = [NSString stringWithFormat:@"armResult:%@",dic];
            NSLog(@"armResult:%@",dic);
        } legResult:^(NSDictionary *dic) {
            _tipTextView.text = [NSString stringWithFormat:@"legResult:%@",dic];
            NSLog(@"legResult:%@",dic);
        } errorBlock:^(BPDeviceError error) {
            
        }];
    }
    
}

-(void)DeviceDisConnectForABI:(NSNotification *)tempNoti{
    NSLog(@"DeviceDisConnectForABI:%@",[tempNoti userInfo]);
}

#pragma mark - Arm
-(void)DeviceConnectForArm:(NSNotification *)tempNoti{
    ABI *abiInstance = [[ABIController shareABIController]getCurrentArmInstance];
    //Detect CurrentArmInstance
    if (abiInstance != nil) {
        //query battery if need
//        [abiInstance commandQueryEnergy:^(NSNumber *energyValue) {
//            NSLog(@"energyValue:%d",energyValue.integerValue);
//        } errorBlock:^(BPDeviceError error) {
//            NSLog(@"BPDeviceError%d",error);
//        }];
        [abiInstance commandStartMeasureWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
            NSLog(@"Authentication Result:%d",result);
            //Stop ArmMeasure if need
//            [self performSelector:@selector(stopArmMeasure) withObject:nil afterDelay:10];
        } armPressure:^(NSArray *pressureArr) {
            NSLog(@"armPressure:%@",pressureArr);
        } armXiaoboWithHeart:^(NSArray *xiaoboArr) {
             NSLog(@"armXiaoboWithHeart:%@",xiaoboArr);
        } armXiaoboNoHeart:^(NSArray *xiaoboArr) {
            NSLog(@"armXiaoboNoHeart:%@",xiaoboArr);
        } armResult:^(NSDictionary *dic) {
            _tipTextView.text = [NSString stringWithFormat:@"armResult:%@",dic];
            NSLog(@"armResult:%@",dic);
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"BPDeviceError:%d",error);
        }];
    }
}

-(void)stopArmMeasure{
    ABI *abiInstance = [[ABIController shareABIController]getCurrentArmInstance];
    //Detect CurrentArmInstance
    if (abiInstance != nil) {
        [abiInstance stopABIArmMeassureBlock:^(BOOL result) {
            NSLog(@"stopABIArmMeassureBlock:%d",result);
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"BPDeviceError:%d",error);
        }];
    }
}
-(void)DeviceDisConnectForArm:(NSNotification *)tempNoti{
    
    NSLog(@"DeviceDisConnectForArm:%@",[tempNoti userInfo]);
}

- (IBAction)BPStartMeasure:(UIButton *)sender {
    
    BP3LController *controller = [BP3LController shareBP3LController];
    NSArray *bpDeviceArray = [controller getAllCurrentBP3LInstace];
    if(bpDeviceArray.count){
        BP3L *bpInstance = [bpDeviceArray objectAtIndex:0];
        //@"jing@30.com"
        [bpInstance commandStartMeasureWithUser:YourUserName clientID:SDKKey clientSecret:SDKSecret Authentication:^(UserAuthenResult result) {
            NSLog(@"Authentication Result:%d",result);
            _tipTextView.text = [NSString stringWithFormat:@"Authentication Result:%d",result];
        } pressure:^(NSArray *pressureArr) {
            _tipTextView.text = [NSString stringWithFormat:@"pressureArr%@",pressureArr];
        } xiaoboWithHeart:^(NSArray *xiaoboArr) {
            
        } xiaoboNoHeart:^(NSArray *xiaoboArr) {
            
        } result:^(NSDictionary *dic) {
            NSLog(@"dic:%@",dic);
            _tipTextView.text = [NSString stringWithFormat:@"result:%@",dic];
        } errorBlock:^(BPDeviceError error) {
            NSLog(@"error:%d",error);
            _tipTextView.text = [NSString stringWithFormat:@"error:%d",error];
        }];
    }
}


@end
