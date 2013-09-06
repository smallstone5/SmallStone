//
//  Stone.h
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, StoneState) {
    kStoneStateNormal,
    kStoneStateHighlighted,
    kStoneStateShaking,
    kStoneStateCleared,
    kStoneStateMax,
};


typedef struct {
    NSInteger x;
    NSInteger y;
} StoneMatrixPoint;


CG_INLINE StoneMatrixPoint
MatrixPointMake(NSInteger x, NSInteger y)
{
    StoneMatrixPoint point;
    point.x = x; point.y = y;
    return point;
}




@interface Stone : NSObject

@property (nonatomic, strong) UIColor *             color;
@property (nonatomic, assign) StoneState            state;
@property (nonatomic, assign) StoneMatrixPoint      point;      //矩阵上的位置

/*
 * 设置不同state下，石头的图片
 *  @param image 图片
 *  @param state 图片
 */
- (void)setImage:(UIImage *)image forState:(StoneState)state;

/*
 * 返回不同sate下石头的颜色
 *  @param state StoneState 石头状态
 *  @return 返回对应石头的图片
 */
- (UIImage *)imageForState:(StoneState)state;


/*
 * 返回当前状态下的image
 *  @return 
 */
- (UIImage *)currentStateImage;

@end
