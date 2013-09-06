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
@synthesize flyingTime = _flyingTime;
@synthesize timeScale = _timeScale;
@synthesize verticalScale = _verticalScale;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
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

- (void) reset
{
    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [super touchesBegan: touches withEvent: event];
    if ([self.delegate respondsToSelector: @selector(ballDidTapped:)])
        [self.delegate ballDidTapped: self];
    [self startAnimating];
}

- (void) dealloc
{
    self.delegate = nil;
}

@end
