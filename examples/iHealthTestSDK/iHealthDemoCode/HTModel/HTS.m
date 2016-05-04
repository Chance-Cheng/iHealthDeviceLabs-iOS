//
//  HTS.m
//  Contina_BP
//
//  Created by XuJianbo on 15/6/29.
//  Copyright (c) 2015年 XuJianbo. All rights reserved.
//

#import "HTS.h"
#import "BasicCommunicationObject.h"
#import "CharacteristicReader.h"

#import "IHCloud4CoreClass.h"

@interface HTS(CloudDelagete)<IHCloudSDKUserLoginDelegate,IHCloudSDKUserExistDelegate,IHCloudSDKUserCombinedDelegate,IHCloudSDKUserRegisterDelegate,IHCloudSDKDownloadPrivancyDelegate,UIAlertViewDelegate>

@end

@implementation HTS

-(id)init//初始化，添加Observer
{
    if (self=[super init]) {
        
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(_sessionDataReceived:) name:HTSContinua_Protocol object:nil];
            
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getBattary:) name:@"HTSBattary" object:nil];
        
         modelVerifyOK = false;

    }
    return self;
}


-(void)commandGetBattary:(GetHTSBattary)battary DisposeErrorBlock:(DisposeHTSErrorBlock)disposeErrorBlock{

   
    _GetHTSBattary = battary;
    
    _DisposeHTSErrorBlock = disposeErrorBlock;
    
    
//    if (modelVerifyOK == false)
//    {
//        _DisposeHTSErrorBlock(HTSUserInvalidate);
//        return;
//    }

     [[BasicCommunicationObject basicCommunicationObject] readDeviceInfo:self.currentUUID];
}


-(void)commandTestHTSWithUser:(User *)tempUser Authentication:(BlockHTSUserAuthentication)disposeAuthenticationBlock  DisposeHTSResult:(DisposeHTSResult)DisposeHTSResult DisposeErrorBlock:(DisposeHTSErrorBlock)disposeErrorBlock{

    _DisposeHTSErrorBlock=disposeErrorBlock;
    
    _BlockHTSUserAuthentication=disposeAuthenticationBlock;
    
    _DisposeHTSResult=DisposeHTSResult;

//    htsUser = tempUser;
//    clientSDKID = [tempUser.clientID copy];
//    clientSDKSecret = [tempUser.clientSecret copy];
//    clientSDKUserName = [tempUser.userID copy];
//    if(clientSDKUserName.length>0 && clientSDKID.length>0 && clientSDKSecret.length>0 && ([Cloud4CommonToolClass isValidateEmail:clientSDKUserName] || [Cloud4CommonToolClass isValidatePhone:clientSDKUserName])){
//        if(self.currentUUID.length){
//            IHCloud4CoreClass *cloudInstance = [IHCloud4CoreClass getCloudCoreClassInstance];
//            NSString *tempUserID = [NSString stringWithFormat:@"%@",clientSDKUserName];
//            if([cloudInstance commandDetectUserIsValidate:tempUserID]){
//                NSString *cloudSerialNub = [cloudInstance commandGetCloudSerialNubForUser:tempUserID];
//                thirdUserID = [cloudSerialNub copy];
//                //本地读取用户权限
//                NSString *userRight = [cloudInstance commandGetAuthenRightForUser:cloudSerialNub];
//                //判断权限内容
//                NSArray *rightArray = [userRight componentsSeparatedByString:@" "];
//                //本地包含指定权限
////                if([rightArray containsObject:@"OpenApiHTS"]){
//                
//                    [cloudInstance setConfigureInfoForThirdPartUserWithUserID:tempUserID];
//                    
//                    cloudInstance.cloudSDKUserLoginDelegate = self;
//                    [cloudInstance cloudCommandSDKUserLogin:clientSDKUserName clientID:clientSDKID clientSecret:clientSDKSecret queueNub:@1];
////                }
////                //本地存储的用户权限无指定权限,需要登录后获取最新权限
////                else{
////                    cloudInstance.cloudSDKUserLoginDelegate = self;
////                    [cloudInstance cloudCommandSDKUserLogin:clientSDKUserName clientID:clientSDKID clientSecret:clientSDKSecret queueNub:@2];
////                }
//            }
//            else{
//                cloudInstance.cloudSDKUserExistDelegate = self;
//                [cloudInstance cloudCommandSDKUserExist:clientSDKUserName clientID:clientSDKID clientSecret:clientSDKSecret queueNub:@1];
//            }
//        }
//        else{
//            if (_DisposeHTSErrorBlock!=nil) {
//                _DisposeHTSErrorBlock(HTSUserInvalidate);
//            };
//        }
//        
//    }
//    else{
//        if (_DisposeHTSErrorBlock!=nil) {
//            _DisposeHTSErrorBlock(HTSUserInvalidate);
//        };
//        
//    }


}

-(void)getBattary:(NSNotification*)notic{

    NSDictionary*dic=[notic userInfo];
    int batteryInt=[[dic valueForKey:@"Btatary"]characterAtIndex:0];
    NSNumber*battary=[NSNumber numberWithInt:batteryInt];

    if (_GetHTSBattary!=nil) {
        _GetHTSBattary(battary);
    }
}

#pragma mark--receiveData
- (void)_sessionDataReceived:(NSNotification *)notification
{
    
    
    NSData *commandData=[[notification userInfo] objectForKey:IDPS_Data];
    NSString *chracteristic=[[notification userInfo] objectForKey:IDPS_ID];
    
    uint8_t *array = (uint8_t*) commandData.bytes;
    
       int flags = [CharacteristicReader readUInt8Value:&array];
        BOOL tempInFahrenheit = (flags & 0x01) > 0;
        BOOL timestampPresent = (flags & 0x02) > 0;
        BOOL typePresent = (flags & 0x04) > 0;
        
        NSString * temperatureText = @"";
        
        float tempValue = [CharacteristicReader readFloatValue:&array];
        if (!tempInFahrenheit && 1)
        {
            tempValue = tempValue * 9.0f / 5.0f + 32.0f;
            //            temperatureText = [NSString stringWithFormat:@"Temperature: %.2f°F", tempValue];
        }
        
        float CtempValue = (tempValue - 32.0f) * 5.0f / 9.0f;
        temperatureText = [NSString stringWithFormat:@"Temperature: %.2f °F \n                       %.2f °C", tempValue,CtempValue];
        
        NSString *cTemperatureStr=[NSString stringWithFormat:@"%.2f", CtempValue];
        NSString *fTemperatureStr=[NSString stringWithFormat:@"%.2f", tempValue];
        NSString* dateFormattedStr=@"";
        
        NSLog(@"温度结果为：%@",temperatureText);
    
    NSDate* date = [CharacteristicReader readDateTime:&array];
    
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
    [dateFormater setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormater setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormater setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    
    dateFormattedStr= [dateFormater stringFromDate:[NSDate date]];
    
        /* temperature type */
        if (typePresent)
        {
            uint8_t type = [CharacteristicReader readUInt8Value:&array];
            NSString* location = nil;
            
            NSNumber*nn=[NSNumber numberWithInt:type];
            
            switch ([nn intValue])
            {
                case 0x01:
                    location = @"Armpit";
                    break;
                case 0x02:
                    location = @"Body - general";
                    break;
                case 0x03:
                    location = @"Ear";
                    break;
                case 0x04:
                    location = @"Finger";
                    break;
                case 0x05:
                    location = @"Gastro-intenstinal Tract";
                    break;
                case 0x06:
                    location = @"Mouth";
                    break;
                case 0x07:
                    location = @"Rectum";
                    break;
                case 0x08:
                    location = @"Toe";
                    break;
                case 0x09:
                    location = @"Tympanum - ear drum";
                    break;
                default:
                    location = @"Unknown";
                    break;
            }
            if (location)
            {
                temperatureText=[NSString stringWithFormat:@"%@\n\nType： %@",temperatureText,location];
            }
            NSLog(@"temperatureResult is ：%@",temperatureText);
            NSDictionary *resultDic=[NSDictionary dictionaryWithObjectsAndKeys:cTemperatureStr, @"cTemperature",fTemperatureStr, @"fTemperature",dateFormattedStr,@"timeStamp",location,@"measurePosition" ,nil];
           
            if (_DisposeHTSResult!=nil) {
                _DisposeHTSResult(resultDic);
            }
        }
        else
        {
            //            self.type.text = @"Location: n/a";
        }
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//回复用户验证错误
-(void)ackVerifyError:(UserAuthenResult)result{
    if(_BlockHTSUserAuthentication!=Nil){
        
        _BlockHTSUserAuthentication(result);
       
    }
    _DisposeHTSErrorBlock = nil;
}



//用户登陆成功
-(void)cloudSDKUserLoginSuccess:(NSString *)userID queueNub:(NSNumber *)queueNub{
    //主动请求权限
    if(queueNub.intValue == 2){
        if(userID.intValue>0){
            thirdUserID = [NSString stringWithFormat:@"%@",userID];
            
            IHCloud4CoreClass *cloudInstance = [IHCloud4CoreClass getCloudCoreClassInstance];
            //本地读取用户权限
            NSString *userRight = [cloudInstance commandGetAuthenRightForUser:userID];
            //判断权限内容
            NSArray *rightArray = [userRight componentsSeparatedByString:@" "];
            //包含指定权限
//            if([rightArray containsObject:AMSDKSleepRightApi] || [rightArray containsObject:AMSDKSportRightApi]){
//                [self startMeasureImediant:UserAuthen_LoginSuccess withSerialNub:[NSNumber numberWithInteger:userID.integerValue]];
//            }
//            //不包含指定权限
//            else{
//                [self ackVerifyError:UserAuthen_UserInvalidateRight];
//            }
        }
        else{
            [self ackVerifyError:UserAuthen_UserInvalidateRight];
        }
    }
}
//用户登陆失败
//原因：202.用户名不是邮箱203.密码不符合要求204.用户名或密码错误.206用户锁定207.用户禁用209用户不存在211.App上传的信息不完整215.SC或SV错误
-(void)cloudSDKUserLoginFailed:(NSString *)errorCode queueNub:(NSNumber *)queueNub{
    if(queueNub.intValue == 2){
        if(errorCode.intValue==223 || errorCode.intValue==224 || errorCode.intValue==216){
            [self ackVerifyError:UserAuthen_InvalidateUserInfo];
        }
        else{
            [self ackVerifyError:UserAuthen_InternetError];
        }
    }
}

//用户登陆失败--携带用户id
//原因：202.用户名不是邮箱203.密码不符合要求204.用户名或密码错误.206用户锁定207.用户禁用209用户不存在211.App上传的信息不完整215.SC或SV错误
-(void)cloudSDKUserLoginFailed:(NSString *)errorCode downloadUserID:(NSString *)downUserID queueNub:(NSNumber *)queueNub{
    if(queueNub.intValue == 2){
        if(errorCode.intValue==223 || errorCode.intValue==224 || errorCode.intValue==216){
            [self ackVerifyError:UserAuthen_InvalidateUserInfo];
        }
        else{
            [self ackVerifyError:UserAuthen_InternetError];
        }
    }
}

//原因：101.未连接网络102.网络超时103.网站异常104.非法使用接口
-(void)cloudSDKUserLoginNetWorkError:(NSString *)error userType:(IHUserType)userType queueNub:(NSNumber *)queueNub{
    if(queueNub.intValue == 2){
        [self ackVerifyError:UserAuthen_InternetError];
    }
}

//判断用户是否存在代理
#pragma mark IHCloudSDKUserExistDelegate <NSObject>
//用户存在查询结果
-(void)cloudSDKUserIsExistResult:(IHSDKUserStatus)userStatus queueNub:(NSNumber *)queueNub{
    IHCloud4CoreClass *cloudInstance = [IHCloud4CoreClass getCloudCoreClassInstance];
    switch (userStatus) {
        case IHSDKUserStatus_NotRegisteredSDK:
        {
            cloudInstance.cloudSDKUserCombinedDelegate = self;
            [cloudInstance cloudCommandSDKUserCombined:clientSDKUserName clientID:clientSDKID clientSecret:clientSDKSecret queueNub:@1];
        }
            break;
        case IHSDKUserStatus_RegisteredSDK:{
            cloudInstance.cloudSDKUserLoginDelegate = self;
            [cloudInstance cloudCommandSDKUserLogin:clientSDKUserName clientID:clientSDKID clientSecret:clientSDKSecret queueNub:@2];
        }
            break;
        case IHSDKUserStatus_NotExistiHealth:{
            //            NSUserDefaults *userDefult = [NSUserDefaults standardUserDefaults];
            //            NSNumber *priFlag = [userDefult valueForKey:@"PriFlag"];
            //            //判断隐私条款显示标示
            //            if(priFlag.intValue==0){
            //                cloudInstance.cloudSDKDownloadPriDelegate = self;
            //                [cloudInstance cloudCommandSDKDownloadPrivancyWithClientID:clientSDKID clientSecret:clientSDKSecret queueNub:@1];
            //            }
            //            else{
            [cloudInstance cloudCommandGetHostList:^(NSArray *resultArray) {
                cloudInstance.cloudSDKUserRegisterDelegate = self;
                [cloudInstance cloudCommandSDKUserRegister:clientSDKUserName clientID:clientSDKID clientSecret:clientSDKSecret queueNub:@1];
            } error:^(NSString *errorCode) {
                [self ackVerifyError:UserAuthen_InternetError];
            } queueNub:@1];
            //            }
        }
            break;
        default:
            break;
    }
}

//原因：101.未连接网络102.网络超时103.网站异常104.非法使用接口
-(void)cloudSDKUserExistNetWorkError:(NSString *)error userType:(IHUserType)userType queueNub:(NSNumber *)queueNub{
    if(error.intValue==223 || error.intValue==224 || error.intValue==216){
        [self ackVerifyError:UserAuthen_InvalidateUserInfo];
    }
    else{
        [self ackVerifyError:UserAuthen_InternetError];
    }
}


//用户合并代理
#pragma mark IHCloudSDKUserCombinedDelegate <NSObject>
//用户合并成功
-(void)cloudSDKUserCombinedSuccess:(NSDictionary *)recDic queueNub:(NSNumber *)queueNub{
    NSString *userID = [recDic valueForKey:@"ID"];
    if(userID.intValue>0){
        thirdUserID = [NSString stringWithFormat:@"%@",userID];
        
        IHCloud4CoreClass *cloudInstance = [IHCloud4CoreClass getCloudCoreClassInstance];
        //本地读取用户权限
        NSString *userRight = [cloudInstance commandGetAuthenRightForUser:userID];
        //判断权限内容
        NSArray *rightArray = [userRight componentsSeparatedByString:@" "];
        //包含指定权限
//        if([rightArray containsObject:AMSDKSleepRightApi] || [rightArray containsObject:AMSDKSportRightApi]){
//            [self startMeasureImediant:UserAuthen_CombinedSuccess withSerialNub:[NSNumber numberWithInteger:userID.integerValue]];
//        }
//        //不包含指定权限
//        else{
//            [self ackVerifyError:UserAuthen_UserInvalidateRight];
//        }
    }
    
}
//用户合并失败
//原因：
-(void)cloudSDKUserCombinedFailed:(NSString *)errorCode queueNub:(NSNumber *)queueNub{
    if(errorCode.intValue==223 || errorCode.intValue==224 || errorCode.intValue==216){
        [self ackVerifyError:UserAuthen_InvalidateUserInfo];
    }
    else{
        [self ackVerifyError:UserAuthen_InternetError];
    }
}

//原因：101.未连接网络102.网络超时103.网站异常104.非法使用接口
-(void)cloudSDKUserCombinedNetWorkError:(NSString *)error userType:(IHUserType)userType queueNub:(NSNumber *)queueNub{
    [self ackVerifyError:UserAuthen_InternetError];
}

//用户注册代理
#pragma mark IHCloudSDKUserRegisterDelegate <NSObject>
//用户注册成功
-(void)cloudSDKUserRegisterSuccess:(NSString *)userID queueNub:(NSNumber *)queueNub{
    if(userID.intValue>0){
        thirdUserID = [NSString stringWithFormat:@"%@",userID];
        
        IHCloud4CoreClass *cloudInstance = [IHCloud4CoreClass getCloudCoreClassInstance];
        //本地读取用户权限
        NSString *userRight = [cloudInstance commandGetAuthenRightForUser:userID];
        //判断权限内容
        NSArray *rightArray = [userRight componentsSeparatedByString:@" "];
        //包含指定权限
//        if([rightArray containsObject:AMSDKSleepRightApi] || [rightArray containsObject:AMSDKSportRightApi]){
//            [self startMeasureImediant:UserAuthen_RegisterSuccess withSerialNub:[NSNumber numberWithInteger:userID.integerValue]];
//        }
//        //不包含指定权限
//        else{
//            [self ackVerifyError:UserAuthen_UserInvalidateRight];
//        }
    }
}
//用户注册失败
//原因：201.用户名重复202.用户名不是邮箱203.密码不符合要求211.App上传的信息不完整215.SC或SV错误
-(void)cloudSDKUserRegisterFailed:(NSString *)errorCode queueNub:(NSNumber *)queueNub{
    if(errorCode.intValue==223 || errorCode.intValue==224 || errorCode.intValue==216){
        [self ackVerifyError:UserAuthen_InvalidateUserInfo];
    }
    else{
        [self ackVerifyError:UserAuthen_InternetError];
    }
}

//原因：101.未连接网络102.网络超时103.网站异常104.非法使用接口
-(void)cloudSDKUserRegisterNetWorkError:(NSString *)error userType:(IHUserType)userType queueNub:(NSNumber *)queueNub{
    [self ackVerifyError:UserAuthen_InternetError];
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
    
}

@end
