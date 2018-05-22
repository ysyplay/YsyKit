//
//  NSString+ysy.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/16.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (ysy)

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param width 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际高度
 */
- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param height 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font;
//时间(字符串)转时间戳
-(NSString *)timeStamp;
//时间戳转时间
-(NSString *)timeString;
//验证是否在规定范围内
- (BOOL)isBelongString:(NSString *)str;
//验证是否是数字
-(BOOL)isNum;
//验证是否是今天
- (BOOL)isToday;
//判断是否全是空格
- (BOOL) isEmpty;
@end
