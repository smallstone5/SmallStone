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


#define SCORE_LIST_KEY           @"ScoreList"

static NSUInteger const kMaxLevel   =   200;

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
        [self clearScoreData];
        [self loadScoreList];
    }

    return self;
}

#pragma mark - Getter
- (NSUInteger)totalScore
{
    NSUInteger totalScore = 0;
    NSUInteger level = 0;
    do {
        
        NSNumber * scoreNumber = self.scoreList[level];
        NSUInteger score = [scoreNumber unsignedIntegerValue];
        if (score > 0) {
            totalScore += score;
        } else {
            break;
        }

        level++;
    } while (level < kMaxLevel);

    return totalScore;
}


#pragma mark - Public
- (BOOL)saveScore:(NSUInteger)score atLevel:(NSUInteger)level
{
    if (nil == self.scoreList) {
        [self loadScoreList];
    }

    if (level >= self.scoreList.count) {
        return NO;
    }

    NSNumber * oldScoreNumber = self.scoreList[level];
    if ([oldScoreNumber unsignedIntegerValue] > score) {
        return NO;
    }

    [self updateTopLevel:level];
    NSNumber * scoreNumber = [NSNumber numberWithInt:score];
    [self.scoreList replaceObjectAtIndex:level withObject:scoreNumber];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.scoreList forKey:SCORE_LIST_KEY];
    [defaults synchronize];

    [self reportTotalScore];
    return YES;
}



- (NSUInteger)scoreAtLevel:(NSUInteger)level
{
    if (nil == self.scoreList) {
        [self loadScoreList];
    }

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

    NSString * encodeUserName = [userName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * encodeDeviceId = [[CommonUtility getDeviceId] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *appUrl = [NSString stringWithFormat:@"http://180.153.0.208/index.php?o=save"
                        @"&id=%@&name=%@&score=%d&level=%d", encodeDeviceId, encodeUserName, self.totalScore, self.topLevel];
    NSURL *url = [NSURL URLWithString:appUrl];
	NSLog(@"%@", url);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [urlConnection start];
}



- (void)clearScoreData
{
    self.scoreList = nil;
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
        self.scoreList = [NSMutableArray arrayWithCapacity:kMaxLevel];
        NSNumber * zeroNumber = [NSNumber numberWithInt:0];
        NSUInteger level = 0;
        while (level < kMaxLevel) {
            [self.scoreList addObject:[zeroNumber copy]];
            [self updateTopLevel:_topLevel];
            level++;
        }
    }
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
