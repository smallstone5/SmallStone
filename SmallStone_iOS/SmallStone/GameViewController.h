//
//  GameViewController.h
//  SmallStone
//
//  Created by zhuochen on 9/4/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class BaseBall;
@interface GameViewController : UIViewController {
    BaseBall *_ball;
    
    CFTimeInterval _lastTimeStamp;
    CFTimeInterval _tmStart;
    CGPoint _ptStart;
    BOOL _gameStart;
}

@property (nonatomic, strong) CADisplayLink *displayLink;

- (void) updateData: (CFTimeInterval) delta;
- (void) gameDraw;
@end
