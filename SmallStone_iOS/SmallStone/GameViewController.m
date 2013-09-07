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

#import "Level1.h"

@interface GameViewController ()

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
    // Do any additional setup after loading the view from its nib.
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkCallback:)];
    _lastTimeStamp = self.displayLink.timestamp;
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [self.displayLink setPaused: YES];
    
    [self.view addSubview: _level.stoneWall];
    [self.view addSubview: _level.ball];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

- (IBAction) back:(id)sender
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

@end
