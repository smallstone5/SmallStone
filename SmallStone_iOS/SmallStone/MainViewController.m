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
#import "SettingViewController.h"
#import "ScoreManager.h"

static CGFloat const kButtonWidth =     150.0f;
static CGFloat const kButtonHeight =    50.0f;
static CGFloat const kButtonSpacing =   10.0f;


@interface MainViewController ()


@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.backgroupView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgroupView.image = [UIImage imageNamed:@"bg.jpg"];
    self.backgroupView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroupView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroupView];
    
    
    CGRect buttonFrame = CGRectMake((self.view.frame.size.width - kButtonWidth)/2, 40, kButtonWidth, kButtonHeight);
    
    //排名 Rank
	/*
    self.rankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rankButton.frame = buttonFrame;
    self.rankButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.rankButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [self.rankButton setTitle:NSLocalizedString(@"Rank", @"Rank") forState:UIControlStateNormal];
    [self.rankButton addTarget:self action:@selector(rankAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.rankButton setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
    [self.rankButton setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
    [self.view addSubview:self.rankButton];
    */
    //新建游戏 New
    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.createGameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.createGameButton.frame = buttonFrame;
    self.createGameButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.createGameButton setBackgroundImage:[UIImage imageNamed:@"newgame.png"] forState:UIControlStateNormal];
    //[self.createGameButton setTitle:NSLocalizedString(@"新游戏", @"新游戏") forState:UIControlStateNormal];
    [self.createGameButton addTarget:self action:@selector(createGameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.createGameButton setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
    [self.createGameButton setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
    [self.view addSubview:self.createGameButton];
    
    
    //继续游戏 Continue

    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.continueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.continueButton.frame = buttonFrame;
    self.continueButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.continueButton setBackgroundImage:[UIImage imageNamed:@"continue.png"] forState:UIControlStateNormal];
    //[self.continueButton setTitle:NSLocalizedString(@"继续游戏", @"继续游戏") forState:UIControlStateNormal];
    [self.continueButton setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
    [self.continueButton setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
    [self.continueButton addTarget:self action:@selector(continueGameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.continueButton];

    
    //设置 Setting
    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingButton.frame = buttonFrame;
    self.settingButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.settingButton setBackgroundImage:[UIImage imageNamed:@"setting.png"] forState:UIControlStateNormal];
    //[self.settingButton setTitle:NSLocalizedString(@"设置", @"设置") forState:UIControlStateNormal];
	[self.settingButton addTarget:self action:@selector(settingAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.settingButton setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
    [self.settingButton setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
    [self.view addSubview:self.settingButton];
    
	/*
    //难易程度 Level
    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.levelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.levelButton.frame = buttonFrame;
    self.levelButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.levelButton setBackgroundImage:[UIImage imageNamed:@"button"] forState:UIControlStateNormal];
    [self.levelButton setTitle:NSLocalizedString(@"Level", @"Level") forState:UIControlStateNormal];
    [self.levelButton setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
    [self.levelButton setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
    [self.view addSubview:self.levelButton];
    */
    //显示排行榜
    buttonFrame.origin.y += buttonFrame.size.height + kButtonSpacing;
    self.ranknewButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ranknewButton.frame = buttonFrame;
    self.levelButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.ranknewButton setBackgroundImage:[UIImage imageNamed:@"rank.png"] forState:UIControlStateNormal];
    //[self.ranknewButton setTitle:NSLocalizedString(@"排行榜", @"排行榜") forState:UIControlStateNormal];
    [self.ranknewButton addTarget:self action:@selector(rankNewAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.ranknewButton setTitleColor: [UIColor darkGrayColor] forState: UIControlStateNormal];
    [self.ranknewButton setTitleColor: [UIColor whiteColor] forState: UIControlStateHighlighted];
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
    
}


- (void)continueGameAction:(UIButton *)button
{
    GameViewController *gameController = [[GameViewController alloc] initWithNibName: @"GameViewController" bundle: [NSBundle mainBundle]];
    gameController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: gameController animated: YES completion: nil];
}


- (void)createGameAction:(UIButton *)button
{
    [[ScoreManager defaultManager] resetNextLevel];
    GameViewController *gameController = [[GameViewController alloc] initWithNibName: @"GameViewController" bundle: [NSBundle mainBundle]];
    gameController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: gameController animated: YES completion: nil];
}

#pragma newrank - Action
-(void) rankNewAction:(UIButton *)button
{
    RankViewController * rankViewController = [[RankViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:rankViewController];
	navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentViewController:navigationController animated:YES completion:nil];
}

-(void) settingAction:(UIButton *)button
{
	SettingViewController * settingController = [[SettingViewController alloc] initWithNibName:@"SettingViewController" bundle:[NSBundle mainBundle]];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:settingController];
	navigationController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentViewController:navigationController animated:YES completion:nil];
}

@end
