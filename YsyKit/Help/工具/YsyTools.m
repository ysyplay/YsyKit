//
//  YsyTools.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/4/26.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "YsyTools.h"
#import <Photos/Photos.h>
#import "SVProgressHUD.h"
#import "IQKeyboardManager.h"
@implementation YsyTools
+ (UIViewController *)getParentVC
{
    UIViewController* result = nil;
    UIWindow* window = [[UIApplication sharedApplication] keyWindow];
    
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray* windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController* appRootVC = window.rootViewController;
    if (appRootVC.presentedViewController) {
        
        nextResponder = appRootVC.presentedViewController;
        
    }else{
        UIView* frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
   
    }
    if ([nextResponder isKindOfClass:[UIWindow class]])
    {
        UITabBarController* tabbar =  (UITabBarController *)appRootVC;
        UINavigationController* nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result=nav.childViewControllers.lastObject;
    }
    else if ([nextResponder isKindOfClass:[UITabBarController class]]){
        
        UITabBarController* tabbar = (UITabBarController *)nextResponder;
        UINavigationController* nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        result=nav.childViewControllers.lastObject;
        
    } else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
        
    } else {
        
        result = nextResponder;
    }
    return result;
}

+ (UIImage *)screenshotFromView:(UIView *)aView
{
//    @autoreleasepool {
//        UIGraphicsBeginImageContextWithOptions(aView.bounds.size,NO,[UIScreen mainScreen].scale);
//        [aView.layer renderInContext:UIGraphicsGetCurrentContext()];
//        UIImage* screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
//
//        UIGraphicsEndImageContext();
//    }
    return [UIImage imageNamed:@"5"];
}
+ (BOOL)isCanCamera
{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIAlertView alloc] initWithTitle:@"无法拍照" message:[NSString stringWithFormat:@"请在“设置-隐私-相机”选项中允许%@访问您的相机",BUNDLENAME] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        });
        return NO;
    }
    return YES;
}
+ (BOOL)canRecord
{
    __block BOOL bCanRecord = YES;
  
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    if ([audioSession respondsToSelector:@selector(requestRecordPermission:)])
    {
        [audioSession requestRecordPermission:^(BOOL available)
        {
            if (available)
            {
                bCanRecord = YES;
            }
            else
            {
                bCanRecord = NO;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"无法录音" message:[NSString stringWithFormat:@"请在“设置-隐私-麦克风”选项中允许%@访问您的麦克风",BUNDLENAME] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                });
            }
        }];
    }
    return bCanRecord;
}


+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *endD = [date dateFromString:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    
    NSTimeInterval value = end - start;
    
    int second = (int)value %60;//秒
    
    int minute = (int)value /60%60;
    
    int house = (int)value / (24 * 3600)%3600;
    
    int day = (int)value / (24 * 3600);
    
    NSString *str;
    
    if (day != 0) {
        
        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
        
    }else if (day==0 && house != 0) {
        
        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
        
    }else if (day== 0 && house== 0 && minute!=0) {
        
        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
        
    }else{
        
        str = [NSString stringWithFormat:@"耗时%d秒",second];
        
    }
    return str;
}
//设置选项卡栏
+(void)gotoMainVC
{
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSMutableArray *tabs = [[NSMutableArray alloc] initWithCapacity:0];
    
    UINavigationController *NVC1 = [storyBoard instantiateViewControllerWithIdentifier:@"NVC1"];
    [tabs addObject:NVC1];
    
    UINavigationController *NVC2 = [storyBoard instantiateViewControllerWithIdentifier:@"NVC2"];
    [tabs addObject:NVC2];
    
    UINavigationController *NVC3 = [storyBoard instantiateViewControllerWithIdentifier:@"NVC3"];
    [tabs addObject:NVC3];
    
    UINavigationController *NVC4 = [storyBoard instantiateViewControllerWithIdentifier:@"NVC4"];
    [tabs addObject:NVC4];
    
    UITabBarController *tab = [storyBoard instantiateViewControllerWithIdentifier:@"tabbar"];
    tab.viewControllers = tabs;
    if (WINDOW.rootViewController !=tab)
    {
        NSLog(@"界面切换");
        WINDOW.rootViewController = tab;
    }
    SAVE_IMMEDIATELY;
}
//跳转到登录页面
+ (void)gotoLoginVC
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    UIStoryboard * storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    window.rootViewController = [storyBoard instantiateViewControllerWithIdentifier:@"login"];
}
//设置页面自适应键盘
+(void)loadIQKeyboardManager
{
    // 获取类库的单例变量
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    // 控制整个功能是否启用
    keyboardManager.enable = YES;
    // 控制点击背景是否收起键盘
    keyboardManager.shouldResignOnTouchOutside = YES;
    // 控制键盘上的工具条文字颜色是否用户自定义
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES;
    // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews;
    // 控制是否显示键盘上的工具条
    keyboardManager.enableAutoToolbar = NO;
    // 设置占位文字的字体
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17];
    // 输入框距离键盘的距离
    keyboardManager.keyboardDistanceFromTextField = 10.0f;
}
@end
