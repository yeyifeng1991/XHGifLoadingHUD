//
//  UIButton+Space.m
//  Xindai360
//
//  Created by mac on 2018/5/25.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "UIButton+Space.h"

@implementation UIButton (Space)

- (instancetype)imageViewLeftAndTitleLabelRightWithSpace:(CGFloat)space
{
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0 - space / 2.0, 0, 0 + space / 2.0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0 + space / 2.0, 0, 0 - space / 2.0);
    
    return self;
}

- (instancetype)titleLabelLeftAndImageViewRightWithSpace:(CGFloat)space
{
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat labelWidth = CGRectGetWidth(self.titleLabel.frame);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0 - imageViewWidth - space / 2.0, 0, 0 + imageViewWidth + space / 2.0);
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0 + labelWidth + space / 2.0, 0, 0 - labelWidth - space / 2.0);
    
    return self;
}

- (instancetype)imageViewTopAndTitleLabelBottomWithSpace:(CGFloat)space
{
    CGFloat imageViewHeight = CGRectGetHeight(self.imageView.frame);
    CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
    
    CGFloat button_centerX = CGRectGetMidX(self.bounds);// bounds哦
    CGFloat titleLabel_centerX = CGRectGetMidX(self.titleLabel.frame);
    CGFloat imageView_centerX = CGRectGetMidX(self.imageView.frame);
    
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0 + imageViewHeight / 2.0 + space / 2.0, 0 - (titleLabel_centerX - button_centerX), 0 - imageViewHeight / 2.0 - space / 2.0, 0 + (titleLabel_centerX - button_centerX));
    self.imageEdgeInsets = UIEdgeInsetsMake(0 - labelHeight / 2.0 - space / 2.0, 0 + (button_centerX - imageView_centerX), 0 + labelHeight / 2.0 + space / 2.0, 0 - (button_centerX - imageView_centerX));
    
    return self;
}

- (instancetype)titleLabelTopAndImageViewBottomWithSpace:(CGFloat)space
{
    CGFloat imageViewHeight = CGRectGetHeight(self.imageView.frame);
    CGFloat labelHeight = CGRectGetHeight(self.titleLabel.frame);
    
    CGFloat button_centerX = CGRectGetMidX(self.bounds);// bounds哦
    CGFloat titleLabel_centerX = CGRectGetMidX(self.titleLabel.frame);
    CGFloat imageView_centerX = CGRectGetMidX(self.imageView.frame);
    
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0 - imageViewHeight / 2.0 - space / 2.0, 0 - (titleLabel_centerX - button_centerX), 0 + imageViewHeight / 2.0 + space / 2.0, 0 + (titleLabel_centerX - button_centerX));
    self.imageEdgeInsets = UIEdgeInsetsMake(0 + labelHeight / 2.0 + space / 2.0, 0 + (button_centerX - imageView_centerX), 0 - labelHeight / 2.0 - space / 2.0, 0 - (button_centerX - imageView_centerX));
    
    return self;
}

- (instancetype)titleLabelAndImageViewAllInCenter
{
    CGFloat button_centerX = CGRectGetMidX(self.bounds);
    CGFloat titleLabel_centerX = CGRectGetMidX(self.titleLabel.frame);
    CGFloat imageView_centerX = CGRectGetMidX(self.imageView.frame);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(0, 0 + (button_centerX - imageView_centerX), 0, 0 - (button_centerX - imageView_centerX));
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0 - (titleLabel_centerX - button_centerX), 0, 0 + (titleLabel_centerX - button_centerX));
    
    return self;
}

- (instancetype)onlyTitleExist
{
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    return self;
}

#pragma mark  专门为了适配首页的特殊图标
- (instancetype)titleLabelLeftAndImageViewRightAndBottomWithSpace:(CGFloat)space
{
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat labelWidth = CGRectGetWidth(self.titleLabel.frame);
    
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 0 - imageViewWidth - space / 2.0, 0, 0 + imageViewWidth + space / 2.0);
    self.imageEdgeInsets = UIEdgeInsetsMake(kSuitLength(8), 0 + labelWidth + space / 2.0, 0, 0 - labelWidth - space / 2.0);
    
    return self;
}






@end
