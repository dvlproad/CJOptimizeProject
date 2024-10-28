//
//  OptimizeHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "OptimizeHomeViewController.h"
#import "TSOptimizeTableViewController.h"
#import "TSLeakViewController.h"

@interface OptimizeHomeViewController () {
    
}

@end

@implementation OptimizeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Optimize首页", nil);
    

    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // Optimize
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"优化测试";
        {
            CQDMModuleModel *module = [[CQDMModuleModel alloc] init];
            module.title = @"耗时()";
            module.actionBlock = ^{
                [self startLongRunningTask];
            };
            [sectionDataModel.values addObject:module];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // Optimize
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"优化UI";
        {
            CQDMModuleModel *module = [[CQDMModuleModel alloc] init];
            module.title = @"模拟卡顿FPS";
            module.classEntry = [TSOptimizeTableViewController class];
            [sectionDataModel.values addObject:module];
        }
        {
            CQDMModuleModel *module = [[CQDMModuleModel alloc] init];
            module.title = @"模拟内存泄露Leak";
            module.classEntry = [TSLeakViewController class];
//            module.actionBlock = ^{
//                TSLeakViewController *viewController = [[TSLeakViewController alloc] init];
//                viewController.leakBlock = ^(NSString * _Nonnull title) {
//                    NSLog(@"%@", title);
//                };
//                [self.navigationController pushViewController:viewController animated:YES];
//            };
            [sectionDataModel.values addObject:module];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}


#pragma mark - Event
- (void)startLongRunningTask {
    // 创建一个异步队列
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 异步执行耗时操作
    dispatch_async(backgroundQueue, ^{
        // 这里模拟一个耗时操作，比如计算一个大数的阶乘
        NSUInteger bigNumber = 10000;
        NSUInteger result = 1;
        for (NSUInteger i = 1; i <= bigNumber; i++) {
            result *= i;
        }
        
        // 耗时操作完成后，回到主线程更新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"The result of %lu! is %lu", (unsigned long)bigNumber, (unsigned long)result);
            
            // 这里可以更新UI，比如显示结果
        });
    });
}


#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
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
