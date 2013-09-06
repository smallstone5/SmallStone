//
//  GameViewController.m
//  SmallStone
//
//  Created by zhuochen on 9/4/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "GameViewController.h"
#import "BaseBall.h"
#import "GameSetting.h"

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize displayLink;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    _ball = [[BaseBall alloc] initWithFrame: CGRectMake(0.0f, 0.0f, kSmallBallSize, kSmallBallSize)];
    _ball.center = ConvertPtBottomLeftToTopLeft(CGPointMake(-kSmallBallSize/2, -kSmallBallSize/2));
    [self.view addSubview: _ball];
    _ball.image = [UIImage imageNamed: @"Icon"];
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
    if (ballCenter.x > g_rcScreen.size.width + kSmallBallSize || ballCenter.y < -kSmallBallSize)
    {
        [self.displayLink setPaused: YES];
        _ball.center = ConvertPtBottomLeftToTopLeft(CGPointMake(-kSmallBallSize/2, -kSmallBallSize/2));
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
    if (_gameStart)
        return;
    
    UITouch *touch = [touches anyObject];
    _ptStart = ConvertPtTopLeftToBottomLeft([touch locationInView: self.view]);
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
    _ball.speed = CGPointMake(deltaY / tmDelta, deltaX / tmDelta);
    _ball.acceleration = CGPointMake(0.0f, 10000.0f);
    
    [self.displayLink setPaused: NO];
    _gameStart = YES;
}

@end
