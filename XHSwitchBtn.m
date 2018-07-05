//
//  XHSwitchBtn.m
//  Xindai360
//
//  Created by mc on 2018/7/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XHSwitchBtn.h"

@implementation XHSwitchBtn

- (instancetype)init {
    if (self = [super init]) {
        [self setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageNamed:@"open"] forState:UIControlStateSelected];
        self.adjustsImageWhenHighlighted = NO; // 长按不变灰
        self.on = NO; // 默认为NO,与UISwitch保持一致
//        [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}
// 按钮点击,触发valueChanged事件
- (void)buttonClicked {
    self.on = !self.on;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
/** 赋值开启or关闭状态 */
- (void)setOn:(BOOL)on {
    _on = on;
    _on ? (self.selected = YES) : (self.selected = NO);
}
/** 设置按钮的点选状态 */
- (void)setOn:(BOOL)on animated:(BOOL)animated {
    self.on = on;
}
@end
