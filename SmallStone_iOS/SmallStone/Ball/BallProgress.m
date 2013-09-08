//
//  BallProgress.m
//  SmallStone
//
//  Created by zhuochen on 13-9-8.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "BallProgress.h"
#import "CommonType.h"

@implementation BallProgress
@synthesize ballSize = _ballSize;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _sysFont = [UIFont systemFontOfSize: 10];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder: aDecoder])
    {
        _sysFont = [UIFont systemFontOfSize: 10];
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [@"x" drawAtPoint: CGPointMake(0, 0) withFont: _sysFont];
    [@"y" drawAtPoint: CGPointMake(0, 12) withFont: _sysFont];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor redColor] set];
    CGRect rcProgress = CGRectMake( 15, 0, self.bounds.size.width - 15, 10);
    CGRect rcX = rcProgress, rcY = rcProgress;
    CGFloat px = 1 - _position.x / (g_rcScreen.size.width + _ballSize / 2);
    rcX.size.width *=  px < 0 ? 0 : px;
    
    CGFloat py = (g_rcScreen.size.height - _position.y + _ballSize / 2) / (g_rcScreen.size.height + _ballSize / 2);
    rcY.origin.y = 12;
    rcY.size.width *= py < 0 ? 0 : py;
    
    CGContextFillRect(context, rcX);
    CGContextFillRect(context, rcY);
}

- (void) gameDraw: (CGPoint) pos
{
    _position = pos;
    [self setNeedsDisplay];
}

@end
