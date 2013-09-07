//
//  UserManager.h
//  SmallStone
//
//  Created by Jamin on 9/7/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserManager : NSObject


/*
 * 设置用户名称
 */
+ (void)setUserName:(NSString *)userName;

/*
 * 获取用户名称
 *  @return 
 */
+ (NSString *)userName;

/*
 * 设置总分数
 *  @param score 分数
 */
+ (void)setTotalScore:(NSUInteger)score;

/*
 * 返回总分
 *  @return 
 */
+ (NSUInteger)totalScore;

@end
