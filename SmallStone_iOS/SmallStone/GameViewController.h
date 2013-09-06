//
//  GameViewController.h
//  SmallStone
//
//  Created by Jamin on 9/4/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface GameViewController : UIViewController {
    CFTimeInterval _lastTimeStamp;
    UIImageView *_imageTest;
    CGPoint _ptStart;
    CFAbsoluteTime _tmStart;
    
    CGFloat _x;
    CGFloat _y;
    CGFloat _vx;
    CGFloat _vy;
    CGFloat _ax;
    CGFloat _ay;
    BOOL _gameStart;
}

@property (nonatomic, strong) CADisplayLink *displayLink;

- (void) updateData: (CFTimeInterval) delta;
- (void) gameDraw;
@end
