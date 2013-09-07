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
#import "StoneWallView.h"

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
@synthesize score = _score;
@synthesize checkDelay = _checkDelay;

- (id) init
{
    if (self = [super init])
    {
        _state = GS_WaitForSwipe;
        _checkDelay = 1.0f;
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
    _startTick = CFAbsoluteTimeGetCurrent();
}

- (void) restartGame
{
    _state = GS_WaitForSwipe;
    _speed = CGPointMake(0.0f, 0.0f);
    _flyingTime = 0.0f;
    _startTick = 0.0f;
    _endTick = 0.0f;
    _score = 0;
    [_stoneWall reset];
}

- (void) gameOver
{
    _state = GS_Loser;
    _endTick = CFAbsoluteTimeGetCurrent();
    [self performSelector: @selector(checkResult) withObject: nil afterDelay: _checkDelay];
}

- (void) victory
{
    _state = GS_Victory;
    _endTick = CFAbsoluteTimeGetCurrent();
    [self performSelector: @selector(checkResult) withObject: nil afterDelay: _checkDelay];
}

- (void) checkResult
{
    _ball.center = ConvertPtBottomLeftToTopLeft(CGPointMake(-_ballSize/2, -_ballSize/2));
    
    if (_state == GS_Victory)
    {
        //成功,计算分数
        NSLog(@"Duration: %f\n", _endTick - _startTick);
        _score = (NSInteger)(_minPlayTime * _maxScore / (_endTick - _startTick));
    }
    else if (_state == GS_Loser)
    {
        //失败
        _score = -1;
    }
}

- (BOOL) isOutOfBounds
{
    CGPoint ballCenter = _ball.center;
    return (ballCenter.x > g_rcScreen.size.width + _ballSize || ballCenter.y > g_rcScreen.size.height + _ballSize);
}
@end
