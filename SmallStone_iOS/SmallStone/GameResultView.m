//
//  GameResultView.m
//  SmallStone
//
//  Created by Jamin on 9/7/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "GameResultView.h"
#import "CommonType.h"
#import <QuartzCore/QuartzCore.h>

static NSInteger const kCoverViewTag  =  171522;


@interface GameResultView()

@property (nonatomic, strong) NSArray *         starViewList;

@end


@implementation GameResultView


#pragma mark - Lifecycle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        CGRect bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
        self.backgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, bounds.size.height - 0)];
        self.backgroundView.backgroundColor = UIColorFromRGB(0xBDC3C7);
        self.backgroundView.image = [UIImage imageNamed:@""];
        [self addSubview:self.backgroundView];


        NSMutableArray * mStarViews = [NSMutableArray arrayWithCapacity:3];
        CGFloat starSacing = 10;
        CGFloat starWidth = 40;
        CGFloat starOriginY = -20;
        CGFloat starOriginX = (bounds.size.width - (3 * starWidth + 2 * starSacing)) / 2;
        for (NSInteger i = 0; i < 3; i++) {
            CGRect starFrame = CGRectMake(starOriginX, starOriginY, starWidth, starWidth);
            UIImageView * starView = [[UIImageView alloc] initWithFrame:starFrame];
            starView.backgroundColor = [UIColor clearColor];
            starView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
            starView.contentMode = UIViewContentModeCenter;
            starView.image = [UIImage imageNamed:@"score_orange_sun.png"];
            [self addSubview:starView];
            [mStarViews addObject:starView];
            starOriginX += starSacing + starWidth;
        }

        self.starViewList = mStarViews;


        CGFloat originY = 20;
        CGRect resultLabelFrame = CGRectMake(0, originY, frame.size.width, 40);
        self.resultLabel= [[UILabel alloc] initWithFrame:resultLabelFrame];
        self.resultLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        self.resultLabel.backgroundColor = [UIColor clearColor];
        self.resultLabel.textColor = [UIColor darkTextColor];
        self.resultLabel.textAlignment = UITextAlignmentCenter;
        self.resultLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        self.resultLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:36];
        [self addSubview:self.resultLabel];

        originY += self.resultLabel.frame.size.height;
        CGRect scoreLabelFrame = CGRectMake(0, originY, frame.size.width, 40);
        self.scoreLabel= [[UILabel alloc] initWithFrame:scoreLabelFrame];
        self.scoreLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;
        self.scoreLabel.backgroundColor = [UIColor clearColor];
        self.scoreLabel.textColor = [UIColor darkTextColor];
        self.scoreLabel.textAlignment = UITextAlignmentCenter;
        self.scoreLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        self.scoreLabel.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:36];
        [self addSubview:self.scoreLabel];

        originY = frame.size.height - 50;
        UIFont * buttonFont = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:18];


        self.backToMainButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.backToMainButton.frame = CGRectMake(10, originY, 60, 40);
        self.backToMainButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
        [self.backToMainButton setTintColor:UIColorFromRGB(0x2ECC71)];
        [self.backToMainButton setTitle:NSLocalizedString(@"Back", @"Back") forState:UIControlStateNormal];
        self.backToMainButton.titleLabel.font = buttonFont;
//        [self.backToMainButton addTarget:self action:@selector(backToMainAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backToMainButton];


        self.restartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.restartButton.frame = CGRectMake((frame.size.width - 60)/2, originY, 60, 40);
        self.restartButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [self.restartButton setTintColor:UIColorFromRGB(0x2ECC71)];
        self.restartButton.titleLabel.font = buttonFont;
        [self.restartButton setTitle:NSLocalizedString(@"Restart", @"Restart") forState:UIControlStateNormal];
//        [self.restartButton addTarget:self action:@selector(restartAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.restartButton];


        self.nextLevelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.nextLevelButton.frame = CGRectMake(frame.size.width - 70, originY, 60, 40);
        self.nextLevelButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin;
        [self.nextLevelButton setTintColor:UIColorFromRGB(0x2ECC71)];
        self.nextLevelButton.titleLabel.font = buttonFont;
        [self.nextLevelButton setTitle:NSLocalizedString(@"Next", @"Next") forState:UIControlStateNormal];
        [self addSubview:self.nextLevelButton];

    }
    return self;
}

+ (GameResultView *)resultView
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    return [[self alloc] initWithFrame:CGRectMake((screenBounds.size.width - 240)/2,
                                                  (screenBounds.size.height - 160)/2, 240, 160)];
}



#pragma mark - Public
- (void)showScore:(NSUInteger)score onView:(UIView *)containerView
{
    UIView * coverView = [[UIView alloc] initWithFrame:containerView.bounds];
    coverView.backgroundColor = [UIColor colorWithWhite:0.6 alpha:0.5];
    coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    coverView.alpha = 0;
    coverView.tag = kCoverViewTag;
    [containerView addSubview:coverView];

    [self updateWithScore:score];
    self.center = containerView.center;
    self.alpha = 0.1;
    [containerView addSubview:self];

    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         coverView.alpha = 1.0;
                         self.alpha = 1.0;
                     } completion:^(BOOL finished) {
                         coverView.alpha = 1.0;
                         self.alpha = 1.0;

                         self.layer.shadowColor = [[UIColor blackColor] CGColor];
                         self.layer.shadowOffset = CGSizeMake(0, 1);
                         self.layer.shadowOpacity = 0.4f;
                         self.layer.shadowPath = CGPathCreateWithRect(self.bounds, NULL);
                         


                     }];
}



- (void)hideResultView
{
    UIView * coverView = [self.superview viewWithTag:kCoverViewTag];
    [UIView animateWithDuration:0.3
                     animations:^{
                         coverView.alpha = 0.1;
                         self.alpha = 0.1;
                     } completion:^(BOOL finished) {
                         [coverView removeFromSuperview];
                         [self removeFromSuperview];
                     }];


}


#pragma mark - Private
- (void)updateWithScore:(NSInteger)score
{
    if (score > 0) {
        //pass
        self.resultLabel.text = NSLocalizedString(@"Pass", @"Pass");
        self.resultLabel.textColor = UIColorFromRGB(0x2ECC71);
        self.scoreLabel.text = [NSString stringWithFormat:@"%d", score];

        NSUInteger starLevel = [self starLevelOfScore:score];
        [self updateStarViewWithStarLevel:starLevel];

        self.backToMainButton.enabled = YES;
        self.restartButton.enabled = YES;
        self.nextLevelButton.enabled = YES;
        
    } else {
        self.resultLabel.textColor = [UIColor darkTextColor];
        self.resultLabel.text = NSLocalizedString(@"Failed", @"Failed");
        self.scoreLabel.text = nil;
        [self updateStarViewWithStarLevel:0];

        self.backToMainButton.enabled = YES;
        self.restartButton.enabled = YES;
        self.nextLevelButton.enabled = NO;
    }

}

//星级
- (NSUInteger)starLevelOfScore:(NSInteger)score
{
    if (score >= 3000) {
        return 3;
    } else if (score >= 2000){
        return 2;
    } else if (score > 0){
        return 1;
    }

    return 0;
}


- (void)updateStarViewWithStarLevel:(NSUInteger)starLevel
{
    for (NSInteger i = 0; i < 3; i++) {
        UIImageView * starView = self.starViewList[i];
        starView.hidden = (i >= starLevel);
    }

}



@end
