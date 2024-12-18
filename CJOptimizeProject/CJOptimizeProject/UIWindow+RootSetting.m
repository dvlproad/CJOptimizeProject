//
//  UIWindow+RootSetting.m
//  CQShareDemo
//
//  Created by ciyouzen on 2018/4/12.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "UIWindow+RootSetting.h"
#import <CQDemoKit/CQTSFPSView.h>
#import <TSDemo_Optimize/CJAlertSwizzedHelper.h>
#import <SDWebImage/SDWebImage.h>
#import "TSOptimizeImageUtil.h"

@implementation UIWindow (RootSetting)

- (void)settingRoot {
    //[TSOptimizeImageUtil sleep];    //sleep(2);
    
    [self setBackgroundColor:[UIColor whiteColor]];
    // 只直接测试某个页面
//    UIViewController *rootViewController = [[UINavigationController alloc] initWithRootViewController:[[NSClassFromString(@"BaseUIHomeViewController") alloc] init]];
    UIViewController *rootViewController = [[NSClassFromString(@"OptimizeMainViewController") alloc] init];
    
    self.rootViewController = rootViewController;
    [self makeKeyAndVisible];
    
    [CQTSFPSView showInSuperView:self];
    
    [CJAlertSwizzedHelper swizzledMLLeakAlert]; // MLeaksFinder 使用 UIAlertView 导致崩溃，需要调用此方法来交换
    
    SDImageCacheConfig *imageCacheConfig = [[SDImageCacheConfig alloc] init];
    [SDImageCache sharedImageCache].config.maxDiskSize = 50 * 1024 * 1024;
    [SDImageCache sharedImageCache].config.maxMemoryCost = 50 * 1024 * 1024;
}

@end
