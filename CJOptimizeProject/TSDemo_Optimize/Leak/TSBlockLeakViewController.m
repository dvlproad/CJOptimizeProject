//
//  TSBlockLeakViewController.m
//  TSDemo_Demo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSBlockLeakViewController.h"

#import "TSOptimizeImageUtil.h"

@interface TSBlockLeakViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonnull, nonatomic, strong) NSMutableArray<NSString *> *imageNameArray;

@end

@implementation TSBlockLeakViewController

- (void)dealloc {
    //NSLog(@"%s", __func__);
    NSLog(@"dealloc -[%@ dealloc], 地址%p", NSStringFromClass([self class]), self);       // 用于检测循环引用
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad -[%@ viewDidLoad], 地址%p", NSStringFromClass([self class]), self);// 用于检测循环引用
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]; // #f5f5f5
    
    self.navigationItem.title = NSLocalizedString(@"模拟内存泄露Leak_Block", nil);
    
    UIButton *button1 = [self themeBGButtonWithTitle:@"会泄露" action:@selector(leakMemoryCircularRreference:)];
    UIButton *button2 = [self themeBGButtonWithTitle:@"不泄露" action:@selector(leakMemoryCircularRreference:)];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
        } else {
            make.top.equalTo(self.mas_topLayoutGuideBottom).offset(10);
        }
        make.height.equalTo(@44);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button1.mas_bottom).offset(10);
        make.height.equalTo(@44);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
    if (self.leakBlock != nil) {    // 在测试泄露的时候 button 不显示
        button1.hidden = YES;
        button2.hidden = YES;
    }
    
    
    [self leakMemory];
    
    //占用内存过高的代码
    for (int i = 0; i < 10000; i++) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = [UIColor redColor];
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button2.mas_bottom).offset(10);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-10);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    self.imageNameArray = [TSOptimizeImageUtil cjts_localImageNames];
}


// 内存泄漏示例
- (void)leakMemory {
    NSObject *leakObject = [[NSObject alloc] init];
    // 没有释放对象，导致内存泄漏
}

#pragma mark - Action
// 内存泄漏示例--循环引用导致的
- (void)leakMemoryCircularRreference:(UIButton *)button {
    //__weak typeof(self) weakSelf = self;
    //__strong __typeof(self) strongSelf = weakSelf;
    
    TSBlockLeakViewController *viewController = [[TSBlockLeakViewController alloc] init];
    if ([button.titleLabel.text containsString:@"会泄露"]) {
        viewController.leakBlock = ^(NSString * _Nonnull title) {
            viewController.title = title; // 会泄露
        };
    } else {
        __weak typeof(viewController) weakViewController = viewController;
        viewController.leakBlock = ^(NSString * _Nonnull title) {
            //self.title = title;   // 不会泄露
            weakViewController.title = title;   // 不会泄露，使得在 Block 中不会出现对 自身 的强引用
                       
           //__strong __typeof(viewController) strongViewController = weakViewController;
           //strongViewController.title = title;   // 不会泄露
        };
    }
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark - themeBGButton
/// 以主题色为背景的按钮
///
- (UIButton *)themeBGButtonWithTitle:(NSString *)title action:(nonnull SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 4;
    
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];

    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}


#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.imageNameArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *indexTitle = [NSString stringWithFormat:@"section:%zd", section];
    return indexTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    NSString *title = [NSString stringWithFormat:@"%zd", indexPath.row];
    cell.textLabel.text = title;
    
    NSString *imageName = [self.imageNameArray objectAtIndex:indexPath.row];
    cell.imageView.image = [TSOptimizeImageUtil cqdemokit_xcassetImageNamed:imageName withCache:YES];
  
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"点击了%zd-%zd", indexPath.section, indexPath.row);
    
    if (self.leakBlock != nil) {
        NSString *title = [NSString stringWithFormat:@"点击了%zd-%zd", indexPath.section, indexPath.row];
        self.leakBlock(title);
    }
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
