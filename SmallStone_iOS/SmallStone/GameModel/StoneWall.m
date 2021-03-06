//
//  StoneWall.m
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "StoneWall.h"
#import "GameSetting.h"

@interface StoneWall()

@property (nonatomic, strong) NSMutableIndexSet *   matrixIndexSet;     //用于检查生产的矩阵是否有重复

@end


@implementation StoneWall



#pragma mark - Lifecycle
- (id)init
{
    self = [super init];
    if (self) {
        _stoneSize = kDefaultStoneSize;
        _stoneSpacing = kDefaultStoneSpacing;
    }

    return self;
}


#pragma mark - Public


- (void)generateRandStones:(NSUInteger)count;
{
    self.stonesCount = count;
    self.matrixIndexSet = [NSMutableIndexSet indexSet];
    NSUInteger minCount = MIN(count, self.matrixColumn * self.matrixRow);
    self.stoneList = [NSMutableArray arrayWithCapacity:minCount];
    for (NSInteger i = 0; i < minCount; i++) {
        Stone * aStone = [[Stone alloc] init];
        aStone.point = [self randNonRepeatMatrixPoint];
        aStone.size = CGSizeMake(self.stoneSize, self.stoneSize);
        [aStone setImage:[UIImage imageNamed:@"stone_blue.png"] forState:kStoneStateNormal];
        aStone.color = nil;
        [self markMatrixPoint:aStone.point];
        [self.stoneList addObject:aStone];
    }
}


- (void)reGenerateRandStones
{
    [self generateRandStones:self.stonesCount];
}


#pragma mark - Matrix
- (BOOL)isMatrixPointRepeat:(StoneMatrixPoint)point
{
    NSUInteger index = point.y * 100 + point.x;
    return [self.matrixIndexSet containsIndex:index];
}

- (void)markMatrixPoint:(StoneMatrixPoint)point
{
    NSUInteger index = point.y * 100 + point.x;
    [self.matrixIndexSet addIndex:index];
}


- (StoneMatrixPoint)randNonRepeatMatrixPoint
{
    StoneMatrixPoint point = MatrixPointMake(NSIntegerMax, NSIntegerMax);
    NSUInteger maxCheckCount = self.matrixRow * self.matrixColumn;
    do {
        NSInteger row = arc4random() % self.matrixRow;
        NSInteger column = arc4random() % self.matrixColumn;
        point = MatrixPointMake(column, row);
        --maxCheckCount;
    } while (([self isMatrixPointRepeat:point]) && maxCheckCount > 0);

    return point;
}


@end
