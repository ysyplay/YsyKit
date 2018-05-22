//
//  UIImage+ysy.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/4/26.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ysy)
//图片毛玻璃效果
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
//颜色转换成图片(带圆角的)
+ (UIImage *)imageWithColor:(UIColor *)color redius:(CGFloat)redius size:(CGSize)size;
//将图片截成圆形图片
+ (UIImage *)imagewithImage:(UIImage *)image;
//解决相机使用原始图片后 各种操作会造成图片旋转的问题
-(UIImage *)fixOrientation:(UIImage *)aImage;
- (UIImage *)normalizedImage;
@end
