//
//  XHAddBankVC.m
//  Xindai360
//
//  Created by mc on 2018/6/21.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "XHAddBankVC.h"
#import "XHFindBankModel.h" // 获取银行卡信息
@interface XHAddBankVC ()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel * chargeLab;// 充值金额的参数
@property (nonatomic,strong) UIButton * ensureBtn; // 确定充值按钮

@property (nonatomic,strong) UIImageView * bankImg; // 银行图片
@property (nonatomic,strong) UILabel * bankName; // 银行名称

@property (nonatomic,strong) UITextField * accountUser;// 持卡人
@property (nonatomic,strong) UITextField * carNO;// 卡号

@property (nonatomic,strong) UIView * thirdView ;// 包含银行名称的文字标签

//XHFindBankModel
@property (nonatomic,strong) XHFindBankModel * bankInfoModel ;// 银行卡具体信息

@property (nonatomic,strong) NSString * realCarNO;// 真实的银行卡号,去除空格
@property (nonatomic, strong) UIView                 *authBgView;


@end

@implementation XHAddBankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isAdd) {
       self.navigationItem.title = @"新增银行卡";
    }
    else
    {
        self.navigationItem.title = @"编辑银行卡";
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    //注册键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector (keyboardHide:) name: UIKeyboardWillHideNotification object:nil];
    [self buildBaseView];
}
// 页面布局
-(void)buildBaseView
{
    // 第一个View
    UIView * firstView = [[UIView alloc]init];
    firstView.backgroundColor = [UIColor colorWithHexString:@"#f7f7f7"];
    [self.view addSubview:firstView];
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view); //
        make.height.equalTo([NSNumber numberWithFloat:kSuitLength(40)]);
    }];
    // 1.请绑定持卡人本人的银行卡
    UILabel * label = [[UILabel alloc]init];
    label.text = @"请绑定持卡人本人的银行卡";
    label.textColor = [UIColor colorWithHexString:@"#979797"];
    label.font = SYSTEMFONT(12);
    [firstView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView).offset(12);
        make.left.right.equalTo(firstView).offset(20);
        make.height.equalTo([NSNumber numberWithFloat:kSuitLength(17)]);
    }];
    
// =====================================================
    
    // 第二个View
    UIView * secondView = [[UIView alloc]init];
    [self.view addSubview:secondView];
    [secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(firstView.mas_bottom).offset(0); //
        make.left.right.equalTo(self.view); //
        make.height.equalTo([NSNumber numberWithFloat:kSuitLength(100)]);
    }];
    
 
    // 分割线1
    UIView * lineView = [UIView new];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    [secondView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(@1);
    }];
    
    
    
    UILabel * userLabel = [[UILabel alloc]init];
    userLabel.text = @"持卡人";
    userLabel.textColor = [UIColor colorWithHexString:@"#1F1F1F"];
    userLabel.font = SYSTEMFONT(16);
    [userLabel sizeToFit];
    [secondView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(secondView);
        make.left.equalTo(@20);
        make.bottom.equalTo(lineView).offset(-1);
        make.width.equalTo(@kSuitLength(59));
    }];
    

    
    UIButton * tipBtn = [[UIButton alloc] init];
    [tipBtn setImage:[UIImage imageNamed:@"addcard_notice"] forState:UIControlStateNormal];
    tipBtn.tag = 100;
    [tipBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    [secondView addSubview: tipBtn];
    [tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userLabel);//40
//        make.left.equalTo(@18);//40
        make.right.equalTo(@-20);
        make.width.height.equalTo(@kSuitLength(20));
    }];

    
    #pragma mark - 持卡人文本框

    self.accountUser = [[UITextField alloc]init];
    self.accountUser.font =  SYSTEMFONT(16);
    self.accountUser.borderStyle=UITextBorderStyleNone;
//    self.accountUser.placeholder=@"输入持卡人";
    self.accountUser.userInteractionEnabled = NO;
    self.accountUser.text = [MData sharedInstance].curUserInfo.realName;
    
    self.accountUser.clearButtonMode = UITextFieldViewModeWhileEditing;
    //pwd.text=@"123456";
    //密文样式
    
    [secondView addSubview:self.accountUser];
    [_accountUser mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(userLabel);//40
        //        make.left.equalTo(@18);//40
        make.left.mas_equalTo(userLabel.mas_right).offset(10);
        make.right.mas_equalTo(tipBtn.mas_left).offset(-10);
        make.height.equalTo(@kSuitLength(40));
    }];
    

    
    // 分割线2
    UIView * seclineView = [UIView new];
    seclineView.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    [secondView addSubview:seclineView];
    [seclineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView.mas_bottom).offset(50);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(@1);
    }];
    
    
    UILabel * carNoLabel = [[UILabel alloc]init];
    carNoLabel.text = @"卡号";
    carNoLabel.textColor = [UIColor colorWithHexString:@"#1F1F1F"];
    carNoLabel.font = SYSTEMFONT(16);
    [secondView addSubview:carNoLabel];
    [carNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView);
        make.left.equalTo(@20);
        make.bottom.mas_equalTo(seclineView.mas_top).offset(-1);
        make.width.equalTo(@kSuitLength(59));
    }];
    
    
    #pragma mark - 卡号文本框
    
    _carNO = [[TKPhoneTextField alloc]initWithFrame:CGRectMake(60, 10, 271, 30)];
    _carNO.font = SYSTEMFONT(16) ;
    _carNO.placeholder = @"输入银行卡号";
//    _carNO.textColor=[UIColor blackColor];
    _carNO.borderStyle=UITextBorderStyleNone;
    _carNO.backgroundColor =[UIColor clearColor];
    _carNO.delegate = self;
    _carNO.keyboardType=UIKeyboardTypeNumberPad;
    _carNO.clearButtonMode = UITextFieldViewModeWhileEditing;
    [secondView addSubview:_carNO];
    [_carNO mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(carNoLabel);//40
        //        make.left.equalTo(@18);//40
        make.left.mas_equalTo(carNoLabel.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.height.equalTo(@kSuitLength(40));
    }];
//    secondView.backgroundColor = [UIColor orangeColor];
    
    
// =====================================================
    // 第三个View
    UIView * thirdView = [[UIView alloc]init];
//    thirdView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:thirdView];
    [thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(seclineView.mas_bottom).offset(0);
        make.left.right.equalTo(secondView); //
        make.height.equalTo(@kSuitLength(80));
    }];
    
    //1.银行图标
    self.bankImg = [[UIImageView alloc]init];
    self.bankImg.image = [UIImage imageNamed:@"addcard_notice"];
    [thirdView addSubview:self.bankImg];
    [self.bankImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@kSuitLength(9));
        make.left.equalTo(@kSuitLength(20));
        make.height.width.mas_equalTo(@kSuitLength(22));
    }];
    
    
    //2. 银行名称
    self.bankName = [[UILabel alloc]init];
    _bankName.font = BOLDSYSTEMFONT(20);
    
    _bankName.textColor = [UIColor colorWithHexString:@"#979797"];
    _bankName.font = SYSTEMFONT(14);
    //        [_bankName sizeToFit];
    [thirdView addSubview:_bankName];
    [_bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankImg.mas_right).offset(6);
        make.right.equalTo(@-100);
        make.centerY.equalTo(self.bankImg);
        make.height.equalTo(@30);
        //            make.width.equalTo(SCREEN_WIDTH-100);
    }];
    
    self.thirdView = thirdView;
    #pragma mark - 银行信息是否展示
    if (self.bankModel) {
         self.thirdView.hidden = NO;
        _bankName.text = self.bankModel.name;
        [self.bankImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicConfiguration sharedPublicConfiguration].domainName,_bankModel.icon]] placeholderImage:[UIImage imageNamed:@"nocardinfo_placeholder_b"]];
        
        
        NSMutableArray *numberArr = [NSMutableArray array];
        int length = self.bankModel.bankNumber.length % 4 == 0 ? (int)(self.bankModel.bankNumber.length / 4) : (int)(self.bankModel.bankNumber.length / 4 + 1);
        for (int i = 0; i < length; i++) {
            int begin = i * 4;
            int end = (i * 4 + 4) > (int) self.bankModel.bankNumber.length ? (int)(self.bankModel.bankNumber.length) : (i * 4 + 4);
            NSString *subString = [self.bankModel.bankNumber substringWithRange:NSMakeRange(begin, end - begin)];
            [numberArr addObject:subString];
        }
        NSString *cardnbr = @"";
        for (int i = 0; i < length; i++) {
            
            cardnbr = [cardnbr stringByAppendingFormat:@"%@", [NSString stringWithFormat:@"%@ ",numberArr[i]]];
        }
        _carNO.text = [cardnbr substringToIndex:cardnbr.length-1]; // 删除最后一个空格字符串
        
    }
    else
    {
        self.thirdView.hidden = YES;

    }
   
    _ensureBtn = [[UIButton alloc] init];
    
    [_ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //    [_ensureBtn setBackgroundColor:XD_LINE_COLOR];
    if (self.bankModel) {
  
        [_ensureBtn setTitle:@"保存" forState:UIControlStateNormal];
        _ensureBtn.enabled = YES;
        [_ensureBtn setBackgroundColor:XD_BLUE_COLOR];
    }
    else
    {
        [_ensureBtn setTitle:@"同意并绑卡" forState:UIControlStateNormal];
        _ensureBtn.enabled = NO;
        _ensureBtn.backgroundColor = CREATE_RGBA_COLOR(215, 215, 215, 1);

    }

    _ensureBtn.titleLabel.font = SYSTEMFONT(kSuitLength(20));
    _ensureBtn.layer.cornerRadius = kSuitLength(4);
    _ensureBtn.layer.masksToBounds = YES;
    _ensureBtn.tag = 200;
    [self.view addSubview: _ensureBtn];
    [_ensureBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_ensureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdView.mas_bottom).offset(0);//40
        make.left.equalTo(@18);//40
        make.right.equalTo(@-18);
        make.height.equalTo(@kSuitLength(44));
    }];
}
-(void)buttonClick:(UIButton*)btn
{
    
    if (btn.tag == 100) {
//        [Common showTextHud:self.view title:@"请绑定持卡人本人的银行卡"];
        [self createAuthenticationView:@"请绑定持卡人本人的银行卡"];
       
    }
    else
    {
        [self addBankCard];
    }

}
- (void)createAuthenticationView:(NSString*)msg
{
    _authBgView = [UIView new];
    _authBgView.backgroundColor = CREATE_RGBA_COLOR(0, 0, 0, 0.6);
    [[UIApplication sharedApplication].keyWindow addSubview:_authBgView];
    [_authBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake( 0, 0, 0, 0));
    }];
    
    UIView *whiteView = [UIView new];
    whiteView.layer.cornerRadius = kSuitLength(5);
    whiteView.layer.masksToBounds = YES;
    whiteView.backgroundColor = [UIColor whiteColor];
    [_authBgView addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_authBgView);
        make.size.mas_offset(CGSizeMake(kSuitLength(300), kSuitLength(190)));
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"温馨提示";
    titleLabel.font = SYSTEMFONT(kSuitLength(18));
    titleLabel.textColor = CREATE_RGB_COLOR(31, 31, 31);
    [whiteView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kSuitLength(35));
        make.left.right.equalTo(whiteView);
        make.height.mas_offset(kSuitLength(25));
    }];
    
    
    UILabel *tiLabel = [UILabel new];
    tiLabel.textAlignment = NSTextAlignmentCenter;
    tiLabel.text = msg;
    tiLabel.font = SYSTEMFONT(kSuitLength(14));
    tiLabel.textColor = CREATE_RGB_COLOR(151, 151, 151);
    [whiteView addSubview:tiLabel];
    [tiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(kSuitLength(8));
        make.left.right.equalTo(whiteView);
        make.height.mas_offset(kSuitLength(20));
    }];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"确定" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = CREATE_RGB_COLOR(0, 152, 255);
    cancelBtn.titleLabel.font = SYSTEMFONT(kSuitLength(16));
    cancelBtn.tag = 2;
    cancelBtn.layer.cornerRadius = kSuitLength(5);
    cancelBtn.layer.masksToBounds = YES;
    [whiteView addSubview: cancelBtn];
    [cancelBtn addTarget:self action:@selector(buttonClick1:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(whiteView);
        make.bottom.mas_offset(kSuitLength(-30));
        make.size.mas_offset(CGSizeMake(kSuitLength(150), kSuitLength(35)));
    }];
}

-(void)buttonClick1:(UIButton*)btn
{
    [_authBgView removeFromSuperview];
}
#pragma mark - 检验银行卡
-(BOOL)IsBankCard:(NSString *)cardNumber
{
    if(cardNumber.length==0)
    {
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++)
    {
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c))
        {
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--)
    {
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo)
        {
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    
    return modulus == 0;
}
#pragma mark - 修改/绑定银行卡
-(void)addBankCard
{

    if (self.bankInfoModel.name) {
        NSDictionary * dic = @{@"name":self.bankInfoModel.name,
                               @"bankType":self.bankInfoModel.bankType,
                               @"bankCode":self.bankInfoModel.bankCode,
                               @"bankNumber":self.realCarNO,
                               @"icon":self.bankInfoModel.icon,
                               };
        [NetAPIManager request_bindBankWithParameter:dic Success:^(NSString *msg, id data) {
            NSLog(@"- 返回信息 -%@",msg);
            if ([data[@"success"]integerValue] == 1 ) {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSString *error, id data) {
            
        }];
    }
   
}
#pragma mark - 获取银行卡信息
-(void)getBankCardInfo
{
    
    [NetAPIManager request_getfindBankInfo:self.realCarNO success:^(NSString *msg, id data) {
        
        self.bankInfoModel = [XHFindBankModel mj_objectWithKeyValues:data[@"data"]];
        if (self.bankInfoModel) {
            // 1.显示银行卡信息
            [self.bankImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[PublicConfiguration sharedPublicConfiguration].domainName,self.bankInfoModel.icon]] placeholderImage:[UIImage imageNamed:@"nocardinfo_placeholder_b"]];
            self.bankName.text = self.bankInfoModel.name;
            [self.thirdView setHidden:NO];
            
            // 2.按钮可以提交
            self.ensureBtn.enabled = YES;
            [self.ensureBtn setBackgroundColor:XD_BLUE_COLOR];
            
            
        }
        
    } failure:^(NSString *error, id data) {
        NSLog(@"银行卡错误 -%@",data);
        [Common showTextHud:self.view title:@"查询异常,稍后重试"];
    }];
}

//限制最大输入字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField == _carNO) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 23) {
            
            return NO;
        }
        // 文本框清空式
        if (textField.text.length == 0) {
            
        }
    }
    if([string hasSuffix:@" "])     // 忽视空格
        return NO;
    else
        return YES;
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    self.carNO.text = nil; // 清空输入框的数据
    [self keyboardHide:nil];
    return YES;
}
#pragma mark - 键盘关闭函数
-(void)keyboardHide:(NSNotification *)notif
{
//    NSDictionary *info = [notif userInfo];
    //1.检验银行卡是否正确 提示
    self.realCarNO = [self.carNO.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([self IsBankCard:self.realCarNO]) {
        [self getBankCardInfo];
    }
    else
    {
        [Common showTextHud:self.view title:@"银行卡输入有误"];
        // 2.按钮不可以提交
        self.ensureBtn.enabled = NO;
        [self.ensureBtn setBackgroundColor:CREATE_RGBA_COLOR(215, 215, 215, 1)];
        [self.thirdView setHidden:YES];
    }
    //2.银行卡正确去调用显示信息
//    _keyboardSize = keyboardSize.height;
}

-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    [_accountUser resignFirstResponder];
    [_carNO resignFirstResponder];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_accountUser resignFirstResponder];
    [_carNO resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
