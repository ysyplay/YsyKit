//
//  UITextView+ysy.h
//  NGanTa
//
//  Created by Runa on 2017/3/2.
//  Copyright © 2017年 HaiYin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (ysy)

@property (nonatomic,assign) NSUInteger MAX_length;
//点击完成 退出键盘
@property (nonatomic,assign) BOOL ClickDoneHidenKeyboard;

/**
 *  强制按字符长度计算限制文本的最大长度 (一个中文算两个字符！)
 */
- (void)setMAX_length:(NSUInteger)MAX_length;

/**
 *  提示用户输入的标语
 */
@property (nonatomic, copy) NSString *placeHolder;

/**
 *  标语文本的颜色
 */
//@property (nonatomic, strong) UIColor *placeHolderTextColor;
@end
