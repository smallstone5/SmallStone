//
//  GameSetting.h
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kMinSwipeDistance               100.0f                      //Swipe手势最短检测距离（平方）
#define kMaxTapDistance                 1200.0f                      //小球中心到点击点距离的平方
#define kMinSwipeTime                   0.1f                        //Swipe手势最短检测时间
#define kSmallBallSize                  28.0f                       //小球size
#define kBigBallSize                    40.0f                       //大球size
#define kDefaultTimeScale               0.08f                       //时间系数
#define kDefaultVerticalScale           4.0f                        //垂直高度放大系数


#define kDefaultStoneSize               36.0f                       //石子的大小
#define kDefaultStoneSpacing            4.0f                        //石子间的空隙
#define kMinSpeedScale                  0.5f                        //最小速度放大系数
#define kScoreScale                     1000                        //分数放大系数
#define kStoneTapScale                  0.3f                        //单个石头预估时间

typedef struct _LevelData {
    NSInteger stoneRow;
    NSInteger stoneColumn;
    NSInteger stoneCount;
    CGPoint acceleration;
    CGPoint speedScale;
    CGFloat timeScale;
    CGFloat verticalScale;
} LevelData;

extern LevelData g_levelList[];
extern NSUInteger g_levelCount;
