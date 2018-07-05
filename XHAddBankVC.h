//
//  XHAddBankVC.h
//  Xindai360
//
//  Created by mc on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "XHBankModel.h"
@interface XHAddBankVC : BaseViewController
@property (nonatomic,assign) BOOL isAdd;// YES:新增 NO:编辑
@property (nonatomic,strong) XHBankModel * bankModel;// 银行卡数据对象
@end
