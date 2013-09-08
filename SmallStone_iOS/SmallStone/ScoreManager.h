//
//  ScoreManager.h
//  SmallStone
//
//  Created by Jamin on 9/7/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreManager : NSObject



+ (ScoreManager *)defaultManager;



- (void)reportScore:(NSUInteger)score;

@end
