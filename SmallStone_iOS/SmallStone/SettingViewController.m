//
//  SettingViewController.m
//  SmallStone
//
//  Created by Andy on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "SettingViewController.h"
#import "UserManager.h"

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
    [UserManager setUserName:nickname.text];
	//NSLog(@"%@", [defaults objectForKey:@"serviceIp"]);
	//请求后台创建该用户名
	//NSString *appUrl = [[NSString alloc] initWithFormat:@"%@", saveNicknameURL];
	NSMutableString *appUrl = [[NSMutableString alloc] initWithString:saveNicknameURL];
	[appUrl appendString:@"&id="];
	//[appUrl appendString:@""]
	NSLog(@"%@", appUrl, [self getDeviceId]);
	
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
-(NSString *)getDeviceId
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    NSString *uniqueId;
    if (version <= 5.0)
    {
        uniqueId = [[UIDevice currentDevice]  uniqueIdentifier];
    }
    else
    {
        uniqueId = [[UIDevice currentDevice] identifierForVendor];
    }
    
    return uniqueId;
}
@end
