//
//  HXLoadingView.h
//  XHLoadingGIf
//
//  Created by mc on 2018/6/26.
//  Copyright © 2018年 jiucangtouzi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XHLoadingView : UIView
// 单例方法
+ (instancetype)sharedInstance;
// 初始化方法
- (instancetype)init;
// 设置/添加hudView的方法
- (void)setHudView:(UIView *)hudView;
// 被window弹出的方法, 同时设置显示的时间, 当设置的时间小于等于0的时候将不会自动移除
- (void)showWithTime:(CGFloat)time;
// 移除hud的方法
- (void)hide;
// 移除所有hud的方法
- (void)hideAllHUDs;
@end



@interface XHLoadingView (Public)


// 展示动画 设设置显示View
+(void)showLoadingView:(UIView*)showView;
// gifName 设置gif动态图的名称
+(void)showLoadingGifname:(NSString*)gifName;
// showTime 设置隐藏时间
+ (void)showLoadingViewandAutoHideAfterTime:(CGFloat)showTime;
// 结束动画
+(void)endLoadingView:(UIView*)showView;


 
// // 动画消失
// +(void)endLoading;
//
// // 展示动画 不会消失
// +(void)showLoading;
//
// // 开始动画 默认时间消失
// +(void)startLoading;
// /*
// @showView 展示的View
// @timeDelay 消失的时间
// */
//+(void)showWithView:(UIView*)showView dismissDelay:(NSTimeInterval)timeDelay;
///*
// @showView 展示的View
// @timeDelay 消失的时间
// @Speed     动画运行的速度
// */
//+(void)showWithView:(UIView*)showView animationSpeed:(NSTimeInterval)Speed dismissDelay:(NSTimeInterval)timeDelay;
///*
// @showView 展示的View
// @gifName  动画的名称
// @timeDelay 消失的时间
// @Speed     动画运行的速度
// */
//+(void)showWithView:(UIView*)showView gifName:(NSString*)gifName animationSpeed:(NSTimeInterval)Speed dismissDelay:(NSTimeInterval)timeDelay;
//
//


@end
