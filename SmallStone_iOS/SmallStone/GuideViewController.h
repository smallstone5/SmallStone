//
//  GuideViewController.h
//  SmallStone
//
//  Created by hopo on 13-9-6.
//  Copyright (c) 2013年 tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController <UIScrollViewDelegate>
{
    
}

@property (retain, nonatomic) UIScrollView *pageScroll;
@property (retain, nonatomic) UIPageControl *pageControl;


@end
