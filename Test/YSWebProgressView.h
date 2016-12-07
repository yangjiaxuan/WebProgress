//
//  YSWebProgressView.h
//  Test
//
//  Created by yangsen on 16/11/11.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSWebProgressView : UIView

@property (assign, nonatomic) CGFloat progress;

// CGColor 颜色的分段，每一段的颜色 (例子：两段颜色时,@[(id)[UIColor whiteColor].CGColor,(id)[UIColor blueColor])
@property (copy, nonatomic) NSArray *colors;
// 颜色的分段位置（如果有两段颜色，这两段颜色的分段位置(例子：两段颜色时,@[@(0.3)])）
@property (copy, nonatomic) NSArray *colorLocations;

@property (copy, nonatomic) CAMediaTimingFunction *timeFunction;

// 完成时action
@property (copy, nonatomic) dispatch_block_t completeAction;

- (void)start;
- (void)finished;

- (void)setProgress:(CGFloat)progress animation:(BOOL)animation;

@end
