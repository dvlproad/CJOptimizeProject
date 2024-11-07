//
//  TSLookImageMemoryUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "TSLookImageMemoryUtil.h"

@implementation TSLookImageMemoryUtil

#pragma mark -

+ (void)calculateMemoryForImage:(UIImage *)image {
    //The width, in pixels, of the specified bitmap image (or image mask).
    //指定位图图像(或图像掩码)的宽度(以像素为单位)。
    CGFloat imageWidth = CGImageGetWidth(image.CGImage);
    CGFloat imageHeight = CGImageGetHeight(image.CGImage);
    CGFloat imageMemorySize1 = imageHeight * imageWidth * 4/1024;
    NSLog(@"%.0f*%.0f *4/1024 = %.2fKB", imageWidth, imageHeight, imageMemorySize1);
    //750.000000, 844.000000, 2.414703
    
//    NSData *data = UIImageJPEGRepresentation(image, 1.0);
//    CGFloat imageMemorySize3 = [data length] /1024.0;
//    NSLog(@"%.0f*%.0f *4/1024 = %.2fKB", imageWidth, imageHeight, imageMemorySize3);
    
    //或者
    //The number of bytes used in memory for each row of the specified bitmap image (or image mask).
    //指定位图图像(或图像掩码)的每一行在内存中使用的字节数。
    CGFloat bytesPerRow = CGImageGetBytesPerRow(image.CGImage);
    CGFloat imageMemorySize2 = imageHeight * bytesPerRow/1024;
    NSLog(@"%.0f*%.0f /1024 = %.2fKB", bytesPerRow, imageHeight, imageMemorySize2);
    //3000.000000, 844.000000, 2.414703
}




@end
