//
//  StoneLinkView.m
//  SmallStone
//
//  Created by Jamin on 9/6/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "StoneLinkView.h"

@interface StoneLinkView()

@property (nonatomic) NSMutableArray *              pointList;

@end

@implementation StoneLinkView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = nil;
        _pointList = [NSMutableArray array];
    }
    return self;
}



- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    if (self.pointList.count <= 1) {
        return;
    }


    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [[UIColor whiteColor] CGColor]);
    CGContextSetLineWidth(context, 8.0);
    CGPoint fromPoint = [self.pointList[0] CGPointValue];
    for (NSInteger i = 1; i < self.pointList.count; i++) {
        CGPoint toPoint = [self.pointList[i] CGPointValue];
        CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
        CGContextStrokePath(context);
        fromPoint = toPoint;
    }
}




#pragma mark - Public

- (void)connectLinkToPoint:(CGPoint)point
{
    NSValue * pointValue = [NSValue valueWithCGPoint:point];
    if ([self.pointList containsObject:pointValue]) {
        return;
    }

    [self.pointList addObject:pointValue];
    [self setNeedsDisplay];

}


- (void)unconnectLinkPoint:(CGPoint)point
{
    NSValue * pointValue = [NSValue valueWithCGPoint:point];
    if (![self.pointList containsObject:pointValue]) {
        return;
    }

    [self.pointList removeObject:pointValue];
    [self setNeedsDisplay];
}



- (void)clear
{
    [self.pointList removeAllObjects];
    [self setNeedsDisplay];
}

@end
