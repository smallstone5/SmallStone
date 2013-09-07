//
//  SettingViewController.m
//  SmallStone
//
//  Created by Andy on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

@synthesize nickname;
@synthesize serviceIp;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		NSUserDefaults * Setting = [NSUserDefaults standardUserDefaults];
		serviceIp.text = [Setting objectForKey:@"serviceIp"];
		nickname.text = [Setting objectForKey:@"nickname"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:serviceIp.text forKey:@"serviceIp"];
	[defaults setObject:nickname.text forKey:@"nickname"];
	[defaults synchronize];

	//NSLog(@"%@", [defaults objectForKey:@"serviceIp"]);
}

-(void) textFieldDoneEditing:(id)sender
{
	[self resignFirstResponder];
}

-(void) backgroundTap:(id)sender
{
	[serviceIp resignFirstResponder];
	[nickname resignFirstResponder];
}

@end
