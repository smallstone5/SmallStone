//
//  GameViewController.m
//  SmallStone
//
//  Created by zhuochen on 9/4/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "GameViewController.h"
#import "GameSetting.h"
#import "BaseLevel.h"
#import "BaseBall.h"
#import "StoneWallView.h"
#import "CatchPowerView.h"
#import "GameResultView.h"

#import "Level1.h"



@interface GameViewController () <StoneWallViewDelegate>

@property (nonatomic, strong) CatchPowerView *      powerView;
@property (nonatomic, strong) GameResultView *      resultView;
@end

@implementation GameViewController
@synthesize level = _level;
@synthesize displayLink;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _level = [[Level1 alloc] init];             //直接创建Level1
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.powerView = [[CatchPowerView alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 80, 10, 64, 64)];
    self.powerView.backgroundColor = [UIColor clearColor];
    self.powerView.progressBGColor = [UIColor colorWithWhite:0.8 alpha:0.8];
    self.powerView.progress = 0.0;
    [self.view addSubview:self.powerView];

    self.level.stoneWall.delegate = self;

    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkCallback:)];
    _lastTimeStamp = self.displayLink.timestamp;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.displayLink setPaused: YES];
    
    [self.view addSubview: _level.stoneWall];
    [self.view addSubview: _level.ball];


    self.resultView = [GameResultView resultView];
    [self.resultView.backToMainButton addTarget:self action:@selector(backToMainAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.resultView.restartButton addTarget:self action:@selector(restartAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.resultView.nextLevelButton addTarget:self action:@selector(nextLevelAction:) forControlEvents:UIControlEventTouchUpInside];



}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
- (void)displayLinkCallback:(CADisplayLink *)sender
{
    if (_lastTimeStamp > 0.0f)
        [self updateData: self.displayLink.timestamp  - _lastTimeStamp];
    [self gameDraw];
    _lastTimeStamp = self.displayLink.timestamp;
}

- (void) updateData: (CFTimeInterval) delta
{
    [_level updateData: delta];
    
    if ([_level isOutOfBounds])
    {
        [_level gameOver];
        
        [self.displayLink setPaused: YES];
    }
}

- (void) gameDraw
{
    [_level gameDraw];
}

#pragma mark - UIResponder
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan: touches withEvent: event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView: self.view];
    if (_level.state == GS_Start) {
        CGPoint ballCenter = _level.ball.center;
        CGFloat deltaX = touchPoint.x - ballCenter.x;
        CGFloat deltaY = touchPoint.y - ballCenter.y;
        if (deltaX * deltaX + deltaY * deltaY < kMaxTapDistance)
        {
            //点击到小球
            if (_level.stoneWall.isCleared)
                [_level victory];
            else
                [_level gameOver];
            
            [self.displayLink setPaused: YES];
        }
        
        return;
    }
        
    _ptStart = ConvertPtTopLeftToBottomLeft(touchPoint);
    _tmStart = CFAbsoluteTimeGetCurrent();
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded: touches withEvent: event];
   
    if (_level.state != GS_WaitForSwipe)
        return;
    
    UITouch *touch = [touches anyObject];
    CGPoint ptEnd = ConvertPtTopLeftToBottomLeft([touch locationInView: self.view]);
        
    CGFloat deltaX = ptEnd.x - _ptStart.x;
    CGFloat deltaY = ptEnd.y - _ptStart.y;
    if (deltaX < 0 || deltaY < 0)
        return;                             //不能朝反方向抛球

    if (deltaX * deltaX + deltaY * deltaY <= kMinSwipeDistance)
        return;                             //Swipe的距离不够

    CFAbsoluteTime tmDelta = CFAbsoluteTimeGetCurrent() - _tmStart;
    _level.speed = CGPointMake(deltaX / tmDelta, deltaY / tmDelta);
    [_level startGame];
    
    [self.displayLink setPaused: NO];
}


#pragma mark - Action
- (IBAction) back:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)backToMainAction:(id)sender
{
    [self back:sender];
}

- (void)restartAction:(id)sender
{
    [self.resultView hideResultView];
}

- (void)nextLevelAction:(id)sender
{
    [self.resultView hideResultView];
}


#pragma mark - Private
- (void)updatePowerProgress:(CGFloat)progress
{
    self.powerView.progress = progress;
    if (progress == 1) {
//        [self showGameResult];
    }
}

- (void)showGameResult
{
//    [self.resultView showScore:2000 onView:self.view];
}




#pragma mark - StoneWallViewDelegate
- (void)stoneWallView:(StoneWallView *)wallView didClearStoneViews:(NSArray *)stoneViews
{
    CGPoint powerViewCenter = self.powerView.center;
    NSInteger currentClearedCount = wallView.clearedStoneViews.count;

    for (NSInteger i = 0; i < stoneViews.count; i++) {
        UIView * stoneView = stoneViews[i];
        CGPoint stoneViewCenter = [self.view convertPoint:stoneView.center fromView:wallView];
        UIImageView * starView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"orange_sun.png"]];
        starView.frame = CGRectMake(stoneViewCenter.x - 10, stoneViewCenter.y - 10, 20, 20);
        starView.center = stoneViewCenter;
        [self.view addSubview:starView];

        [UIView animateWithDuration:0.8
                              delay: i * 0.05
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionTransitionFlipFromTop
                         animations:^{
                             starView.center = powerViewCenter;
                         } completion:^(BOOL finished) {
                             CGFloat progress = (CGFloat)(currentClearedCount + i + 1) / wallView.stoneViews.count;
                             [self updatePowerProgress:progress];
                             [UIView animateWithDuration:0.5
                                              animations:^{
                                                  starView.alpha = 0;
                                                  CGRect frame = self.powerView.frame;
                                                  starView.frame = CGRectMake(frame.origin.x + 6, frame.origin.y + 6,
                                                                              frame.size.width - 12, frame.size.height - 12);
                                              } completion:^(BOOL finished) {
                                                  [starView removeFromSuperview];
                                              }];

                         }];
    }

}

@end
