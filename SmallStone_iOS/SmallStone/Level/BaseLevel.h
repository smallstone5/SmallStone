//
//  BaseLevel.h
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseBall;
@interface BaseLevel : NSObject {
    CGFloat _ballSize;
}

@property (nonatomic) CGFloat ballSize;

- (BaseBall *) createBall;
- (void) resetBall: (BaseBall *) ball;

@end
