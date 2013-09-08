//
//  Level1.m
//  SmallStone
//
//  Created by song dan on 13-9-7.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "Level1.h"
#import "BaseBall.h"
#import "StoneWallView.h"

@implementation Level1

- (id) initWithLevelData: (LevelData *) data
{
    if (self = [super init])
    {
        _ballSize = 40.0f;
        _acceleration = data->acceleration;
        
        _timeScale = data->timeScale;
        _verticalScale = data->verticalScale;
        _speedScale = data->speedScale;
        _stoneCount = data->stoneCount;
        _minPlayTime = kStoneTapScale * (_stoneCount + 1);
        _maxScore = kScoreScale * (_stoneCount + 1) * (_speedScale.x / kMinSpeedScale) * (_speedScale.x / kMinSpeedScale);
        
        //创建小球
        _ball = [[BaseBall alloc] initWithFrame: CGRectMake(0.0f, 0.0f, _ballSize, _ballSize)];
        _startPos = CGPointMake(_ballSize/2, _ballSize/2);
        _ball.center = ConvertPtBottomLeftToTopLeft(_startPos);
        _ball.image = [UIImage imageNamed: @"ball"];
        _ball.animationImages = [NSArray arrayWithObjects:
                                 [UIImage imageNamed: @"Bomb0"],
                                 [UIImage imageNamed: @"Bomb1"],
                                 [UIImage imageNamed: @"Bomb2"],
                                 [UIImage imageNamed: @"Bomb3"],
                                 [UIImage imageNamed: @"Bomb4"],
                                 [UIImage imageNamed: @"Bomb5"],
                                 [UIImage imageNamed: @"Bomb6"],nil];
        _ball.animationDuration = 0.8f;
        _ball.animationRepeatCount = 1;
        
        
        //创建石头
        StoneWall * wall = [[StoneWall alloc] init];
        wall.matrixRow = data->stoneRow;
        wall.matrixColumn = data->stoneColumn;
        [wall generateRandStones:_stoneCount];
        
        _stoneWall = [[StoneWallView alloc] initWithStoneWall:wall];
        _stoneWall.frame = CGRectMake((g_rcScreen.size.width - _stoneWall.frame.size.width)/2,
                                      g_rcScreen.size.height - _stoneWall.frame.size.height,
                                      _stoneWall.frame.size.width, _stoneWall.frame.size.height);
    }
    
    return self;
}

- (void) updateData: (CFTimeInterval) delta
{
    [super updateData: delta];
    
}

- (void) startGame
{
    [super startGame];
    [self.stoneWall resume];
}

- (void) restartGame
{
    [super restartGame];
    _ball.center = ConvertPtBottomLeftToTopLeft(CGPointMake(_ballSize/2, _ballSize/2));
    _ball.image = [UIImage imageNamed: @"ball.png"];
}

- (void) gameOver
{
    [super gameOver];
    [_stoneWall stop];
    [_ball bomb];
}

- (void) victory
{
    [super victory];
    [_stoneWall stop];
    [_ball bomb];
}

- (void) checkResult
{
    [super checkResult];
    
}

- (void) dealloc
{
    NSLog(@"Level dealloc\n");
}

@end
