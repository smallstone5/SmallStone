//
//  BaseLevel.h
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _GameState {
    GS_WaitForSwipe = 0,
    GS_Start,
    GS_Victory,
    GS_Loser,
} GameState;

@class BaseBall;
@class StoneWallView;
@interface BaseLevel : NSObject {
    GameState _state;
    BaseBall *_ball;
    StoneWallView *_stoneWall;
    CGFloat _ballSize;                  //小球大小
    CGPoint _speed;
    CGPoint _acceleration;
    double _flyingTime;
    CGFloat _timeScale;
    CGFloat _verticalScale;
    CGPoint _speedScale;
    CGFloat _checkDelay;
    CFAbsoluteTime _startTick;
    CFAbsoluteTime _endTick;
}

@property (nonatomic) GameState state;
@property (nonatomic, readonly) BaseBall *ball;
@property (nonatomic, readonly) StoneWallView *stoneWall;
@property (nonatomic) CGFloat ballSize;
@property (nonatomic) CGPoint speed;
@property (nonatomic) CGPoint acceleration;
@property (nonatomic) double flyingTime;
@property (nonatomic) CGFloat timeScale;
@property (nonatomic) CGFloat verticalScale;
@property (nonatomic) CGPoint speedScale;

- (void) updateData: (CFTimeInterval) delta;
- (void) gameDraw;
- (void) startGame;
- (void) gameOver;
- (void) victory;
- (void) checkResult;
- (BOOL) isOutOfBounds;
@end
