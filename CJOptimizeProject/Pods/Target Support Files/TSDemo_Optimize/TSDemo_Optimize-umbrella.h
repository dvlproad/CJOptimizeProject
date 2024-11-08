#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "OptimizeHomeViewController.h"
#import "TSOptimizeTableViewController.h"
#import "CJAlertSwizzedHelper.h"
#import "TSLookImageMemoryUtil.h"
#import "TSOptimizeImageUtil.h"
#import "TSAllocationViewController.h"
#import "TSBlockLeakViewController.h"
#import "TSMemoryViewController.h"
#import "TSTimerLeakViewController.h"
#import "TSZombieViewController.h"
#import "OptimizeMainViewController.h"

FOUNDATION_EXPORT double TSDemo_OptimizeVersionNumber;
FOUNDATION_EXPORT const unsigned char TSDemo_OptimizeVersionString[];

