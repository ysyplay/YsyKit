//
//  UIButton+ysy.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/9/19.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "UIButton+ysy.h"

@implementation UIButton (ysy)
-(void)setImageHeight:(float)height width:(float)width
{
    CGRect frame = self.imageView.frame;
    float x = frame.origin.x;
    float y = frame.origin.y;
    self.imageView.frame = CGRectMake(x, y, width, height);
}
-(void)setLeftWordRightImageStyleMakePadding:(float)padding
{
    //宽度不提取出来貌似不行；
    float imageW = self.imageView.bounds.size.width+padding;
    float titleW = self.titleLabel.bounds.size.width+padding;
    self.imageEdgeInsets = UIEdgeInsetsMake(0,titleW, 0, 0-titleW);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -imageW, 0, imageW);
    NSLog(@"%f  %f",imageW,titleW);
}
@end
