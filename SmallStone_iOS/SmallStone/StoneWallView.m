//
//  StoneWallView.m
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "StoneWallView.h"


static CGSize const kStoneSize = {44, 44};
static CGFloat const kStoneSpacing = 4.0f;

@implementation StoneWallView


#pragma mark - Lifecycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}



- (id)initWithStoneWall:(StoneWall *)stoneWall
{
    CGFloat width = stoneWall.matrixColumn * (kStoneSize.width + kStoneSpacing);
    CGFloat height = stoneWall.matrixRow * (kStoneSize.height + kStoneSpacing);
    CGRect frame = CGRectMake(0, 0, width, height);
    self = [self initWithFrame:frame];
    if (self) {
        _stoneWall = stoneWall;
        [self initStoneViews];
    }

    return self;
}




- (void)layoutSubviews
{


}


#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchStoneAtPoint:point];

}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchStoneAtPoint:point];

}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearConnectedStones];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearConnectedStones];
}



#pragma mark - Private
- (void)initStoneViews
{
    self.stoneViews = [[NSMutableArray alloc] init];
    for (Stone * aStone in self.stoneWall.stoneList) {
        StoneView * aStoneView = [[StoneView alloc] initWithStone:aStone];
        CGFloat originX = aStone.point.x * (kStoneSize.width + kStoneSpacing);
        CGFloat originY = aStone.point.y * (kStoneSize.height + kStoneSpacing);
        aStoneView.frame = CGRectMake(originX, originY, kStoneSize.width, kStoneSize.height);
        aStoneView.state = kStoneStateNormal;
        [self.stoneViews addObject:aStoneView];
        [self addSubview:aStoneView];
    }


    self.connectedStoneViews = [NSMutableArray array];
}


- (void)touchStoneAtPoint:(CGPoint)point
{
    StoneView * touchedStoneView = nil;
    for (StoneView * aStoneView in self.stoneViews) {
        if (CGRectContainsPoint(aStoneView.frame, point)) {
            touchedStoneView = aStoneView;
            break;
        }
    }

    if (nil == touchedStoneView) {
        return;
    }

    if ([self.connectedStoneViews containsObject:touchedStoneView]) {
        if (self.connectedStoneViews.count > 2) {
            //回退机制，从n移回到n-1，即产生回退，将n从connectedStoneViews中清除
            StoneView * prevStoneView = [self.connectedStoneViews objectAtIndex:self.connectedStoneViews.count - 2];
            if (touchedStoneView == prevStoneView) {
                [self unconnectStoneView:self.connectedStoneViews.lastObject];
            }
        }
    } else {
        [self connectStoneView:touchedStoneView];
    }
}



- (void)connectStoneView:(StoneView *)stoneView
{
    [self.connectedStoneViews addObject:stoneView];
    stoneView.state = kStoneStateShaking;
}


- (void)unconnectStoneView:(StoneView *)stoneView
{
    [self.connectedStoneViews removeObject:stoneView];
    stoneView.state = kStoneStateNormal;
}


- (void)clearConnectedStones
{
    for (StoneView * aStoneView in self.connectedStoneViews) {
        aStoneView.state = kStoneStateCleared;
    };

    [self.connectedStoneViews removeAllObjects];
}


@end
