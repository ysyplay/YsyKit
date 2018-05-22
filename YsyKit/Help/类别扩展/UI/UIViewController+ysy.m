//
//  UIViewController+ysy.m
//  ServerDriver
//
//  Created by HG on 2018/5/17.
//  Copyright © 2018年 多乐朗. All rights reserved.
//

#import "UIViewController+ysy.h"
#import "objc/runtime.h"
@implementation UIViewController (ysy)
+(void)load {
    // is this the best solution?
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"viewDidLoad")),
                                   class_getInstanceMethod(self.class, @selector(swizzledViewDidLoad)));
}
- (void)swizzledViewDidLoad
{
    NSLog(@"*******************************************************\n*\t\t\t\t\t\t\t\t *\n*   当前打开的Controller是: %@\t *    \n*\t\t\t\t\t\t\t\t *\n*******************************************************", NSStringFromClass([self class]));
    [self swizzledViewDidLoad];
}
@end
