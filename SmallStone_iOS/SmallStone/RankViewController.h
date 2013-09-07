//
//  RankViewController.h
//  SmallStone
//
//  Created by hopo on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *rankTable;
@property (strong, nonatomic) NSArray *rankData;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicatorView;
- (IBAction)goBack:(id)sender;

@end
