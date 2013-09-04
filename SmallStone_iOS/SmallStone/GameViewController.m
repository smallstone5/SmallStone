//
//  GameViewController.m
//  SmallStone
//
//  Created by Jamin on 9/4/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "GameViewController.h"
CGRect g_rcScreen;

CGPoint ConvertPtTopLeftToBottomLeft(CGPoint pt)
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
    [[self displayLink] addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    _imageTest = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"Icon"]];
    _imageTest.frame = CGRectMake(0.0f, 0.0f, 10.0f, 10.0f);
    _imageTest.center = CGPointMake(0, 0);
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
   
}

- (void) gameDraw
{
    _imageTest.center = CGPointMake(_x, _y);
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan: touches withEvent: event];
    UITouch *touch = [touches anyObject];
    _ptStart = [touch locationInView: self.view];
    _tmStart = CFAbsoluteTimeGetCurrent();
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded: touches withEvent: event];
    UITouch *touch = [touches anyObject];
    CGPoint ptEnd = [touch locationInView: self.view];
    CFAbsoluteTime tmDelta = CFAbsoluteTimeGetCurrent() - _tmStart;
    
}

@end
