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
        // Custom initialization
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	nickname.text = [UserManager userName];
    // Do any additional setup after loading the view from its nib.
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
		[[ScoreManager alloc] reportScore:0];
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

@end
