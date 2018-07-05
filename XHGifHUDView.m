//
//  XHGifHUDView.m
//  ZJProgressHUD
//
//  Created by mc on 2018/7/5.
//  Copyright © 2018年 ZeroJ. All rights reserved.
//

#import "XHGifHUDView.h"
#define  GIF_WIDTH   kSuitLength(60)
#import "ZJPrivateHUDProtocol.h"
/* 获取屏幕 宽度、高度 */


@interface XHGifHUDView()<ZJPrivateHUDProtocol>
@property (strong, nonatomic) UILabel *label;

@property (nonatomic, strong)NSMutableArray<UIImage *> *images;
//@property (nonatomic, strong)XHLoadingView *loading;
@property (nonatomic, strong)UIView *gifContentView;

@property (nonatomic, assign)CGImageSourceRef gif;
@property (nonatomic, strong)NSDictionary *gifDic;
@property (nonatomic, assign)size_t index;
@property (nonatomic, assign)size_t count;
@property (nonatomic, strong)NSTimer *timer;


@end
@implementation XHGifHUDView

/*
 - (instancetype)init{
 self = [super init];
 if (self) {
 
 //      self.backgroundColor = XD_WHITE_COLOR;
 //      self.backgroundColor = [UIColor cyanColor];
 //        self.layer.cornerRadius = 5.0f;
 //        self.layer.masksToBounds = YES;
 //        self.userInteractionEnabled = NO;
 //        self.timeDelay = 5.0;
 //        self.animationSpeed = 0.05;
 //        //        self.showView = [UIApplication sharedApplication].keyWindow;
 //        //        self.gifName = @"run";// 默认动画名称为run
 //        self.gifName = @"loading";// 默认动画名称为run
 //        [self commonInit];
 //
 }
 return self;
 }
 
 */

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGRect frame = self.frame; // 开始设置frame
        frame.size = CGSizeMake(GIF_WIDTH, GIF_WIDTH);
        frame.origin.x = (SCREEN_WIDTH - frame.size.width)/2;
        frame.origin.y = (SCREEN_HEIGHT - frame.size.height)/2;
        self.frame = frame;
        self.layer.cornerRadius = 5.0f;
        self.layer.masksToBounds = YES;
        self.userInteractionEnabled = NO;
        self.timeDelay = 5.0;
        self.animationSpeed = 0.05;
        //        self.showView = [UIApplication sharedApplication].keyWindow;
        //        self.gifName = @"run";// 默认动画名称为run
//        self.gifName = @"loading";// 默认动画名称为run
//        [self createGif];
        
    }
    return self;
}

#pragma mark - 创建gif动画
- (void)createGif{
    
    NSDictionary *gifLoopCount = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:0] forKey:(NSString *)kCGImagePropertyGIFLoopCount];
    _gifDic = [NSDictionary dictionaryWithObject:gifLoopCount forKey:(NSString *)kCGImagePropertyGIFDictionary];
    
    NSData *gif = [NSData dataWithContentsOfFile: [[NSBundle mainBundle] pathForResource:self.gifName ofType:@"gif"]];
    _gif = CGImageSourceCreateWithData((CFDataRef)gif, (CFDictionaryRef)_gifDic);
    _count = CGImageSourceGetCount(_gif);
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.animationSpeed target:self selector:@selector(startLoading) userInfo:nil repeats:YES];
    [_timer fire];
}
// 结束动画
- (void)endLoading{
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[XHGifHUDView class]]) {
            [UIView animateWithDuration:1.0 animations:^{
                view.alpha = 0;
            } completion:^(BOOL finished) {
                [((XHGifHUDView *)view) stopGif];
                [view removeFromSuperview];
            }];
        }
    }
    
}
-(void)startLoading
{
    _index ++;
    _index = _index%_count;
    CGImageRef ref = CGImageSourceCreateImageAtIndex(_gif, _index, (CFDictionaryRef)_gifDic);
    self.layer.contents = (__bridge id)ref;
    CFRelease(ref);
}
- (void)stopGif
{
    [_timer invalidate];
    _timer = nil;
}
- (void)dealloc{
    CFRelease(_gif);
}
- (void)setGifName:(NSString *)gifName
{
    if (gifName == nil || [gifName isEqualToString:@""]) {
        _gifName = @"loading";
    }
    _gifName = gifName;
    
    [self createGif];
}
- (void)setLoadingColor:(UIColor *)loadingColor
{
    _loadingColor = loadingColor;
}
static void dispatch_main_after(NSTimeInterval delay, void (^block)(void))
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        block();
    });
}

@end
