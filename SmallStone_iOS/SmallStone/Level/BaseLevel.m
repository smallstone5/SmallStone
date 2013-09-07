//
//  BaseLevel.m
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "BaseLevel.h"

@implementation BaseLevel
@synthesize ballSize = _ballSize;
@synthesize acceleration = _acceleration;

- (BaseBall *) createBall
{
    return nil;
}

- (void) resetBall: (BaseBall *) ball
{
    
}

- (StoneWallView *) createStoneWall
{
    return nil;
}
@end
