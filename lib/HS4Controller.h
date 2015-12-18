//
//  HS4Controller.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-12-2.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HS4Controller : NSObject{
    NSMutableArray *btleHS4Array;
    NSMutableArray *updateDeviceArray;
}

+(HS4Controller *)shareIHHs4Controller;

//Get all scale instance,use hsInstance to call HS related communication methods.

-(NSArray *)getAllCurrentHS4Instace;

//Restart search HS4/S
-(void)startSearchHS4;

//Stop search HS4/S
-(void)stopSearchHS4;

@end
