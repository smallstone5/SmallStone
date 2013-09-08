//
//  LevelManager.m
//  SmallStone
//
//  Created by song dan on 13-9-8.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "LevelManager.h"
#import "GameSetting.h"
#import "ScoreManager.h"
#import "Level1.h"
static LevelManager * __strong g_LevelManager;

@implementation LevelManager

+ (LevelManager *) sharedInstance
{
    if (g_LevelManager == nil)
        g_LevelManager = [[LevelManager alloc] init];
    
    return g_LevelManager;
}

- (id) init
{
    if (self = [super init])
    {
        
    }
    
    return self;
}

- (BaseLevel *) makeCurrentLevel
{
    NSUInteger levelIndex = [[ScoreManager defaultManager] topLevel];
    BaseLevel *level = [[Level1 alloc] initWithLevelData: &g_levelList[levelIndex]];
    level.levelIndex = MIN(g_levelCount-1, levelIndex + 1);
    return level;
}
@end
