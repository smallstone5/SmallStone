//
//  CommonType.m
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "CommonType.h"
CGRect g_rcScreen;

CGPoint ConvertPtTopLeftToBottomLeft(CGPoint pt)
{
    return CGPointMake(pt.x, g_rcScreen.size.height - pt.y);
}

CGPoint ConvertPtBottomLeftToTopLeft(CGPoint pt)
{
    return CGPointMake(pt.x, g_rcScreen.size.height - pt.y);
}

@implementation NSObject(CommonType)

+ (void) load
{
    g_rcScreen = [[UIScreen mainScreen] bounds];
}

@end
