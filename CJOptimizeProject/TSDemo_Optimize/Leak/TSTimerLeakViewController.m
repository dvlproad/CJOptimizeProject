//
//  TSTimerLeakViewController.m
//  TSDemo_Demo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSTimerLeakViewController.h"

#import "TSOptimizeImageUtil.h"

@interface TSTimerLeakViewController ()

@property (nonatomic, weak) NSTimer *timer;

@property (nonatomic, assign) BOOL simulateLeak;

@end

@implementation TSTimerLeakViewController

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    if (self.simulateLeak == NO) {
        [_timer invalidate];
//        _timer = nil; // 可写可不写
    }
}


- (void)dealloc {
    //NSLog(@"%s", __func__);
    NSLog(@"dealloc -[%@ dealloc], 地址%p", NSStringFromClass([self class]), self);       // 用于检测循环引用
    
    if (self.simulateLeak == YES) {
        [_timer invalidate];
        _timer = nil;
    }
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad -[%@ viewDidLoad], 地址%p", NSStringFromClass([self class]), self);// 用于检测循环引用
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]; // #f5f5f5
    
    self.navigationItem.title = NSLocalizedString(@"模拟内存泄露Leak_Timer", nil);
    UIButton *button1 = [self themeBGButtonWithNormalTitle:@"不泄露" selectedTitle:@"会泄露" action:@selector(leakMemoryCircularRreference:)];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
        make.height.equalTo(@44);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
    }];

    self.simulateLeak = YES;
    [button1 setSelected:self.simulateLeak];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
}

- (void)timerFired:(NSTimer *)timer {
  // Do something...
}

#pragma mark - Action
// 内存泄漏示例--循环引用导致的
- (void)leakMemoryCircularRreference:(UIButton *)button {
    //__weak typeof(self) weakSelf = self;
    //__strong __typeof(self) strongSelf = weakSelf;
    self.simulateLeak = !self.simulateLeak;
    button.selected = self.simulateLeak;
}


#pragma mark - themeBGButton
/// 以主题色为背景的按钮
///
- (UIButton *)themeBGButtonWithNormalTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle action:(nonnull SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];

    [button setTitle:normalTitle forState:UIControlStateNormal];
    [button setTitle:selectedTitle forState:UIControlStateSelected];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
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
