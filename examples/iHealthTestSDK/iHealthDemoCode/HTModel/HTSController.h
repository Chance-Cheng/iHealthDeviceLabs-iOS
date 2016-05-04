//
//  HTSController.h
//  iHealthDemoCode
//
//  Created by daiqingquan on 16/1/5.
//  Copyright © 2016年 zhiwei jing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTSController : NSObject{
    
    NSMutableArray *btleHTSArray;
    
}

+(HTSController *)shareIHHTSController;

//Get all scale instance,use hsInstance to call HS related communication methods.

-(NSArray *)getAllCurrentHTSInstace;

//Restart search HTS
-(void)startSearchHS4;

//Stop search HTS
-(void)stopSearchHS4;


@end
