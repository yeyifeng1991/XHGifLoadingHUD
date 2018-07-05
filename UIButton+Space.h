//
//  UIButton+Space.h
//  Xindai360
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Space)

- (instancetype)imageViewLeftAndTitleLabelRightWithSpace:(CGFloat)space;

- (instancetype)titleLabelLeftAndImageViewRightWithSpace:(CGFloat)space;

- (instancetype)imageViewTopAndTitleLabelBottomWithSpace:(CGFloat)space;

- (instancetype)titleLabelTopAndImageViewBottomWithSpace:(CGFloat)space;

- (instancetype)titleLabelAndImageViewAllInCenter;

//仅仅文本存在
- (instancetype)onlyTitleExist;

//专门为了适配首页的特殊图标
- (instancetype)titleLabelLeftAndImageViewRightAndBottomWithSpace:(CGFloat)space;

@end
