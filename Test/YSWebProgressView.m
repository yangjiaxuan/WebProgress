//
//  YSWebProgressView.m
//  Test
//
//  Created by yangsen on 16/11/11.
//  Copyright © 2016年 sitemap. All rights reserved.

#import "YSWebProgressView.h"

#define SELF_W (self.frame.size.width)
#define SELF_H (self.frame.size.height)

@interface YSWebProgressView()
{
    CAGradientLayer *_maskLayer;
}
@end
@implementation YSWebProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupData];
        [self setLayer];
    }
    return self;
}

- (void)setupData{
    _progress           = 0;
    self.colors         = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor blueColor].CGColor];
    self.colorLocations = @[@(0.1f)];
    self.clipsToBounds  = YES;
}
- (void)setLayer{

    _maskLayer  = [CAGradientLayer layer];
    _maskLayer.frame = CGRectMake(0, 0, 0.1, SELF_H);
    _maskLayer.colors    = self.colors;
    _maskLayer.locations = self.colorLocations;
    //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
    _maskLayer.startPoint = CGPointMake(0, 0);
    _maskLayer.endPoint   = CGPointMake(1, 0);
    
    [self.layer addSublayer:_maskLayer];
}

- (void)start{

    _progress = 0.7;
    [self maskLayerSetAnimationDuration:3];
}

- (void)finished{
    _progress = 1;
    [self maskLayerSetAnimationDuration:0.5];
}

- (void)maskLayerSetAnimationDuration:(CGFloat)duration{
    [CATransaction begin];
    [CATransaction setAnimationDuration:duration];
    [CATransaction setAnimationTimingFunction:_timeFunction];
    _maskLayer.frame = CGRectMake(0, 0,_progress*SELF_W, SELF_H);
    [CATransaction commit];
    
    __weak typeof (self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof (self) strongSelf = weakSelf;
        if (strongSelf.completeAction) {
            strongSelf.completeAction();
        }
    });
}

- (void)setProgress:(CGFloat)progress animation:(BOOL)animation{
    if (animation) {
        self.progress = progress;
    }
    else{
        _progress = progress;
        CGRect frame = self.frame;
        self.frame = CGRectMake(0, 0,_progress*SELF_W, SELF_H);
        _maskLayer.frame = self.frame;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.frame = frame;
        });
    }
}
#pragma mark ------ 属性 --------
- (void)setColors:(NSArray *)colors{
    _colors = [colors copy];
    if (colors.count == 1) {
        _maskLayer.backgroundColor = (__bridge CGColorRef)colors.firstObject;
    }
    _maskLayer.colors = _colors;
}

- (void)setColorLocations:(NSArray *)colorLocations{
    _colorLocations = [colorLocations copy];
    _maskLayer.locations = _colorLocations;
}

- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self maskLayerSetAnimationDuration:0.25];
}

@end
