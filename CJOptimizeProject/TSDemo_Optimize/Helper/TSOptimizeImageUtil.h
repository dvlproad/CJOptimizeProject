//
//  TSOptimizeImageUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSOptimizeImageUtil : NSObject

#pragma mark - 卡顿 1、耗时的计算
+ (void)performExpensiveOperation;


#pragma mark - 卡顿 2、图片没缓存
/// 所有的本地测试图片的名称
+ (NSArray<NSString *> *)cjts_localImageNames;

+ (nullable UIImage *)cqdemokit_xcassetImageNamed:(NSString *)name withCache:(BOOL)shouldCache;

@end

NS_ASSUME_NONNULL_END
