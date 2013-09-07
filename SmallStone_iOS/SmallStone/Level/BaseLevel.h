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
    CGFloat _ballSize;                  //小球大小
    CGPoint _acceleration;
    
}

@property (nonatomic) CGFloat ballSize;
@property (nonatomic) CGPoint acceleration;

- (BaseBall *) createBall;
- (void) resetBall: (BaseBall *) ball;

@end
