//
//  TSZombieViewController.m
//  TSDemo_Demo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSZombieViewController.h"

#import "TSOptimizeImageUtil.h"

@interface TSZombieViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonnull, nonatomic, strong) NSMutableArray<UIImage *> *imageArray;
@property(nonnull, nonatomic, strong) NSMutableArray<UIView *> *imageViewArray;

@end

@implementation TSZombieViewController

- (void)dealloc {
    //NSLog(@"%s", __func__);
    NSLog(@"dealloc -[%@ dealloc], 地址%p", NSStringFromClass([self class]), self);       // 用于检测循环引用
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad -[%@ viewDidLoad], 地址%p", NSStringFromClass([self class]), self);// 用于检测循环引用
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]; // #f5f5f5
    
    self.navigationItem.title = NSLocalizedString(@"模拟Zombies", nil);
    
    [self leakMemory];
    
    //占用内存过高的代码
    self.imageArray = [[NSMutableArray alloc] init];
    self.imageViewArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 100; i++) {
        UIImage *image = [TSOptimizeImageUtil cqdemokit_xcassetImageNamed:@"cqts_1.jpg" withCache:YES];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.backgroundColor = [UIColor redColor];
        imageView.image = image;
        [self.imageArray addObject:image];
        [self.imageViewArray addObject:imageView];
    }
}


// 内存泄漏示例
- (void)leakMemory {
    NSObject *leakObject = [[NSObject alloc] init];
    // 没有释放对象，导致内存泄漏
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
