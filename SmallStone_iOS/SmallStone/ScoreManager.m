//
//  ScoreManager.m
//  SmallStone
//
//  Created by Jamin on 9/7/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "ScoreManager.h"
#import "UserManager.h"
#import "CommonUtility.h"
#import "GameSetting.h"


#define SCORE_LIST_KEY           @"ScoreList"


@interface ScoreManager() <NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableArray *           scoreList;


@end

@implementation ScoreManager

+ (ScoreManager *)defaultManager
{
    static ScoreManager * _defaultManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _defaultManager = [[self alloc] init];
    });

    return _defaultManager;
}


- (id)init
{
    self = [super init];
    if (self) {
//        [self clearScoreData];  //测试代码
        [self loadScoreList];
    }

    return self;
}

#pragma mark - Getter
- (NSUInteger)totalScore
{
    NSUInteger totalScore = 0;
    for (NSNumber * scoreNumber in self.scoreList) {
        totalScore += [scoreNumber integerValue];
    }

    return totalScore;
}


#pragma mark - Public
- (BOOL)saveScore:(NSUInteger)score atLevel:(NSUInteger)level
{
    if (level >= g_levelCount) {
        NSLog(@"level(%d) over max level(%d)", level + 1, g_levelCount);
        return NO;
    }

    NSNumber * scoreNumber = [NSNumber numberWithInt:score];
    if (level > self.scoreList.count) {
        return NO;

    } else if (level == self.scoreList.count){
        [self.scoreList addObject:scoreNumber];
        [self updateTopLevel:level];

    } else {

        NSNumber * oldScoreNumber = self.scoreList[level];
        if ([oldScoreNumber unsignedIntegerValue] > score) {
            return NO;
        }
        [self.scoreList replaceObjectAtIndex:level withObject:scoreNumber];
    }

    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.scoreList forKey:SCORE_LIST_KEY];
    [defaults synchronize];

    [self reportTotalScore];
    return YES;
}



- (NSUInteger)scoreAtLevel:(NSUInteger)level
{
    if (level >= self.scoreList.count) {
        return 0;
    }

    NSNumber * scoreNumber = self.scoreList[level];
    return [scoreNumber unsignedIntegerValue];
}

- (void)reportTotalScore
{
    NSString * userName = [UserManager userName];
    if (nil == userName) {
        userName = [[UIDevice currentDevice] name];
    }

    const char * cUserName = [[userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] UTF8String];
    NSString * encodeDeviceId = [[CommonUtility getDeviceId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *appUrl = [NSString stringWithFormat:@"http://180.153.0.208/index.php?o=save"
                        @"&id=%@&name=%s&score=%d&level=%d", encodeDeviceId, cUserName, self.totalScore, self.topLevel];
    NSURL *url = [NSURL URLWithString:appUrl];
	NSLog(@"%@", url);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [urlConnection start];
}



- (void)clearScoreData
{
    self.scoreList = [NSMutableArray array];
    _topLevel = 0;
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:SCORE_LIST_KEY];
    [defaults synchronize];
}



#pragma mark - Private
- (void)loadScoreList
{
    self.scoreList = [[NSUserDefaults standardUserDefaults] objectForKey:SCORE_LIST_KEY];
    if (nil == self.scoreList) {
        self.scoreList = [NSMutableArray array];
    }
    NSInteger savedLevel = self.scoreList.count - 1;
    _topLevel = MAX(savedLevel, 0);
}


- (void)updateTopLevel:(NSUInteger)level
{
    if (_topLevel < level) {
        _topLevel = level;
    }
}



#pragma mark - NSURLConnection
//实现连接失败的委托方法
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"reportScore connect failed(%@)", error);
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse * httpResponse = (NSHTTPURLResponse *)response;
    NSLog(@"reportScore statusCode:%d", httpResponse.statusCode);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
{
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSLog(@"reportScore json:%@", json);
	NSInteger errorCode = [[json objectForKey:@"errCode"] integerValue];

    NSNumber * errorCodeNum = [NSNumber numberWithInt:errorCode];
    NSDictionary * userInfo = @{@"errorCode": errorCodeNum};
    [[NSNotificationCenter defaultCenter] postNotificationName:REPORT_CHANGE_USER_NAME_NOTIFICATION object:nil userInfo:userInfo];

}




@end
