//
//  ScoreManager.h
//  SmallStone
//
//  Created by Jamin on 9/7/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#define REPORT_CHANGE_USER_NAME_NOTIFICATION        @"__REPORT_CHANGE_USER_NAME_NOTIFICATION__"


NS_ENUM(NSInteger, ReportScoreErrorCode)
{
    kUserNameExistError  = -3,
    kSuccessfull    = 0,
};

@interface ScoreManager : NSObject



+ (ScoreManager *)defaultManager;

@property (nonatomic, readonly) NSUInteger          topLevel;       //玩家玩到的最大关卡
@property (nonatomic, readonly) NSUInteger          nextLevel;      //玩家玩的下一个关卡
@property (nonatomic, readonly) NSUInteger          totalScore;     //总分

/*
 * 保存level关卡的分数score，保存成功的同时，会上报总分
 *  @param score 分数，小于当前关卡的旧分数时，不保存
 *  @param level 关卡
 *  @return 返回是否保存成功
 */
- (BOOL)saveScore:(NSUInteger)score atLevel:(NSUInteger)level;


/*
 * 返回某一关卡的分数
 *  @param level 关卡
 */
- (NSUInteger)scoreAtLevel:(NSUInteger)level;



/*
 * 上报总分数
 */
- (void)reportTotalScore;


/*
 * 重置下一关卡，从第一关开始玩起
 */
- (void)resetNextLevel;


/*
 * 清除分数数据，删除持久化数据
 */
- (void)clearScoreData;

@end
