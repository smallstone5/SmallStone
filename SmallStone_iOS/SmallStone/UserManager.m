//
//  UserManager.m
//  SmallStone
//
//  Created by Jamin on 9/7/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager


+ (void)setUserName:(NSString *)userName
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:userName forKey:@"nickname"];
	[defaults synchronize];
}


+ (NSString *)userName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults objectForKey:@"nickname"];
}


+ (void)setTotalScore:(NSUInteger)score
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber * scoreNumber = [NSNumber numberWithUnsignedInteger:score];
	[defaults setObject:scoreNumber forKey:@"totalScore"];
	[defaults synchronize];

}


+ (NSUInteger)totalScore
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	 NSNumber * scoreNumber = [defaults objectForKey:@"totalScore"];
    NSUInteger totalScore = 0;
    if ([scoreNumber isKindOfClass:[NSNumber class]]) {
        totalScore = [scoreNumber unsignedIntegerValue];
    }

    return totalScore;
}


@end
