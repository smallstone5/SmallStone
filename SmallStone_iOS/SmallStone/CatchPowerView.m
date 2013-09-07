//
//  CatchPowerView.m
//  SmallStone
//
//  Created by Jamin on 9/7/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "CatchPowerView.h"

static CGFloat const kStrokeWidth = 12.0f;

@implementation CatchPowerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _progressBGColor = [UIColor whiteColor];
        _progressColor = [UIColor orangeColor]; //[[UIColor orangeColor] colorWithAlphaComponent:0.8];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.progressBGColor.CGColor);
    CGFloat minSide = MIN(rect.size.width, rect.size.height);
    CGRect circleFrame = CGRectMake(rect.origin.x + (rect.size.width - minSide)/2,
                                    rect.origin.y + (rect.size.height - minSide)/2,
                                    minSide, minSide);
    CGContextBeginPath(context);
    CGContextAddEllipseInRect(context, circleFrame);
    CGContextFillPath(context);


    CGContextBeginPath(context);
    CGPoint center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
    
//    CGContextMoveToPoint(context, center.x, center.y);
    CGFloat outerRadius = minSide / 2;
    CGFloat innerRadius = outerRadius - kStrokeWidth / 2;
    CGFloat startAngle = 0.0;
    CGFloat endAngle = M_PI * 2 * self.progress;
    CGContextAddArc(context, center.x, center.y, innerRadius, startAngle, endAngle, 0);
    CGContextSetStrokeColorWithColor(context, self.progressColor.CGColor);
    CGContextSetLineWidth(context, kStrokeWidth);
    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextStrokePath(context);

}



#pragma mark - Setter
- (void)setProgress:(CGFloat)progress
{
    if (progress == _progress) {
        return;
    }

    _progress = progress;
    [self setNeedsDisplay];
}


@end
