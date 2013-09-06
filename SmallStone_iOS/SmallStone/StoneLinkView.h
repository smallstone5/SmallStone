//
//  StoneLinkView.h
//  SmallStone
//
//  该界面用于画石头间的连线
//  Created by Jamin on 9/6/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoneLinkView : UIView


/*
 * 画线连接到point
 *  @param point 下一个连接的point
 */
- (void)connectLinkToPoint:(CGPoint)point;


/*
 * 取消连接point
 *  @param point 需要取消的point
 */
- (void)disconnectLinkPoint:(CGPoint)point;



/*
 * 擦掉所有的连线
 */
- (void)clear;

@end
