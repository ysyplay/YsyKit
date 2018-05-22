//
//  UITextField+ysy.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/4/20.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (ysy)<UITextFieldDelegate>
//输入框随键盘移动
@property (nonatomic,assign) BOOL MoveByKeyboard;
@property (nonatomic,assign) NSUInteger MAX_length;
@property (nonatomic,assign) NSInteger numFloat;
@property (nonatomic,assign) NSInteger numInt;
@property (nonatomic,assign) BOOL limtNum;
@property (nonatomic,strong) UIColor *placeholderColor;
//点击完成 退出键盘
@property (nonatomic,assign) BOOL ClickDoneHidenKeyboard;
//添加收起键盘按钮
-(void)addToolSender;
-(void)addToolSenderWithBlock:(void(^)(void))block;
//设置左边距
-(void)setTextFieldLeftPadding:(CGFloat)leftWidth;
@end
