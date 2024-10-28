//
//  TSLeakViewController.h
//  TSDemo_Demo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  测试 模拟内存泄露Leak

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSLeakViewController : UIViewController

@property (nullable, nonatomic, copy) void(^leakBlock)(NSString *title); /**< 点击后执行的方法 */

@end

NS_ASSUME_NONNULL_END
