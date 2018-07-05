//
//  HXLoadingView.m
//  XHLoadingGIf
//
//  Created by mc on 2018/6/26.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import "XHLoadingView.h"
#import "XHGifHUDView.h"
#import "ZJPrivateHUDProtocol.h"
@interface XHLoadingView ()


@end

@implementation XHLoadingView(Public)
/** 显示gif动画图*/
+(void)showLoadingView:(UIView*)showView
{
    XHLoadingView *hudView = [XHLoadingView sharedInstance];
    XHGifHUDView *progressView = [[XHGifHUDView alloc] init];
    [progressView setGifName:nil];

    [hudView setHudView:progressView];
    [hudView showWithTime:0.0f]; // 设置隐藏时间
}
// showTime 设置隐藏时间
+ (void)showLoadingViewandAutoHideAfterTime:(CGFloat)showTime;
{
    XHLoadingView *hudView = [XHLoadingView sharedInstance];
    XHGifHUDView *progressView = [[XHGifHUDView alloc] init];
    [progressView setGifName:nil];
    
    [hudView setHudView:progressView];
    [hudView showWithTime:showTime]; // 设置隐藏时间
}
+(void)showLoadingGifname:(NSString*)gifName;
{
    XHLoadingView *hudView = [XHLoadingView sharedInstance];
    XHGifHUDView *progressView = [[XHGifHUDView alloc] init];
    [progressView setGifName:gifName];
    [hudView setHudView:progressView];
    [hudView showWithTime:0.0f]; // 设置隐藏时间
}
// 结束动画
+(void)endLoadingView:(UIView*)showView;
{
     [[XHLoadingView sharedInstance] hide];
}
@end


// 工具类操作
@implementation XHLoadingView
+ (instancetype)sharedInstance {
    static XHLoadingView *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [[XHLoadingView alloc] init];
    });
    
    return hud;
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        //        self.backgroundColor = [UIColor cyanColor];
    }
    return self;
}

- (void)showWithTime:(CGFloat)time {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    if (self.superview == nil) {
        [window addSubview:self];
    }
    if (time > 0) {
        __weak typeof(self) weakself = self;
        delay(time, ^{
            __strong typeof(weakself) strongSelf = weakself;
            if (strongSelf) {
                [strongSelf hide];
            }
            //            [[ZJProgressHUD sharedInstance] hide];
        });
    }
}

- (void)hide {
    /// 首先移除先添加的
    UIView *firstHud = [self.subviews firstObject];
    if (firstHud) {
        [firstHud removeFromSuperview];
        if (self.subviews.count == 0) {
            if ([firstHud isKindOfClass:[XHGifHUDView class]]) {
                [((XHGifHUDView *)firstHud) endLoading];
            }
            [self removeFromSuperview];
        }
    }
    else {
        [self removeFromSuperview];
    }
}

- (void)hideAllHUDs {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];// 让数组中的每个元素都调用
    
    [self removeFromSuperview];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.superview) {// superView == window
        self.frame = self.superview.bounds;
        for (UIView *subview in self.subviews) {
            if ([subview conformsToProtocol:@protocol(ZJPrivateHUDProtocol)]) {
                /// 居中显示
                subview.center = self.center;
            }
            else {
                /// 自定义的hudView
                CGRect frame = subview.frame;
                subview.frame = frame;
                
            }
        }
    }
}
/// 这里直接使用了GCD, 当然推荐使用NSTimer
static void delay(CGFloat time, dispatch_block_t block) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (block) {
            block();
        }
    });
}


- (void)setHudView:(UIView *)hudView {
    [self addSubview:hudView];
}

@end
