//
//  StoneView.m
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "StoneView.h"
#import <QuartzCore/QuartzCore.h>

@implementation StoneView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _state = kStoneStateNormal;
    }
    return self;
}


- (id)initWithStone:(Stone *)stone
{
    self = [self initWithFrame:CGRectMake(0, 0, 60, 60)];
    if (self) {
        _stone = stone;
        self.backgroundColor = stone.color;
    }

    return self;
}

#pragma mark - Setter
- (void)setState:(StoneState)state
{
    if (state == _state) {
        return;
    }

    _state = state;
    [self updateWithState:state];
}



#pragma mark - Private
CGFloat DegressToRadians(CGFloat degress)
{
    return degress * M_PI / 180;
}


- (void)updateWithState:(StoneState)state
{
    switch (state) {
        case kStoneStateNormal:
        {
            self.backgroundColor = self.stone.color;
            [self.layer removeAllAnimations];
        }
            break;

        case kStoneStateShaking:
        {
            self.backgroundColor = [UIColor whiteColor];
            CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
            [animation setDuration:0.25];
            [animation setRepeatCount:NSUIntegerMax];
            [animation setAutoreverses:YES];
            srand([[NSDate date] timeIntervalSince1970]);
            float rand = (float)random();
            [animation setBeginTime:CACurrentMediaTime() + rand * 0.0000000001];

            NSMutableArray * values = [NSMutableArray array];
            [values addObject:[NSNumber numberWithFloat:DegressToRadians(-2)]];
            [values addObject:[NSNumber numberWithFloat:DegressToRadians(2)]];
            [values addObject:[NSNumber numberWithFloat:DegressToRadians(-2)]];
            [animation setValues:values];
            [self.layer addAnimation:animation forKey:@"StoneShakingAnimation"];

        }
            break;

        case kStoneStateHighlighted:
        {
            self.backgroundColor = [UIColor whiteColor];
        }
            break;


        case kStoneStateCleared:
        {
            
            CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
            [animation setDuration:0.25];
            [animation setFromValue:[NSValue valueWithCGRect:self.bounds]];
            [animation setToValue:[NSValue valueWithCGRect:CGRectZero]];
            [animation setRemovedOnCompletion:YES];
            [self.layer addAnimation:animation forKey:@"StoneClearAnimation"];

            self.frame = CGRectMake(self.frame.origin.x + self.frame.size.width/2,
                                    self.frame.origin.y + self.frame.size.height/2, 0, 0);
        }
            break;



        default:
            break;
    }
}



@end
