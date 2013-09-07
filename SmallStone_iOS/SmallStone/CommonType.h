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



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                                green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                                blue:((float)(rgbValue & 0xFF))/255.0 \
                                                alpha:1.0]

@interface NSObject(CommonType)

@end