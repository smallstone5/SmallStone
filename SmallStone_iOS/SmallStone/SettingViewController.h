//
//  SettingViewController.h
//  SmallStone
//
//  Created by Andy on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController
{
	IBOutlet UITextField * nickname;
}
@property (nonatomic, strong) UIButton *  backButton;
@property (nonatomic, strong) UIButton *  saveButton;
@property (nonatomic, retain) UITextField * nickname;

-(IBAction)backButtonAction:(id) sender;
-(IBAction)saveButtonAction:(id) sender;
-(IBAction)textFieldDoneEditing:(id)sender;
-(IBAction)backgroundTap:(id)sender;

@end
