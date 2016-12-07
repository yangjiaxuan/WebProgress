//
//  ViewController.m
//  Test
//
//  Created by yangsen on 16/11/10.
//  Copyright © 2016年 sitemap. All rights reserved.
//

#import "ViewController.h"
#import "YSWebProgressView.h"

@interface ViewController ()
{
    YSWebProgressView *webP;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    webP = [[YSWebProgressView alloc]initWithFrame:(CGRect){{0,64},{self.view.frame.size.width, 3}}];
    webP.colors = @[(id)[UIColor whiteColor].CGColor,(id)[UIColor blueColor].CGColor,(id)[UIColor purpleColor].CGColor];
    //    webP.colors = @[(id)[UIColor purpleColor].CGColor];

    webP.colorLocations = @[@(0.1),@(0.8)];
    webP.completeAction = ^(){
        NSLog(@"本段滑动已经结束");
    };
    [self.view addSubview:webP];
    
}
- (IBAction)clear:(id)sender {
    [webP setProgress:0 animation:NO];
}

NSTimer *_timer;
- (IBAction)autoAction:(id)sender {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
        return;
    }
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionDo) userInfo:nil repeats:YES];
}

- (void)actionDo{
    if (webP.progress >= 1) {
        return;
    }
    webP.progress += 0.1;
}

- (IBAction)start:(UIButton *)sender {
    [webP start];
}
- (IBAction)end:(id)sender {
    [webP finished];
}


@end
