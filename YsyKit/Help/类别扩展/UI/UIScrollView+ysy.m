//
//  UIScrollView+ysy.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/4/20.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "UIScrollView+ysy.h"

@implementation UIScrollView (ysy)
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
@end
