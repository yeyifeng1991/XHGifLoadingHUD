//
//  XHGifHUDView.h
//  ZJProgressHUD
//
//  Created by mc on 2018/7/5.
//  Copyright © 2018年 ZeroJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHGifHUDView : UIView
/** 设置动画View*/

@property (nonatomic,assign) NSTimeInterval timeDelay;// 时间间隔 默认为5s
@property (nonatomic,assign) NSTimeInterval animationSpeed;// 动画评率 默认为0.05
@property (nonatomic,strong) UIView * showView; // 动画展示的View  默认为主视图的View
@property (nonatomic,strong) NSString * gifName; // 动画的名称 默认动画名称为run
/** 设置文字颜色 */
@property (strong, nonatomic) UIColor *loadingColor;

- (void)endLoading;// 结束动画
@end
