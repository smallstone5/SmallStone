//
//  BallProgress.h
//  SmallStone
//
//  Created by zhuochen on 13-9-8.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BallProgress : UIView {
    UIFont *_sysFont;
    CGPoint _position;
    CGFloat _ballSize;
}

@property (nonatomic) CGFloat ballSize;
- (void) gameDraw: (CGPoint) pos;

@end
