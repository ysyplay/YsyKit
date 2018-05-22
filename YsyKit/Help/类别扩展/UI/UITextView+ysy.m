//
//  UITextView+ysy.m
//  NGanTa
//
//  Created by Runa on 2017/3/2.
//  Copyright © 2017年 HaiYin. All rights reserved.
//

#import "UITextView+ysy.h"
#import "objc/runtime.h"
#import "UIView+ysy.h"
static const char *MAX_length_key = "MAX_length";
static const char *placeHolder_key = "placeHolder";
static const char *keyboardhiden_key = "keyboardhiden_key";
static const char *placeholderColor_key = "placeholderColor_key";
static const char *NormalTextColor_key = "NormalTextColor_key";

@implementation UITextView (ysy)
//设置最大长度
- (void)setMAX_length:(NSUInteger)MAX_length
{
    objc_setAssociatedObject(self, MAX_length_key,@(MAX_length) ,  OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limtLength) name:UITextViewTextDidChangeNotification object:self];
}
-(NSUInteger)MAX_length
{
    return [objc_getAssociatedObject(self, MAX_length_key) integerValue];
}
- (void)limtLength
{
    NSString *nowStr = [self.text substringWithRange:NSMakeRange(self.text.length-1,1)];
    if (self.ClickDoneHidenKeyboard)
    {
        if ([nowStr isEqualToString:@"\n"])
        {
            return;
        }
    }
    UITextRange *selectedRange = [self markedTextRange];
    NSString * newText = [self textInRange:selectedRange];

    NSLog(@"判断限制  %@",newText);
    if (self.text.length-newText.length>self.MAX_length)
    {
        self.text = [self.text substringWithRange:NSMakeRange(0, self.MAX_length)];
        NSLog(@"超过了限制");
    }
 
    if (self.text.length == 1 )
    {
        if ([nowStr isEqualToString:@" "])
        {
            self.text =  [self.text substringWithRange:NSMakeRange(0,self.text.length-1)];
        }
    }
}
//设置placeHolder
- (void)setPlaceHolder:(NSString *)placeHolder
{
    self.text = placeHolder;
    self.textColor = RGBFrom0X(0xaaaaaa);
    objc_setAssociatedObject(self, placeHolder_key,placeHolder , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeplaceHolder) name:UITextViewTextDidBeginEditingNotification object:self];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recoverplaceHolder) name:UITextViewTextDidEndEditingNotification object:self];
}

-(NSString *)placeHolder
{
     return objc_getAssociatedObject(self, placeHolder_key);
}
-(void)removeplaceHolder
{
     NSLog(@"移除placeHolder");
    if ([self.text isEqualToString:self.placeHolder])
    {
        self.text = nil;
        self.textColor = [UIColor darkTextColor];
    }
}
-(void)recoverplaceHolder
{
     NSLog(@"恢复placeHolder");
    if (self.text.length<1)
    {
        self.text = self.placeHolder;
        self.textColor = RGBFrom0X(0xaaaaaa);
    }
}
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, placeholderColor_key,placeholderColor ,  OBJC_ASSOCIATION_ASSIGN);
}
-(UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, placeholderColor_key);
}
- (void)setNormalTextColor:(UIColor *)normalTextColor
{
    objc_setAssociatedObject(self, NormalTextColor_key,normalTextColor,  OBJC_ASSOCIATION_ASSIGN);
}
-(UIColor *)normalTextColor
{
    return objc_getAssociatedObject(self, NormalTextColor_key);
}
- (void)setClickDoneHidenKeyboard:(BOOL)ClickDoneHidenKeyboard
{
    self.returnKeyType = UIReturnKeyDone;
    objc_setAssociatedObject(self, keyboardhiden_key,@(ClickDoneHidenKeyboard) ,  OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keybordHiden) name:UITextViewTextDidChangeNotification object:self];
}
-(BOOL)ClickDoneHidenKeyboard
{
    return [objc_getAssociatedObject(self, keyboardhiden_key) integerValue];
}
-(void)keybordHiden
{
    NSLog(@"键盘消失");
    if (self.text.length>1)
    {
        NSString *str = [self.text substringFromIndex:self.text.length-1];
        if ([str isEqualToString:@"\n"])
        {
             self.text = [self.text substringToIndex:self.text.length-1];
            [self resignFirstResponder];
        }
    }
    else
    {
        if ([self.text isEqualToString:@"\n"])
        {
            self.text = nil;
            [self resignFirstResponder];
        }
    }
}



+(void)load {
    // is this the best solution?
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(swizzledDealloc)));
}
- (void)swizzledDealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidEndEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"TextView干掉了");
    [self swizzledDealloc];
}


@end
