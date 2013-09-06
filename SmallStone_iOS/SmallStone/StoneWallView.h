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

@interface StoneWallView : UIView

@property (nonatomic, strong) StoneWall *               stoneWall;
@property (nonatomic, assign) CGSize                    stoneSize;

@property (nonatomic, strong) NSMutableArray *          stoneViews;
@property (nonatomic, strong) NSMutableArray *          connectedStoneViews;

/*
 * 使用石子墙初始化view
 *  @param stoneWall 石子墙
 *  @return 
 */
- (id)initWithStoneWall:(StoneWall *)stoneWall;
   
@end
