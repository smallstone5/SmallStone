//
//  GuideViewController.m
//  SmallStone
//
//  Created by hopo on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "GuideViewController.h"
#import "MainViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

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
    self.view.backgroundColor = [UIColor clearColor];
    
    [self initGuide];
}

- (void)initGuide
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 640)];
    [scrollView setContentSize:CGSizeMake(960, 0)];
    [scrollView setPagingEnabled:YES];  //视图整页显示
    //[scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    scrollView.delegate = self;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    [imageview setImage:[UIImage imageNamed:@"1.jpg"]];
    [scrollView addSubview:imageview];
    //[imageview release];
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 0, 320, 460)];
    [imageview1 setImage:[UIImage imageNamed:@"2.jpg"]];
    [scrollView addSubview:imageview1];
    //[imageview1 release];
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(640, 0, 320, 460)];
    [imageview2 setImage:[UIImage imageNamed:@"3.png"]];
    imageview2.userInteractionEnabled = YES;
    [scrollView addSubview:imageview2];
    //[imageview2 release];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview2上加载一个透明的button
    [button setTitle:@"开始体验" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(50, 100, 230, 37)];
    [button setTitleColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:50 green:50 blue:50 alpha:0.5]];
    [button addTarget:self action:@selector(gotoMain) forControlEvents:UIControlEventTouchUpInside];
    [imageview2 addSubview:button];
    
    [self.view addSubview:scrollView];
    //[scrollView release];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 400, 320, 20)];
    [self.pageControl setBackgroundColor:[UIColor clearColor]];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 3;
    [self.view addSubview:self.pageControl];
}

//进入游戏主界面
- (void)gotoMain
{
    [self presentViewController:[[MainViewController alloc] init] animated:YES completion:^(void){}];
}


//滑动翻页
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.view.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
