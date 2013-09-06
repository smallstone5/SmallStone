//
//  GameViewController.m
//  SmallStone
//
//  Created by Jamin on 9/4/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "GameViewController.h"
#define kMinSwipeDistance       10.0f
#define kMinSwipeTime           0.1f
#define kBallSize               16.0f

CGRect g_rcScreen;

CGPoint ConvertPtTopLeftToBottomLeft(CGPoint pt)
{
    return CGPointMake(pt.x, g_rcScreen.size.height - pt.y);
}

CGPoint ConvertPtBottomLeftToTopLeft(CGPoint pt)
{
    return CGPointMake(pt.x, g_rcScreen.size.height - pt.y);
}

@interface GameViewController ()

@end

@implementation GameViewController
@synthesize displayLink;

+ (void) initialize
{
    [super initialize];
    g_rcScreen = [[UIScreen mainScreen] bounds];
}

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

    _imageTest = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"Icon"]];
    _imageTest.frame = CGRectMake(0.0f, 0.0f, kBallSize, kBallSize);
    _imageTest.center = ConvertPtBottomLeftToTopLeft(CGPointMake(-kBallSize/2, -kBallSize/2));
    [self.view addSubview: _imageTest];
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
    CFAbsoluteTime t = CFAbsoluteTimeGetCurrent() - _tmStart;
    
    t *= 0.2;
    
    _x = _vx * t + _ax*t*t;
    _y = _vy * t - _ay*t*t;
    _y *= 4;
    
    if (_x > g_rcScreen.size.width + kBallSize || _y < -kBallSize)
    {
        [self.displayLink setPaused: YES];
        _imageTest.center = ConvertPtBottomLeftToTopLeft(CGPointMake(-kBallSize/2, -kBallSize/2));
        _gameStart = NO;
    }
}

- (void) gameDraw
{
    _imageTest.center = ConvertPtBottomLeftToTopLeft(CGPointMake(_x, _y));
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
    CFAbsoluteTime tmDelta = CFAbsoluteTimeGetCurrent() - _tmStart;
        
    CGFloat deltaX = ptEnd.x - _ptStart.x;
    CGFloat deltaY = ptEnd.y - _ptStart.y;
    if (deltaX < 0 || deltaY < 0)
        return;                             //不能朝反方向抛球

    CGFloat r = sqrtf(deltaX * deltaX + deltaY * deltaY);
    if (r <= kMinSwipeDistance)
        return;                             //Swipe的距离不够

    _vy = deltaY / tmDelta;
    _vx = deltaX / tmDelta;
    
    _ax = 0;
    _ay = 10000;
    
    [self.displayLink setPaused: NO];
    _tmStart = CFAbsoluteTimeGetCurrent();
    _gameStart = YES;
}

@end
