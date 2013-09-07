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

@interface ScoreManager() <NSURLConnectionDelegate>

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

    }

    return self;
}


#pragma mark - Public
- (void)reportScore:(NSUInteger)score
{
    NSString * userName = [UserManager userName];
    if (nil == userName) {
        userName = [[UIDevice currentDevice] name];
    }
    NSString *appUrl = [NSString stringWithFormat:@"http://180.153.0.208/index.php?o=save"
                        @"&id=%@&name=%@&score=%d", [CommonUtility getDeviceId], userName, score];
    NSURL *url = [NSURL URLWithString:appUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSURLConnection *urlConnection = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    [urlConnection start];
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
}




@end
