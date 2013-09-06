//
//  StoneWall.h
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stone.h"


@interface StoneWall : NSObject

@property (nonatomic, assign) NSUInteger            matrixRow;
@property (nonatomic, assign) NSUInteger            matrixColumn;
@property (nonatomic, readonly) NSUInteger          stonesCount;
@property (nonatomic, strong) NSMutableArray *      stoneList;


/*
 * 根据count、matrixRow、matrixColumn 随机生成stoneList
 *  @param count 生成多少个石头，count需要小或等于matrixRow*matrixColumn
 */
- (void)generateRandStones:(NSUInteger)count;

@end
