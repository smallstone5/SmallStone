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

    }
    return self;
}


- (id)initWithStone:(Stone *)stone
{
    self = [self initWithFrame:CGRectMake(0, 0, stone.size.width, stone.size.height)];
    if (self) {
        _stone = stone;
        self.backgroundColor = stone.color;
        self.image = [stone imageForState:kStoneStateNormal];
        self.contentMode = UIViewContentModeScaleAspectFit;
        self.clipsToBounds = YES;
    }

    return self;
}

#pragma mark - Setter
- (void)setState:(StoneState)state
{
    if (state == self.stone.state ) {
        return;
    }

    self.stone.state = state;
    [self updateWithState:state];
}

- (StoneState)state
{
    return self.stone.state;
}



#pragma mark - Private
CGFloat DegressToRadians(CGFloat degress)
{
    return degress * M_PI / 180;
}


- (void)updateWithState:(StoneState)state
{
    self.image = [self.stone imageForState:state];

    switch (state) {
        case kStoneStateNormal:
        {
            self.backgroundColor = self.stone.color;
            [self.layer removeAllAnimations];
        }
            break;

        case kStoneStateShaking:
        {
//            self.backgroundColor = [UIColor whiteColor];
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
            [UIView animateWithDuration:0.25
                                  delay:0
                                options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 self.frame = CGRectMake(self.frame.origin.x + self.frame.size.width/2,
                                                         self.frame.origin.y + self.frame.size.height/2, 0, 0);
                             } completion:^(BOOL finished) {
                                 [self removeFromSuperview];
                             }];
            
//            CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
//            [animation setDuration:0.25];
//            [animation setFromValue:[NSValue valueWithCGRect:self.bounds]];
//            [animation setToValue:[NSValue valueWithCGRect:CGRectZero]];
//            [animation setRemovedOnCompletion:YES];
//            [self.layer addAnimation:animation forKey:@"StoneClearAnimation"];

        }
            break;



        default:
            break;
    }
}



@end
