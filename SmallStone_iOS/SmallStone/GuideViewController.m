//
//  GuideViewController.m
//  SmallStone
//
//  Created by hopo on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "GuideViewController.h"
#import "MainViewController.h"
#import "CommonUtility.h"
#import "ScoreManager.h"
#import "UserManager.h"

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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initGuide
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * 3, 0)];
    [scrollView setPagingEnabled:YES];  //视图整页显示
    //[scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    scrollView.delegate = self;
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    [imageview setContentMode:UIViewContentModeScaleAspectFit];
    imageview.clipsToBounds = YES;
    [imageview setImage:[UIImage imageNamed:@"1.jpg"]];
    [scrollView addSubview:imageview];
    //[imageview release];
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    [imageview1 setContentMode:UIViewContentModeScaleAspectFit];
    imageview1.clipsToBounds = YES;
    [imageview1 setImage:[UIImage imageNamed:@"2.jpg"]]; 
    [scrollView addSubview:imageview1];
    //[imageview1 release];
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * scrollView.frame.size.width, 0,  scrollView.frame.size.width, scrollView.frame.size.height)];
    [imageview2 setImage:[UIImage imageNamed:@"3.jpg"]];
    [imageview2 setContentMode:UIViewContentModeScaleAspectFit];
    imageview2.clipsToBounds = YES;
    imageview2.userInteractionEnabled = YES;
    [scrollView addSubview:imageview2];
    //[imageview2 release];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview2上加载一个透明的button
    [button setTitle:@"开始体验" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(50, 200, 230, 37)];
    [button setTitleColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:50 green:50 blue:50 alpha:0.5]];
    [button addTarget:self action:@selector(gotoMain) forControlEvents:UIControlEventTouchUpInside];
    [imageview2 addSubview:button];
    
	UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
	nicknameLabel.text = @"设置昵称：";
	[nicknameLabel setFrame:CGRectMake(20, 100, 130, 30)];
	[nicknameLabel setBackgroundColor:[UIColor colorWithRed:50 green:50 blue:50 alpha:0.9]];
	[imageview2 addSubview:nicknameLabel];
	
	self.nicknameField = [[UITextField alloc]initWithFrame:CGRectMake(120, 100, 130, 30)];
	self.nicknameField.text = [[UIDevice currentDevice] name];
	[imageview2 addSubview:self.nicknameField];
    [self.view addSubview:scrollView];
    //[scrollView release];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60, 320, 20)];
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [self.pageControl setBackgroundColor:[UIColor clearColor]];
    if ([self.pageControl respondsToSelector:@selector(pageIndicatorTintColor)]) {
        self.pageControl.pageIndicatorTintColor = [UIColor grayColor];
        self.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    }
    //[self pageControl ];
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = 3;
    [self.view addSubview:self.pageControl];
}

//进入游戏主界面
- (void)gotoMain
{
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didChangeUserName:)
												 name:REPORT_CHANGE_USER_NAME_NOTIFICATION
											   object:nil];
	[UserManager setUserName:self.nicknameField.text];
	[UserManager setUserDefaults:@"oldName" value:nil];
	[[ScoreManager defaultManager] reportTotalScore];
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

#pragma mark - NSNotification
- (void)didChangeUserName:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    NSInteger errorCode = [[userInfo objectForKey:@"errorCode"] integerValue];
	
    NSString *tips = nil;
	if(errorCode == kUserNameExistError) {
		tips = @"该昵称已存在！";
		[UserManager setUserDefaults:@"nickname" value:[UserManager getUserDefaults:@"oldName"]];
		[[[UIAlertView alloc] initWithTitle:@"" message:tips delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
		
	} else if (errorCode == 0) {
		[UserManager setUserDefaults:@"oldName" value:nil];
		[self presentViewController:[[MainViewController alloc] init] animated:YES completion:^(void){}];
	}
}

@end
