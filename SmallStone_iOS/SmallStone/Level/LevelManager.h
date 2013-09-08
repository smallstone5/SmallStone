//
//  LevelManager.h
//  SmallStone
//
//  Created by song dan on 13-9-8.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseLevel.h"

@interface LevelManager : NSObject

+ (LevelManager *) sharedInstance;
- (BaseLevel *) makeCurrentLevel;

@end
