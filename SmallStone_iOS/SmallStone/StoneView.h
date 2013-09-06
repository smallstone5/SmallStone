//
//  StoneView.h
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Stone.h"


@interface StoneView : UIImageView


@property (nonatomic, strong) Stone *       stone;
@property (nonatomic, readwrite) StoneState    state;


/*
 * 使用stone进行初始化
 *  @param stone 石子
 *  @return 
 */
- (id)initWithStone:(Stone *)stone;






@end
