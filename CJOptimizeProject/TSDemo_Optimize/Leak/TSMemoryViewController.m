//
//  TSMemoryViewController.m
//  TSDemo_Demo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "TSMemoryViewController.h"
#import "TSOptimizeImageUtil.h"
#import "TSLookImageMemoryUtil.h"

@interface TSMemoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonnull, nonatomic, strong) NSMutableArray<UIImage *> *imageArray;
@property(nonnull, nonatomic, strong) NSMutableArray<UIView *> *imageViewArray;

@end

@implementation TSMemoryViewController

- (void)dealloc {
    //NSLog(@"%s", __func__);
    NSLog(@"dealloc -[%@ dealloc], 地址%p", NSStringFromClass([self class]), self);       // 用于检测循环引用
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"viewDidLoad -[%@ viewDidLoad], 地址%p", NSStringFromClass([self class]), self);// 用于检测循环引用
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]; // #f5f5f5
    
    self.navigationItem.title = NSLocalizedString(@"计算图片所占内存", nil);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-100);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIImage *image = [TSOptimizeImageUtil cqdemokit_xcassetImageNamed:@"cqts_1.jpg" withCache:YES];
    imageView.image = image;
    [TSLookImageMemoryUtil calculateMemoryForImage:imageView.image];
    
    UILabel *resultLabel = [[UILabel alloc]init];
    resultLabel.backgroundColor = [UIColor redColor];
    resultLabel.numberOfLines = 2;
    [self.view addSubview:resultLabel];
    [resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(10);
        make.height.equalTo(@80);
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.centerX.mas_equalTo(self.view);
    }];
    resultLabel.text = @"文件大小为 28kb 的 cqts_1.jpg 图片在内存中占用的大小为 732.42KB";
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
