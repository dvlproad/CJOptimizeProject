//
//  CJAlertSwizzedHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJAlertSwizzedHelper : NSObject

/// MLeaksFinder 使用 UIAlertView 导致崩溃，需要调用此方法来交换
+ (void)swizzledMLLeakAlert;

@end

NS_ASSUME_NONNULL_END
