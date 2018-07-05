//
//  XHSwitchBtn.h
//  Xindai360
//
//  Created by mc on 2018/7/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XHSwitchBtn : UIButton
/** 是否是开启状态 */
@property(nonatomic, assign, getter=isOn) BOOL on;
/** 设置按钮的点选状态 */
- (void)setOn:(BOOL)on animated:(BOOL)animated;
@end
