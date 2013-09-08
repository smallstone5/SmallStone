//
//  GameSetting.m
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "GameSetting.h"

LevelData g_levelList[] = {
    {                               //Level1
        3,                          //stoneRow
        4,                          //stoneColumn
        1,                          //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.5f, 1.0f},               //speedScale
        kDefaultTimeScale,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
};

NSUInteger g_levelCount = sizeof(g_levelList) / sizeof(LevelData);