//
//  UILabel+ysy.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/29.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ysy)
/** 设置label的行高*/
- (void)settingLabelRowOfHeight:(CGFloat)height string:(NSString*)string;
//设置显示的最大长度
-(void)setMaxLenght:(NSInteger)length;
//设置不同颜色
-(void)setText:(NSString *)text color:(UIColor *)color range:(NSRange)range;
@end
