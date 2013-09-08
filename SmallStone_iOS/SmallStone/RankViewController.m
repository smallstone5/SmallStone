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

#define BASE_URL @"http://180.153.0.208/index.php?o=rank"

@implementation RankViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *backButton = [UIButton buttonWithType:101];
        [backButton addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        self.navigationItem.leftBarButtonItem = backItem;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //[self initData];
    [self getAllData];
    endDataFlag = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:50/255.0 green:50/255.0 blue:50/255.0 alpha:1];
        
    self.rankTable.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma data source

//获取数据，这里先手动构造，用于测试
-(void)initData
{
    //先模拟生成出来，后续从接口拉取
	NSMutableArray *dataArr = [[NSMutableArray alloc] init];
    
	for(int i = 1; i < 10; i++){
        NSMutableDictionary *userData = [[NSMutableDictionary alloc ]init];
		[userData setValue : [NSString stringWithFormat : @"%d", i] forKey :@"num"];              //名次
		[userData setValue : [NSString stringWithFormat : @"选手_%d",i] forKey :@"name"];          //name
        [userData setValue : [NSString stringWithFormat : @"%d",10000-i] forKey :@"point"];      //分数
		[userData setValue : [NSString stringWithFormat : @"http://avatar.csdn.net/7/4/6/1_shlei2002.jpg"] forKey :@"pic"];		//头像
        [dataArr addObject:userData];
	}

    self.rankData = [NSMutableArray arrayWithArray:dataArr];
}


//通过接口拉取全部信息
-(void)getAllData
{
    //异步调用接口设置以前的session无效，此步骤失败也无影响
    NSString *appUrl = [[NSString alloc] initWithFormat:@"%@", BASE_URL];
    NSURL *url = [NSURL URLWithString:appUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [urlConnection start];
    
    //加载状态
    [self showRankStart];
}

//开始加载
-(void)showRankStart
{
    UIActivityIndicatorView *loadView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadView setCenter:self.navigationItem.titleView.center];
    [loadView setHidesWhenStopped:YES];
    self.navigationItem.titleView = loadView;
    [loadView startAnimating];
}


//结束加载
-(void)showRankEnd
{
    self.navigationItem.titleView = nil;
    self.title = @"排行榜";
    endDataFlag = YES;
}

//实现连接失败的委托方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    
    [self showRankEnd];
    NSLog(@"网络连接失败");
}

//实现获取到数据的委托方法
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if (json == nil) {
        [self showRankEnd];
        return;
    }
    NSString *result = [json objectForKey:@"errCode"];
    if ([result intValue] == 0) {
        [self showRankEnd];
        
        int num = 1;
        NSDictionary *rows = [json objectForKey:@"result"];
        
        //先模拟生成出来，后续从接口拉取
        NSMutableArray *dataArr = [[NSMutableArray alloc] init];
        for (NSDictionary* row in rows) {
            NSMutableDictionary *userData = [[NSMutableDictionary alloc ]init];
            [userData setValue : [NSString stringWithFormat:@"%d", num++] forKey :@"num"];   //名次
            [userData setValue : [row objectForKey:@"name"] forKey :@"name"];   //名字
            [userData setValue : [row objectForKey:@"score"] forKey :@"point"];	//分数
            [userData setValue : [row objectForKey:@"level"] forKey :@"block"];	//关数
            [userData setValue : [row objectForKey:@"face"] forKey :@"pic"];   //用户头像地址
            [userData setValue : [row objectForKey:@"id"] forKey :@"deviceid"]; //设备唯一id
            [dataArr addObject:userData];
        }
        
        self.rankData = [NSMutableArray arrayWithArray:dataArr];
        //在主线程reload数据，防止datasource有误时出现crash
        [self.rankTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }
    
}

#pragma getdevice id
/*-(NSString *)getDeviceId
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
}*/


#pragma tableview - action
//section个数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//元素个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (endDataFlag && self.rankData) {
        return [self.rankData count];
    }
    return 1;
}

//设置行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
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

//标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	return @"";
}

/*
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    
    headerLabel.font = [UIFont boldSystemFontOfSize:20];
    headerLabel.frame = CGRectMake(10.0, 0-10, 300.0, 44.0);
    
    
    headerLabel.text = @"test";
    return headerLabel;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
}*/


//自定义单元格样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"CustomCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellWithIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    if (endDataFlag && !self.rankData && 0 == row) {
        cell.detailTextLabel.text = nil;
        cell.textLabel.text = @"暂无排名数据.";
        return cell;
    }
    
    if (endDataFlag) {
        cell.accessoryView = nil;
        NSDictionary *userData = [self.rankData objectAtIndex:row];
        
        NSInteger index = [[userData valueForKey:@"num"] intValue];
        UIView *accessoryView = [self customAccessoryView:index];
        cell.accessoryView = accessoryView;

        cell.textLabel.text = [NSString stringWithFormat:@"%@", [userData valueForKey:@"name"]];
    
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[userData valueForKey:@"pic"]]];
        cell.imageView.image = [UIImage imageWithData:imageData];
        float scale = 40.0/cell.imageView.image.size.width;
        cell.imageView.transform = CGAffineTransformMakeScale(scale, scale);
        cell.detailTextLabel.text = [NSString stringWithFormat:@"分数:%@, 通关数: %@", [userData valueForKey:@"point"], [userData valueForKey:@"block"]];
    
        //选中时不设置颜色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

//设置cell颜色
- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell forRowAtIndexPath: (NSIndexPath*)indexPath
{
    NSUInteger row = [indexPath row];
    NSDictionary *userData = [self.rankData objectAtIndex:row];
    NSString *name = [userData valueForKey:@"name"];
    if ([self isCuruserRank:name]) {
        UIColor *cellBackgroundColor = [UIColor colorWithRed:128/255.0 green:108/255.0 blue:61/255.0 alpha:0.3];
        cell.backgroundColor = cellBackgroundColor;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryView.backgroundColor = [UIColor clearColor];

    }
}

//是否当前用户的排名
-(BOOL)isCuruserRank:(NSString *)name
{
    NSString *curUsername = [[NSUserDefaults standardUserDefaults] valueForKey:@"nickname"];
    if ([curUsername isEqualToString:name]) {
        return YES;
    }
    return NO;
}

//自定义排名效果
-(id)customAccessoryView:(NSInteger)index
{
    id view;
    switch (index) {
        case 0:
            break;
        case 1:
        case 2:
        case 3:
        {
            //自定义button
            UIButton *button;
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"No%d.png", index]];
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            CGRect frame = CGRectMake(0, 0, 45, 45);
            button.frame = frame;
            [button setBackgroundImage:image forState:UIControlStateNormal];
            button.backgroundColor = [UIColor clearColor];
            view = button;
        }
            
            break;
        default:
        {
            UILabel *pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
            pointLabel.text = [NSString stringWithFormat:@"第%d名", index];
            pointLabel.backgroundColor = [UIColor clearColor];
            view = pointLabel;
        }
            break;
    }
    
    return view;
}


- (void)viewDidUnload {
    [self setRankTable:nil];
    [super viewDidUnload];
}

//返回
- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^(void){}];
}
@end
