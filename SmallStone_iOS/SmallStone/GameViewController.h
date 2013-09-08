//
//  GameViewController.h
//  SmallStone
//
//  Created by zhuochen on 9/4/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BallProgress.h"

@class BaseLevel;
@interface GameViewController : UIViewController {
    BaseLevel *_level;
    CFTimeInterval _lastTimeStamp;
    CFTimeInterval _tmStart;
    CGPoint _ptStart;
    IBOutlet BallProgress *_ballProgress;
    
}

@property (nonatomic, strong) BaseLevel *level;
@property (nonatomic, strong) CADisplayLink *displayLink;

- (void) updateData: (CFTimeInterval) delta;
- (void) gameDraw;

- (IBAction) back:(id)sender;
@end
