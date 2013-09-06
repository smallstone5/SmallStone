//
//  Stone.m
//  SmallStone
//
//  Created by Jamin on 9/5/13.
//  Copyright (c) 2013 tencent. All rights reserved.
//

#import "Stone.h"

@interface Stone()

@property (nonatomic, strong) NSMutableArray *      stateImages;

@end

@implementation Stone


- (id)init
{
    self = [super init];
    if (self) {
        _state = kStoneStateNormal;
        _point = MatrixPointMake(0, 0);
        _color = [UIColor redColor];
        
        _stateImages = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < kStoneStateMax; i++) {
            [_stateImages addObject:[NSNull null]];
        }
    }
    return self;
}




#pragma mark - Image
- (void)setImage:(UIImage *)image forState:(StoneState)state
{
    id replacingImage = image;
    if (nil == replacingImage) {
        replacingImage = [NSNull null];
    }
    [self.stateImages replaceObjectAtIndex:state withObject:replacingImage];

}


- (UIImage *)imageForState:(StoneState)state
{
    if (state >= kStoneStateMax) {
        return nil;
    }
    
    UIImage * image = self.stateImages[state];
    if (![image isKindOfClass:[UIImage class]]) {
        image = [self defaultImage];
    }

    return image;
}



- (UIImage *)currentStateImage
{
    return [self imageForState:self.state];
}



- (UIImage *)defaultImage
{
    UIImage * image = self.stateImages[kStoneStateNormal];
    if (![image isKindOfClass:[UIImage class]]) {
        return nil;
    }

    return image;
}


@end
