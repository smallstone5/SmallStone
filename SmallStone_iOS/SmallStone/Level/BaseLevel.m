//
//  BaseLevel.m
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "BaseLevel.h"
#import "CommonType.h"
#import "BaseBall.h"

@implementation BaseLevel
@synthesize state = _state;
@synthesize ball = _ball;
@synthesize stoneWall = _stoneWall;
@synthesize ballSize = _ballSize;
@synthesize speed = _speed;
@synthesize acceleration = _acceleration;
@synthesize flyingTime = _flyingTime;
@synthesize timeScale = _timeScale;
@synthesize verticalScale = _verticalScale;
@synthesize speedScale = _speedScale;

- (id) init
{
    if (self = [super init])
    {
        _state = GS_WaitForSwipe;
    }
    
    return self;
}

- (void) updateData: (CFTimeInterval) delta
{
    _flyingTime += _timeScale * delta;
    CGFloat x = _speed.x * _speedScale.x * _flyingTime + _acceleration.x * _flyingTime * _flyingTime;
    CGFloat y = (_speed.y * _speedScale.y * _flyingTime - _acceleration.y * _flyingTime * _flyingTime) * _verticalScale;
    _ball.center = ConvertPtBottomLeftToTopLeft(CGPointMake(x, y));
}

- (void) gameDraw
{
    
}

- (void) startGame
{
    _state = GS_Start;
}

- (void) gameOver
{
    _state = GS_Loser;
}

- (void) victory
{
    _state = GS_Victory;
}

- (void) checkResult
{
    
}
@end
