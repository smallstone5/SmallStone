//
//  BaseBall.h
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonType.h"

@interface BaseBall : UIImageView {
    
}

- (void) updateData: (CFTimeInterval) delta;
- (void) gameDraw;
- (void) reset;
- (void) bomb;

@end
