//
//  CJAlertSwizzedHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJAlertSwizzedHelper.h"
#import <objc/runtime.h>
//#import <CJBaseHelper/HookCJHelper.h>
#import <CJBaseHelper/UIViewControllerCJHelper.h>

@implementation CJAlertSwizzedHelper

/// MLeaksFinder 使用 UIAlertView 导致崩溃，需要调用此方法来交换
+ (void)swizzledMLLeakAlert {
    Method methodA = class_getClassMethod(NSClassFromString(@"MLeaksMessenger"), @selector(alertWithTitle: message:delegate:additionalButtonTitle:));
    Method methodB = class_getClassMethod([CJAlertSwizzedHelper class], @selector(alertWithTitle: message:delegate:additionalButtonTitle:));
    method_exchangeImplementations(methodA, methodB);

//    HookCJHelper_replaceMethod(NSClassFromString(@"MLeaksMessenger"), @selector(alertWithTitle: message:delegate:additionalButtonTitle:, __unsafe_unretained Class swizzledSelOwnerClass, <#SEL swizzledSelector#>)
}


+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
              delegate:(id<UIAlertViewDelegate>)delegate
 additionalButtonTitle:(NSString *)additionalButtonTitle {
    NSLog(@"dealloc =====================");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    // ok 按钮
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          if (delegate && [delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
              [delegate alertView:nil clickedButtonAtIndex:0];
          }
    }];
    [alertController addAction:okAction];

    // 如果有其他按钮
    if (additionalButtonTitle) {
        UIAlertAction *additionalAction = [UIAlertAction actionWithTitle:additionalButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          if (delegate && [delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
              [delegate alertView:nil clickedButtonAtIndex:1];
          }
        }];
        [alertController addAction:additionalAction];
    }

    [[UIViewControllerCJHelper findCurrentShowingViewController] presentViewController:alertController animated:YES completion:nil];
}



@end
