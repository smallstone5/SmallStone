//
//  BaseBall.m
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "BaseBall.h"
#import "GameSetting.h"

@implementation BaseBall
@synthesize speed = _speed;
@synthesize acceleration = _acceleration;
@synthesize timeScale = _timeScale;
@synthesize verticalScale = _verticalScale;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _timeScale = kDefaultTimeScale;
        _verticalScale = kDefaultVerticalScale;
    }
    return self;
}

- (void) updateData: (CFTimeInterval) delta
{
    _flyingTime += _timeScale * delta;
    CGFloat x = _speed.x * _flyingTime + _acceleration.x * _flyingTime * _flyingTime;
    CGFloat y = (_speed.y * _flyingTime - _acceleration.y * _flyingTime * _flyingTime) * _verticalScale;
    self.center = ConvertPtBottomLeftToTopLeft(CGPointMake(x, y));
}

- (void) gameDraw
{
    
}

@end
