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
    
    {                               //Level2
        3,                          //stoneRow
        4,                          //stoneColumn
        2,                          //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.5f, 1.0f},               //speedScale
        kDefaultTimeScale,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level3
        3,                          //stoneRow
        4,                          //stoneColumn
        3,                          //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.5f, 1.0f},               //speedScale
        kDefaultTimeScale,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level4
        3,                          //stoneRow
        4,                          //stoneColumn
        4,                          //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.5f, 1.0f},               //speedScale
        kDefaultTimeScale,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level5
        3,                          //stoneRow
        4,                          //stoneColumn
        5,                          //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.6f, 1.0f},               //speedScale
        kDefaultTimeScale,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level6
        4,                          //stoneRow
        5,                          //stoneColumn
        6,                          //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.6f, 1.0f},               //speedScale
        kDefaultTimeScale,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level7
        4,                          //stoneRow
        5,                          //stoneColumn
        7,                          //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.6f, 1.0f},               //speedScale
        kDefaultTimeScale,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level8
        4,                          //stoneRow
        5,                          //stoneColumn
        8,                          //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.7f, 1.0f},               //speedScale
        0.09,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level9
        4,                          //stoneRow
        5,                          //stoneColumn
        9,                          //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.7f, 1.0f},               //speedScale
        0.1,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level10
        4,                          //stoneRow
        5,                          //stoneColumn
        10,                         //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {0.7f, 1.0f},               //speedScale
        0.1,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level11
        4,                          //stoneRow
        5,                          //stoneColumn
        6,                         //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {1.0f, 1.0f},               //speedScale
        0.1,          //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level12
        4,                          //stoneRow
        5,                          //stoneColumn
        7,                         //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {1.0f, 1.0f},               //speedScale
        0.1,                        //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level13
        4,                          //stoneRow
        5,                          //stoneColumn
        8,                         //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {1.0f, 1.0f},               //speedScale
        0.1,                        //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level14
        4,                          //stoneRow
        5,                          //stoneColumn
        9,                         //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {1.0f, 1.0f},               //speedScale
        0.1,                        //timeScale
        kDefaultVerticalScale       //verticalScale
    },
    
    {                               //Level15
        4,                          //stoneRow
        5,                          //stoneColumn
        10,                         //stoneCount
        {0.0f, 8000.0f},            //acceleration
        {1.0f, 1.0f},               //speedScale
        0.1,                        //timeScale
        kDefaultVerticalScale       //verticalScale
    },
};

NSUInteger g_levelCount = sizeof(g_levelList) / sizeof(LevelData);