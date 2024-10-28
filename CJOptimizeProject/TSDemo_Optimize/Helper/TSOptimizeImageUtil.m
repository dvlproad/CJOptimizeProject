//
//  TSOptimizeImageUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "TSOptimizeImageUtil.h"

@implementation TSOptimizeImageUtil


#pragma mark - 卡顿 1、耗时的计算
// 模拟耗时操作，可能会导致主线程卡顿
+ (void)performExpensiveOperation {
    NSLog(@"Start performing expensive operation");
    // 执行一个耗时的计算
    NSUInteger result = 0;
    for (int i = 0; i < 1000000; i++) {
        result += i;
    }
    NSLog(@"Expensive operation completed with result: %lu", (unsigned long)result);
}


#pragma mark - 卡顿 2、图片没缓存
/// 所有的本地测试图片的名称
+ (NSArray<NSString *> *)cjts_localImageNames {
    NSArray<NSString *> *imagesNames = @[@"cqts_1.jpg",
                                         @"cqts_2.jpg",
                                         @"cqts_3.jpg",
                                         @"cqts_4.jpg",
                                         @"cqts_5.jpg",
                                         @"cqts_6.jpg",
                                         @"cqts_7.jpg",
                                         @"cqts_8.jpg",
                                         @"cqts_9.jpg",
                                         @"cqts_10.jpg",
                                         @"cqts_long_horizontal_1.jpg",
                                         @"cqts_long_vertical_1.jpg",
    ];
    
    return imagesNames;
}

+ (nullable UIImage *)cqdemokit_xcassetImageNamed:(NSString *)name withCache:(BOOL)shouldCache {
    if(name == nil || [name isEqualToString:@""]) {
        return nil;
    }
    
    // bundle 获取
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"CQTSLocImagesUtil")];
    NSURL *url = [bundle URLForResource:@"CQDemoKit" withExtension:@"bundle"];
    if (url == nil) {
        return nil;
    }
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    // image
    UIImage *image;
    if (!shouldCache) {
        NSString *fileExtension = [name pathExtension];
        NSString *fileNameWithoutExtension = [[name lastPathComponent] stringByDeletingPathExtension];
        NSString *imagePath = [imageBundle pathForResource:fileNameWithoutExtension ofType:fileExtension];
        image = [UIImage imageWithContentsOfFile:imagePath];
    } else {
        image = [UIImage imageNamed:name inBundle:imageBundle compatibleWithTraitCollection:nil];
    }
    return image;
}



@end
