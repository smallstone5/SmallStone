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
	[self setUserDefaults:@"nickname" value:userName];
}

+(void) setUserDefaults:(NSString *)key value:(NSString *)val
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:val forKey:key];
	[defaults synchronize];
}

+(NSString *) getUserDefaults:(NSString *)key
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	return [defaults objectForKey:key];

}
+ (NSString *)userName
{
	return [self getUserDefaults:@"nickname"];
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
