//
//  StoneWallView.m
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>


#import "StoneWallView.h"
#import "StoneLinkView.h"


static CGSize const kStoneSize = {44, 44};
static CGFloat const kStoneSpacing = 4.0f;


@interface StoneWallView()

@property (nonatomic, strong) StoneLinkView *       linkView;
@property (nonatomic, strong) AVAudioPlayer *       audioPlayer;


@end

@implementation StoneWallView


#pragma mark - Lifecycle
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}



- (id)initWithStoneWall:(StoneWall *)stoneWall
{
    CGFloat width = stoneWall.matrixColumn * (kStoneSize.width + kStoneSpacing);
    CGFloat height = stoneWall.matrixRow * (kStoneSize.height + kStoneSpacing);
    CGRect frame = CGRectMake(0, 0, width, height);
    self = [self initWithFrame:frame];
    if (self) {
        _stoneWall = stoneWall;

        self.linkView = [[StoneLinkView alloc] initWithFrame:frame];
        self.linkView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.linkView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.linkView];

        [self initStoneViews];
    }

    return self;
}




- (void)layoutSubviews
{


}


#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchStoneAtPoint:point];

}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self touchStoneAtPoint:point];

}


- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearConnectedStones];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearConnectedStones];
}



#pragma mark - Private

- (void)resetWall
{
    self.stoneViews = [[NSMutableArray alloc] init];
    self.connectedStoneViews = [NSMutableArray array];
    [self.linkView clear];
}

- (void)initStoneViews
{
    [self resetWall];
    for (Stone * aStone in self.stoneWall.stoneList) {
        StoneView * aStoneView = [[StoneView alloc] initWithStone:aStone];
        CGFloat originX = aStone.point.x * (kStoneSize.width + kStoneSpacing);
        CGFloat originY = aStone.point.y * (kStoneSize.height + kStoneSpacing);
        aStoneView.frame = CGRectMake(originX, originY, kStoneSize.width, kStoneSize.height);
        aStoneView.state = kStoneStateNormal;
        [self.stoneViews addObject:aStoneView];
        [self addSubview:aStoneView];
    }


}


//点击到某一点，查看点击点是否有stoneView来连接
- (void)touchStoneAtPoint:(CGPoint)point
{
    StoneView * touchedStoneView = nil;
    for (StoneView * aStoneView in self.stoneViews) {
        if (CGRectContainsPoint(aStoneView.frame, point)) {
            touchedStoneView = aStoneView;
            break;
        }
    }

    if (nil == touchedStoneView) {
        return;
    }

    if ([self.connectedStoneViews containsObject:touchedStoneView]) {
        if (self.connectedStoneViews.count >= 2) {
            //回退机制，从n移回到n-1，即产生回退，将n从connectedStoneViews中清除
            StoneView * prevStoneView = [self.connectedStoneViews objectAtIndex:self.connectedStoneViews.count - 2];
            if (touchedStoneView == prevStoneView) {
                [self unconnectStoneView:self.connectedStoneViews.lastObject];
            }
        }
    } else {
        [self connectStoneView:touchedStoneView];
    }
}

//验证需要connect的stoneView，跟当前已连接的最后一个stoneView是不是相邻的
- (BOOL)canConnectToStoneView:(StoneView *)stoneView
{
    StoneView * lastStoneView = self.connectedStoneViews.lastObject;
    if (nil == lastStoneView) {
        return YES;
    }

    CGFloat connetXLength = fabs(stoneView.center.x - lastStoneView.center.x);
    CGFloat connetYLength = fabs(stoneView.center.y - lastStoneView.center.y);
    if (connetXLength <= kStoneSize.width + 2 * kStoneSpacing
        && connetYLength <= kStoneSize.height + 2 * kStoneSpacing) {
        return YES;
    }

    return NO;

}

//将stoneView连接起来
- (void)connectStoneView:(StoneView *)stoneView
{
    if ([self canConnectToStoneView:stoneView]) {
        [self.connectedStoneViews addObject:stoneView];
        stoneView.state = kStoneStateShaking;
        [self.linkView connectLinkToPoint:stoneView.center];
    }

    self.audioPlayer =
    [[AVAudioPlayer alloc]
     initWithContentsOfURL:backgroundMusicURL error:&error];
    [_backgroundMusicPlayer prepareToPlay];
    [_backgroundMusicPlayer play];

}

//将stoneView从连接队列清除
- (void)unconnectStoneView:(StoneView *)stoneView
{
    [self.connectedStoneViews removeObject:stoneView];
    stoneView.state = kStoneStateNormal;
    [self.linkView unconnectLinkPoint:stoneView.center];

}


//消除所有连接的石子
- (void)clearConnectedStones
{

    if (self.connectedStoneViews.count == 0) {
        return;
    }

    for (StoneView * aStoneView in self.connectedStoneViews) {
        aStoneView.state = kStoneStateCleared;
    };


    [self.connectedStoneViews removeAllObjects];
    [self.linkView clear];
}


- (AVAudioPlayer *)audioPlayerWith
{
    if (nil == _audioPlayer) {
        NSError * error = nil;
        NSString * muteAudioPath = [[NSBundle mainBundle] pathForResource:@"mute" ofType:@"mp3"];
        NSURL * muteAudioURL = [NSURL fileURLWithPath:muteAudioPath];
        _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:muteAudioURL error:&error];
        _audioPlayer.delegate = self;
        _audioPlayer.numberOfLoops = -1;
    }

    return _audioPlayer;
}



@end
