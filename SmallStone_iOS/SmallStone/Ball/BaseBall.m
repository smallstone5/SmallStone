//
//  BaseBall.m
//  SmallStone
//
//  Created by zhuochen on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import "BaseBall.h"


@implementation BaseBall


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
        
    }
    return self;
}

- (void) updateData: (CFTimeInterval) delta
{
    
}

- (void) gameDraw
{
    
}

- (void) reset
{
    
}

- (void) bomb
{
    self.image = nil;
    [self startAnimating];
}

- (void) dealloc
{

}

@end
