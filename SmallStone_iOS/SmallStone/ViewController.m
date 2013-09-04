//
//  ViewController.m
//  SmallStone
//
//  Created by Jamin on 9/4/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "ViewController.h"
#import "GameViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) newGame:(id)sender
{
    GameViewController *gameController = [[GameViewController alloc] initWithNibName: @"GameViewController" bundle: [NSBundle mainBundle]];
    gameController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController: gameController animated: YES completion: nil];
}
@end
