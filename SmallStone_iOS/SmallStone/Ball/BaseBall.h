//
//  BaseBall.h
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonType.h"

@interface BaseBall : UIImageView {
    CGPoint _speed;
    CGPoint _acceleration;
    double _flyingTime;
    CGFloat _timeScale;
    CGFloat _verticalScale;
}

@property (nonatomic) CGPoint speed;
@property (nonatomic) CGPoint acceleration;
@property (nonatomic) double flyingTime;
@property (nonatomic) CGFloat timeScale;
@property (nonatomic) CGFloat verticalScale;

- (void) updateData: (CFTimeInterval) delta;
- (void) gameDraw;
- (void) reset;
- (void) bomb;

@end
