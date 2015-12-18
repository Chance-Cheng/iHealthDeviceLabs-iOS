//
//  PO3Controller.h
//  testShareCommunication
//
//  Created by daiqingquan on 13-11-29.
//  Copyright (c) 2013年 my. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PO3Controller : NSObject{
    
    NSMutableArray *PO3Array;
}

+(PO3Controller *)shareIHPO3Controller;

//Get all PO3 instance
-(NSArray *)getAllCurrentPO3Instace;

//Restart search PO3
-(void)startSearchPO3;

//Stop search PO3
-(void)stopSearchPO3;



@end
