//
//  CommonType.h
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
#endif
    
    extern CGPoint ConvertPtTopLeftToBottomLeft(CGPoint pt);
    extern CGPoint ConvertPtBottomLeftToTopLeft(CGPoint pt);
    
#ifdef __cplusplus
}
#endif

extern CGRect g_rcScreen;

@interface NSObject(CommonType)

@end