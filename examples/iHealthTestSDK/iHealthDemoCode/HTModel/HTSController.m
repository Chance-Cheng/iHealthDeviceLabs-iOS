//
//  HTSController.m
//  iHealthDemoCode
//
//  Created by daiqingquan on 16/1/5.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import "HTSController.h"

#import "MacroFile.h"

#import "HTS.h"

#import "BasicCommunicationObject.h"

@implementation HTSController

static HTSController *htsController = nil;

-(id)init{
    if(self=[super init]){
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceHTSDisconnected:) name:DeviceDisconnect object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deviceHTSConnected:) name:DeviceOpenSession object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(clearDeviceArray) name: BTPowerOff object:nil];
        
        [[BasicCommunicationObject basicCommunicationObject]startSearchBTLEDevice:BtleType_HTS];
    }
    btleHTSArray = [[NSMutableArray alloc]init];
    
    return self;
}


+(HTSController *)shareIHHTSController{
    if(htsController==nil){
        
        htsController = [[HTSController alloc]init];
    }
    return htsController;
}

//蓝牙关闭后清除实例对象
-(void)clearDeviceArray{
    double delayInSeconds = 0.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if(btleHTSArray.count>0){
            [btleHTSArray removeAllObjects];
        }
    });
}

#pragma mark 获取当前所有HTS实例
-(NSArray *)getAllCurrentHTSInstace{
  
    return btleHTSArray;
}

#pragma mark 设备断开
-(void)deviceHTSDisconnected:(NSNotification *)tempNoti{
    double delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        NSDictionary *infoDic = [tempNoti userInfo];
        NSString *uuidString = [infoDic objectForKey:IDPS_ID];
        for(__strong HTS *tempBtleHTS in btleHTSArray){
            if([uuidString isEqualToString:tempBtleHTS.currentUUID]){
                
                    [btleHTSArray removeObject:tempBtleHTS];
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"HTSDisConnectNoti" object:self userInfo:infoDic];
                    break;
            
            }
        }
    });
}

#pragma mark 设备接入
-(void)deviceHTSConnected:(NSNotification *)tempNoti{
    NSDictionary *infoDic = [tempNoti userInfo];
    NSString *uuidString = [infoDic objectForKey:IDPS_ID];
    NSString *deviceName=[infoDic objectForKey:@"DeviceName"];
    NSString *serialNumber = [infoDic objectForKey:IDPS_SerialNumber];
    NSString *firmwareVersion=[infoDic objectForKey:IDPS_FirmwareVersion];
    if (![deviceName isEqualToString:@"MAB40B"]) {
        
        return;
    }
    
    BOOL findResut = false;
    for(HTS *tempBtleHTS in btleHTSArray){
        if([uuidString isEqualToString:tempBtleHTS.currentUUID]){
            findResut = true;
            
                tempBtleHTS.firmwareVersion=[firmwareVersion copy];
                tempBtleHTS.currentUUID=[uuidString copy];
                tempBtleHTS.deviceID=[serialNumber copy];
            
            break;
        }
    }
    if(findResut==false){
        HTS *btleHtsObject = [[HTS alloc]init];
        btleHtsObject.currentUUID = [uuidString copy];
        btleHtsObject.deviceID = [serialNumber copy];
        btleHtsObject.firmwareVersion=[firmwareVersion copy];
        [btleHTSArray addObject:btleHtsObject];
        [[NSNotificationCenter defaultCenter]postNotificationName:DeviceConnect object:self userInfo:infoDic];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"HTSConnectNoti" object:self userInfo:infoDic];
    }
}


//Restart search HTS
-(void)startSearchHTS{
    [[BasicCommunicationObject basicCommunicationObject]startSearchBTLEDevice:BtleType_HTS];
}

//Stop search HTS
-(void)stopSearchHTS{
    [[BasicCommunicationObject basicCommunicationObject]stopSearchBTLEDevice:BtleType_HTS];
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}



@end
