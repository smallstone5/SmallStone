//
//  RankViewController.m
//  SmallStone
//
//  Created by hopo on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "RankViewController.h"

@interface RankViewController ()

@end

@implementation RankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.rankTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [self initData];
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


#pragma data source

//获取数据，这里先手动构造
-(void)initData
{
    //先模拟生成出来，后续从接口拉取
	NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    
	for(int i = 1; i < 10; i++){
        NSMutableDictionary *userData = [[NSMutableDictionary alloc ]init];
		[userData setValue : [NSString stringWithFormat : @"%d", i] forKey :@"num"];              //名次
		[userData setValue : [NSString stringWithFormat : @"选手_%d",i] forKey :@"name"];          //name
        [userData setValue : [NSString stringWithFormat : @"%d",100000-i] forKey :@"point"];      //分数
		[userData setValue : [NSString stringWithFormat : @"http://avatar.csdn.net/7/4/6/1_shlei2002.jpg"] forKey :@"pic"];		//头像
        [dataArr addObject:userData];
	}

    self.rankData = [NSMutableArray arrayWithArray:dataArr];
}


#pragma tableview - action
//section个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//元素个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.rankData count];
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//禁止编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return false;
}

//头部行高
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


//自定义单元格样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"CustomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellWithIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    //cell.showsReorderControl = YES;
    
    //这一句非常重要，不重置的话会因为cell复用出现错误的accessory view
    //cell.accessoryView = nil;
    
    NSDictionary *userData = [self.rankData objectAtIndex:row];
    
    UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    pointLabel.text = [userData valueForKey:@"point"];
    pointLabel.backgroundColor = [UIColor clearColor];
    cell.accessoryView = pointLabel;
    

    cell.textLabel.text = [userData valueForKey:@"name"];
//    cell.imageView.image = [userData valueForKey:@"pic"];;
    float scale = (cell.frame.size.height-10)/cell.imageView.image.size.width;
    cell.imageView.transform = CGAffineTransformMakeScale(scale, scale);
    cell.detailTextLabel.text = nil;
    
    //选中时不设置颜色
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)viewDidUnload {
    [self setRankTable:nil];
    [super viewDidUnload];
}
@end
