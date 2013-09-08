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

@property (nonatomic, assign) NSUInteger            matrixRow;          //矩阵的行数
@property (nonatomic, assign) NSUInteger            matrixColumn;       //矩阵的列数
@property (nonatomic, assign) NSUInteger            stonesCount;        //石子的总数
@property (nonatomic, strong) NSMutableArray *      stoneList;          //石子列表
@property (nonatomic, assign) CGFloat               stoneSize;          //石子的大小
@property (nonatomic, assign) CGFloat               stoneSpacing;       //石子间的空隙


/*
 * 根据count、matrixRow、matrixColumn 随机生成stoneList
 *  @param count 生成多少个石头，count需要小或等于matrixRow*matrixColumn
 */
- (void)generateRandStones:(NSUInteger)count;


/*
 * 重新再随机生成
 */
- (void)reGenerateRandStones;

@end
