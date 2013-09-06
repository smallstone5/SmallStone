//
//  StoneWallViewController.m
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "StoneWallViewController.h"

@interface StoneWallViewController ()

@end

@implementation StoneWallViewController

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

    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(10, 10, 80, 40);
    self.backButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.backButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.backButton setTitle:NSLocalizedString(@"Back", @"Back") forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];

    StoneWall * wall = [[StoneWall alloc] init];
    wall.matrixRow = 3;
    wall.matrixColumn = 4;
    [wall generateRandStones:8];

    self.stoneWallView = [[StoneWallView alloc] initWithStoneWall:wall];
    self.stoneWallView.frame = CGRectMake((self.view.bounds.size.width - self.stoneWallView.frame.size.width)/2,
                                           self.view.bounds.size.height - self.stoneWallView.frame.size.height,
                                           self.stoneWallView.frame.size.width, self.stoneWallView.frame.size.height);
    self.stoneWallView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.stoneWallView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Action
- (void)backAction:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
