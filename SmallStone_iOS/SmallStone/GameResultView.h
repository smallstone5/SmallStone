//
//  GameResultView.h
//  SmallStone
//
//  Created by Jamin on 9/7/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameResultView : UIView

@property (nonatomic, strong) UIImageView *     backgroundView;
@property (nonatomic, strong) UILabel *         resultLabel;
@property (nonatomic, strong) UILabel *         scoreLabel;

@property (nonatomic, strong) UIButton *        backToMainButton;       //返回主界面
@property (nonatomic, strong) UIButton *        restartButton;          //重新开始
@property (nonatomic, strong) UIButton *        nextLevelButton;        //下一关


+ (GameResultView *)resultView;


/*
 * 在containerView上展示结果
 *  @param score 分数，正数为成功，负数为失败
 *  @param containerView 父view
 */
- (void)showScore:(NSUInteger)score onView:(UIView *)containerView;



/*
 * 隐藏结果界面
 */
- (void)hideResultView;

@end
