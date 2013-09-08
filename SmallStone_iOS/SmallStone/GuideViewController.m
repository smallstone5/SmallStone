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
    NSInteger pageNum = 4;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [scrollView setContentSize:CGSizeMake(self.view.bounds.size.width * pageNum, 0)];
    [scrollView setPagingEnabled:YES];  //视图整页显示
    //[scrollView setBounces:NO]; //避免弹跳效果,避免把根视图露出来
    scrollView.delegate = self;
    
    UIImageView *imageview1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    [imageview1 setContentMode:UIViewContentModeScaleAspectFit];
    imageview1.clipsToBounds = YES;
    [imageview1 setImage:[UIImage imageNamed:@"1.jpg"]];
    [scrollView addSubview:imageview1];
    
    UIImageView *imageview2 = [[UIImageView alloc] initWithFrame:CGRectMake(scrollView.frame.size.width, 0, scrollView.frame.size.width, scrollView.frame.size.height)];
    [imageview2 setContentMode:UIViewContentModeScaleAspectFit];
    imageview2.clipsToBounds = YES;
    [imageview2 setImage:[UIImage imageNamed:@"2.jpg"]];
    [scrollView addSubview:imageview2];
    
    UIImageView *imageview3 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * scrollView.frame.size.width, 0,  scrollView.frame.size.width, scrollView.frame.size.height)];
    [imageview3 setImage:[UIImage imageNamed:@"3.jpg"]];
    [imageview3 setContentMode:UIViewContentModeScaleAspectFit];
    imageview3.clipsToBounds = YES;
    imageview3.userInteractionEnabled = YES;
    [scrollView addSubview:imageview3];
    
    UIImageView *imageview4 = [[UIImageView alloc] initWithFrame:CGRectMake(3 * scrollView.frame.size.width, 0,  scrollView.frame.size.width, scrollView.frame.size.height)];
    [imageview4 setImage:[UIImage imageNamed:@"4.jpg"]];
    [imageview4 setContentMode:UIViewContentModeScaleAspectFit];
    imageview4.clipsToBounds = YES;
    imageview4.userInteractionEnabled = YES;
    [scrollView addSubview:imageview4];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tiyan.png"] forState:UIControlStateNormal];
    [button setFrame:CGRectMake(self.view.bounds.size.width - 200, self.view.bounds.size.height - 150, 150, 40)];
    [button setTitleColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:1.0] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:50 green:50 blue:50 alpha:0.5]];
    [button addTarget:self action:@selector(gotoMain) forControlEvents:UIControlEventTouchUpInside];
    [imageview4 addSubview:button];
    
	UILabel *nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 50, 60, 30)];
	nicknameLabel.text = @"昵称:";
	//[nicknameLabel setFrame:CGRectMake(20, 100, 130, 30)];
	[nicknameLabel setBackgroundColor:[UIColor colorWithRed:50 green:50 blue:50 alpha:0.9]];
	[imageview4 addSubview:nicknameLabel];
	
	self.nicknameField = [[UITextField alloc]initWithFrame:CGRectMake(80, 50, 200, 30)];
	self.nicknameField.text = [[UIDevice currentDevice] name];
    self.nicknameField.borderStyle = UITextBorderStyleRoundedRect;
	[imageview4 addSubview:self.nicknameField];
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
    self.pageControl.numberOfPages = pageNum;
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
