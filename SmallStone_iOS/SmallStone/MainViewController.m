//
//  MainViewController.m
//  SmallStone
//
//  Created by Jamin on 9/4/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "MainViewController.h"
#import "GameViewController.h"
#import "StoneWallViewController.h"
#import "RankViewController.h"

static CGFloat const kButtonWidth =     120.0f;
static CGFloat const kButtonHeight =    50.0f;
static CGFloat const kButtonSpacing =   10.0f;


@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backgroupView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgroupView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroupView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroupView];
    
    
    CGRect buttonFrame = CGRectMake((self.view.frame.size.width - kButtonWidth)/2, 80, kButtonWidth, kButtonHeight);
    
    //排名 Rank
    self.rankButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.rankButton.frame = buttonFrame;
    self.rankButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.rankButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.rankButton setTitle:NSLocalizedString(@"Rank", @"Rank") forState:UIControlStateNormal];
    [self.rankButton addTarget:self action:@selector(rankAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.rankButton];
    
    //新建游戏 New
    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.createGameButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.createGameButton.frame = buttonFrame;
    self.createGameButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.createGameButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.createGameButton setTitle:NSLocalizedString(@"New", @"New") forState:UIControlStateNormal];
    [self.createGameButton addTarget:self action:@selector(createGameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.createGameButton];
    
    
    //继续游戏 Continue
    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.continueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.continueButton.frame = buttonFrame;
    self.continueButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.continueButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.continueButton setTitle:NSLocalizedString(@"Continue", @"Continue") forState:UIControlStateNormal];
    [self.view addSubview:self.continueButton];
    
    
    //设置 Setting
    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.settingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.settingButton.frame = buttonFrame;
    self.settingButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.settingButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.settingButton setTitle:NSLocalizedString(@"Setting", @"Setting") forState:UIControlStateNormal];
    [self.view addSubview:self.settingButton];
    
    //难易程度 Level
    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.levelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.levelButton.frame = buttonFrame;
    self.levelButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.levelButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.levelButton setTitle:NSLocalizedString(@"Level", @"Level") forState:UIControlStateNormal];
    [self.view addSubview:self.levelButton];
    
    //显示排行榜
    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.ranknewButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.ranknewButton.frame = buttonFrame;
    self.levelButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.ranknewButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.ranknewButton setTitle:NSLocalizedString(@"排行榜", @"排行榜") forState:UIControlStateNormal];
    [self.ranknewButton addTarget:self action:@selector(rankNewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.ranknewButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Action
- (void)rankAction:(UIButton *)button
{
    GameViewController *gameController = [[GameViewController alloc] initWithNibName: @"GameViewController" bundle: [NSBundle mainBundle]];
    gameController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: gameController animated: YES completion: nil];
}

- (void)createGameAction:(UIButton *)button
{
    StoneWallViewController * wallViewController = [[StoneWallViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:wallViewController animated:YES completion:nil];
}

#pragma newrank - Action
-(void) rankNewAction:(UIButton *)button
{
    NSLog(@"111");
    RankViewController * wallViewController = [[RankViewController alloc] initWithNibName:nil bundle:nil];
    [self presentViewController:wallViewController animated:YES completion:nil];
}

@end
