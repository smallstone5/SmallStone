//
//  SettingViewController.m
//  SmallStone
//
//  Created by Andy on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "SettingViewController.h"
#import "UserManager.h"
#import "ScoreManager.h"

@interface SettingViewController ()

@end

#define saveNicknameURL @"http://180.153.0.208/index.php?o=save&id=:uuid&name=:nickname&token=google"

@implementation SettingViewController

@synthesize nickname;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

        UIButton *backButton = [UIButton buttonWithType:101];
        [backButton addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];

        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;



        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeUserName:)
                                                     name:REPORT_CHANGE_USER_NAME_NOTIFICATION
                                                   object:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
    self.title = NSLocalizedString(@"设置", @"设置");
	nickname.text = [UserManager userName];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) backButtonAction:(id)sender
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void) saveButtonAction:(id)sender
{
	NSString *alertStr = nil;
	if([nickname.text length] == 0) {
		alertStr = @"昵称不能为空！";
		[[[UIAlertView alloc] initWithTitle:@"" message:alertStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
	} else {
		[UserManager setUserDefaults:@"oldName" value:[UserManager userName]];
		[UserManager setUserName:nickname.text];
        [[ScoreManager defaultManager] reportTotalScore];
	}
}

-(void)sendCreateData
{
	
    /*
    NSString *appUrl = [[NSString alloc] initWithFormat:@"%@", saveNicknameURL];
    NSURL *url = [NSURL URLWithString:appUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [urlConnection start];
    [self showNetworkActivityIndicator];
	*/
}

-(void) textFieldDoneEditing:(id)sender
{
	[self resignFirstResponder];
}

-(void) backgroundTap:(id)sender
{
	[nickname resignFirstResponder];
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
	} else if (errorCode == 0 && [UserManager getUserDefaults:@"oldName"] != nil) {
		[UserManager setUserDefaults:@"oldName" value:nil];
		tips = @"昵称设置成功！";
	}

	if(tips != nil) {
		[[[UIAlertView alloc] initWithTitle:@"" message:tips delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil] show];
	}
}

@end
