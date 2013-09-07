//
//  Level1.m
//  SmallStone
//
//  Created by song dan on 13-9-7.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "Level1.h"
#import "BaseBall.h"

@implementation Level1

- (id) init
{
    if (self = [super init])
    {
        _ballSize = 40.0f;
        _acceleration = CGPointMake(0.0f, 10000.0f);
    }
    
    return self;
}

- (BaseBall *) createBall
{
    BaseBall *ball = [[BaseBall alloc] initWithFrame: CGRectMake(0.0f, 0.0f, _ballSize, _ballSize)];
    ball.center = ConvertPtBottomLeftToTopLeft(CGPointMake(-_ballSize/2, -_ballSize/2));
    ball.image = [UIImage imageNamed: @"ball.png"];
    ball.animationImages = [NSArray arrayWithObjects:
                            [UIImage imageNamed: @"Bomb0.png"],
                            [UIImage imageNamed: @"Bomb1.png"],
                            [UIImage imageNamed: @"Bomb2.png"],
                            [UIImage imageNamed: @"Bomb3.png"],
                            [UIImage imageNamed: @"Bomb4.png"],
                            [UIImage imageNamed: @"Bomb5.png"],
                            [UIImage imageNamed: @"Bomb6.png"],nil];
    ball.animationDuration = 1.0f;
    ball.animationRepeatCount = 1;
    return ball;
}

- (void) resetBall: (BaseBall *) ball
{
    ball.image = [UIImage imageNamed: @"ball.png"];
}
@end
