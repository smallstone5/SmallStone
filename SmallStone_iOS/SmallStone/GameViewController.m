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
    
    _stoneWall = [_level createStoneWall];
    [self.view addSubview: _stoneWall];
    
    _ball = [_level createBall];
    [self.view addSubview: _ball];
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
    [_ball updateData: delta];
    
    CGPoint ballCenter = _ball.center;
    CGFloat ballsize = _level.ballSize;
    if (ballCenter.x > g_rcScreen.size.width + ballsize || ballCenter.y > g_rcScreen.size.height + ballsize)
    {
        [self.displayLink setPaused: YES];
        _ball.center = ConvertPtBottomLeftToTopLeft(CGPointMake(-ballsize/2, -ballsize/2));
        _gameStart = NO;
    }
}

- (void) gameDraw
{
    [_ball gameDraw];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan: touches withEvent: event];
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView: self.view];
    if (_gameStart) {
        CGPoint ballCenter = _ball.center;
        CGFloat deltaX = touchPoint.x - ballCenter.x;
        CGFloat deltaY = touchPoint.y - ballCenter.y;
        if (deltaX * deltaX + deltaY * deltaY < kMaxTapDistance)
        {
            //点击到小球
            [self.displayLink setPaused: YES];
            [self performSelector: @selector(onResult) withObject: nil afterDelay: 1.5];
            [_ball bomb];
        }
        
        return;
    }
        
    _ptStart = ConvertPtTopLeftToBottomLeft(touchPoint);
    _tmStart = CFAbsoluteTimeGetCurrent();
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded: touches withEvent: event];
   
    if (_gameStart)
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
    _ball.speed = CGPointMake(deltaX / tmDelta, deltaY / tmDelta);
    _ball.acceleration = _level.acceleration;
    _ball.flyingTime = 0.0f;
    [_level resetBall: _ball];
    _lastTimeStamp = 0.0f;
    
    [self.displayLink setPaused: NO];
    _gameStart = YES;
}

- (void) onResult
{
    CGFloat ballsize = _level.ballSize;
    _ball.center = ConvertPtBottomLeftToTopLeft(CGPointMake(-ballsize/2, -ballsize/2));
    _gameStart = NO;
}

@end
