//
//  StoneWallView.h
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoneWall.h"
#import "StoneView.h"

@class StoneWallView;

@protocol StoneWallViewDelegate <NSObject>

@optional


/*
 * wallView连接到石子stoneView时回调
 *  @param wallView 石子堆
 *  @param stoneView 石子
 */
- (void)stoneWallView:(StoneWallView *)wallView didConnectStoneView:(StoneView *)stoneView;


/*
 * wallView取消连接石子stoneView时回调
 *  @param wallView 石子堆
 *  @param stoneView 石子
 */
- (void)stoneWallView:(StoneWallView *)wallView didDisconnectStoneView:(StoneView *)stoneView;



/*
 * 消除一堆已连接石子时回调，此时可以做道具检测工作
 *  @param wallView 石子堆
 *  @param stoneViews 石子
 */
- (void)stoneWallView:(StoneWallView *)wallView didClearStoneViews:(NSArray *)stoneViews;



@end


@interface StoneWallView : UIView

@property (nonatomic, strong) StoneWall *               stoneWall;
@property (nonatomic, assign) CGSize                    stoneSize;

@property (nonatomic, strong) NSMutableArray *          stoneViews;
@property (nonatomic, strong) NSMutableArray *          connectedStoneViews;
@property (nonatomic, readonly) BOOL                    isStopped;



@property (nonatomic, weak) id<StoneWallViewDelegate>   delegate;





/*
 * 使用石子墙初始化view
 *  @param stoneWall 石子墙
 *  @return 
 */
- (id)initWithStoneWall:(StoneWall *)stoneWall;



/*
 * 重置当前stoneWallView的关卡
 */
- (void)reset;



/*
 * 停止操作，包括连接消除等操作
 */
- (void)stop;





@end
