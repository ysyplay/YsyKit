//
//  YsyTools.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/4/26.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YsyTools : NSObject
//获得当前页面的视图控制器
+ (UIViewController *)getParentVC;
//将View转为图片
+ (UIImage *)screenshotFromView:(UIView *)aView;
//判断相机权限
+ (BOOL)isCanCamera;
//判断录音权限
+ (BOOL)canRecord;
//判断两个时间相距
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
//设置选项卡栏
+(void)gotoMainVC;
//跳转登陆页面
+ (void)gotoLoginVC;
//设置页面自适应键盘
+(void)loadIQKeyboardManager;
@end
