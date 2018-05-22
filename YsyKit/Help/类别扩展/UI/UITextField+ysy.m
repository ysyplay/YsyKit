//
//  UITextField+ysy.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/4/20.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "UITextField+ysy.h"
#import "objc/runtime.h"
#import "UIView+ysy.h"
#import "NSString+ysy.h"
static const char kBlockActionKey;
static const char *MAX_length_key = "MAX_length";
static const char *numFloat_key = "numFloat";
static const char *numInt_key = "numInt";
static const char *moveByKeyboard_key = "moveByKeyboard_key";
static const char *Observer1_key = "Observer1_key";
static const char *Observer2_key = "Observer1_key";
static const char *limtNum_key = "limtNum";
static const char *placeholderColor_key = "placeholderColor_key";
static const char *keyboardhiden_key = "keyboardhiden_key";
@implementation UITextField (ysy)
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    objc_setAssociatedObject(self, placeholderColor_key,placeholderColor ,  OBJC_ASSOCIATION_ASSIGN);
    [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
  
}
-(UIColor *)placeholderColor
{
    return objc_getAssociatedObject(self, placeholderColor_key);
}
//限制合法数字
- (void)setLimtNum:(BOOL)limtNum
{
    objc_setAssociatedObject(self, limtNum_key,@(limtNum),OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limtNumRule) name:UITextFieldTextDidChangeNotification object:self];
}
-(BOOL)limtNum
{
    return [objc_getAssociatedObject(self, limtNum_key) integerValue];
}
- (void)limtNumRule
{
    NSString *nowStr = @"";
    if (self.text.length>0)
    {
        nowStr  = [self.text substringWithRange:NSMakeRange(self.text.length-1,1)];
    }
    if (self.text.length == 1 )
    {
        if ([nowStr isEqualToString:@" "])
        {
            [self ignoreThisInput];
        }
    }
    if (self.limtNum)
    {
        if ([nowStr isBelongString:@"-.0123456789"])
        {
            if ([nowStr isEqualToString:@"."])
            {
                if (self.text.length == 1)
                {
                    self.text = @"0.";
                }
                else
                {
                    if ([self.text componentsSeparatedByString:@"."].count>2)
                    {
                        [self ignoreThisInput];
                    }
                }
            }
            //如果长度为2 且首字符为0，且此次输入不是.，忽视此次输入
            if (self.text.length == 2)
            {
                NSString *Str = [self.text substringWithRange:NSMakeRange(0,1)];
                if ([Str isEqualToString:@"0"])
                {
                    if (![nowStr isEqualToString:@"."])
                    {
                        self.text = nowStr;
                    }
                }
            }
            if ([self.text componentsSeparatedByString:@"-"].count>2)
            {
                [self ignoreThisInput];
            }
//            NSString *FirstStr = [self.text substringWithRange:NSMakeRange(0,1)];
//            if ([FirstStr isEqualToString:@"-"])
//            {
//                <#statements#>
//            }
        }
        else
        {
            [self ignoreThisInput];
        }
    }
}
//设置最大长度
- (void)setMAX_length:(NSUInteger)MAX_length
{
    objc_setAssociatedObject(self, MAX_length_key,@(MAX_length) ,  OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limtLength) name:UITextFieldTextDidChangeNotification object:self];
}
-(NSUInteger)MAX_length
{
    return [objc_getAssociatedObject(self, MAX_length_key) integerValue];
}
- (void)limtLength
{
    UITextRange *selectedRange = [self markedTextRange];
    NSString * newText = [self textInRange:selectedRange];
    NSLog(@"判断限制  %@",newText);
    if (self.text.length-newText.length>self.MAX_length)
    {
        self.text = [self.text substringWithRange:NSMakeRange(0, self.MAX_length)];
        NSLog(@"超过了限制");
    }
    NSString *nowStr = @"";
    if (self.text.length>0)
    {
        nowStr  = [self.text substringWithRange:NSMakeRange(self.text.length-1,1)];
    }
    if (self.text.length == 1 )
    {
        if ([nowStr isEqualToString:@" "])
        {
            [self ignoreThisInput];
        }
    }
}
//设置小数位数
- (void)setNumFloat:(NSInteger)numFloat
{
    objc_setAssociatedObject(self, numFloat_key,@(numFloat),OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limtFloat) name:UITextFieldTextDidChangeNotification object:self];
}
-(NSInteger)numFloat
{
    return [objc_getAssociatedObject(self, numFloat_key) integerValue];
}
-(void)limtFloat
{
    NSArray *strarray = [self.text componentsSeparatedByString:@"."];
    if (strarray.count>1)
    {
        NSString *FloatStr = strarray[1];
        //截取小数
        if (FloatStr.length>self.numFloat)
        {
            [self ignoreThisInput];
        }
    }
}
//设置整数位数
- (void)setNumInt:(NSInteger)numInt
{
    objc_setAssociatedObject(self, numInt_key,@(numInt) ,  OBJC_ASSOCIATION_ASSIGN);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(limtInt) name:UITextFieldTextDidChangeNotification object:self];
}
-(NSInteger)numInt
{
    return [objc_getAssociatedObject(self, numInt_key) integerValue];
}
-(void)limtInt
{
    NSArray *strarray = [self.text componentsSeparatedByString:@"."];
    NSString *IntStr = strarray[0];
    NSLog(@"整数 %@",IntStr);
    if (self.text.length>0)
    {
        NSString  *FirstStr  = [self.text substringWithRange:NSMakeRange(0,1)];
        NSInteger max = self.numInt;
        if ([FirstStr isEqualToString:@"-"])
        {
            max = max+1;
        }
        if (IntStr.length>max)
        {
            //截取整数
            NSMutableString *str1 = [self.text mutableCopy];
            [str1 deleteCharactersInRange:NSMakeRange(max,1)];
            self.text = str1;
        }
    }
}
- (void)setObserver1:(id)Observer1
{
    objc_setAssociatedObject(self, Observer1_key,Observer1 ,  OBJC_ASSOCIATION_ASSIGN);
}
-(id)Observer1
{
    return objc_getAssociatedObject(self,Observer1_key);
}
- (void)setObserver2:(id)Observer2
{
    objc_setAssociatedObject(self, Observer2_key,Observer2 ,  OBJC_ASSOCIATION_ASSIGN);
}
-(id)Observer2
{
    return objc_getAssociatedObject(self,Observer2_key);
}
- (void)setMoveByKeyboard:(BOOL)MoveByKeyboard
{
    objc_setAssociatedObject(self, moveByKeyboard_key,@(MoveByKeyboard),  OBJC_ASSOCIATION_ASSIGN);
//    WEAK;
//    self.Observer1 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note)
//                      {
//                          if (weakSelf.isFirstResponder)
//                          {
//                              [UIView animateWithDuration:[[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^
//                               {
//                                   [UIView setAnimationCurve:[[note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue]];
//                                   CGRect rect = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//                                   NSLog(@"%f   %f",rect.origin.y,weakSelf.bottom+weakSelf.superview.y);
//                                   if (rect.origin.y-(weakSelf.bottom+weakSelf.superview.y)<40)
//                                   {
//                                       weakSelf.superview.y = weakSelf.superview.y+(rect.origin.y-(weakSelf.bottom+weakSelf.superview.y))-100;
//                                   }
//                               }];
//                          }
//                      }];
//    self.Observer2 = [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note)
//                      {
//                          if (weakSelf.isFirstResponder)
//                          {
//                              [UIView animateWithDuration:0.7 animations:^
//                               {
//                                   weakSelf.superview.y = 0;
//                               }];
//                          }
//                      }];
}
-(BOOL)MoveByKeyboard
{
    return [objc_getAssociatedObject(self, moveByKeyboard_key) integerValue];
}

-(void)ignoreThisInput
{
    self.text =  [self.text substringWithRange:NSMakeRange(0,self.text.length-1)];
}

-(void)setTextFieldLeftPadding:(CGFloat)leftWidth
{
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.ClickDoneHidenKeyboard)
    {
        [self resignFirstResponder];
    }
    return YES;
}
- (void)setClickDoneHidenKeyboard:(BOOL)ClickDoneHidenKeyboard
{
    self.delegate = self;
    objc_setAssociatedObject(self, keyboardhiden_key,@(ClickDoneHidenKeyboard) ,  OBJC_ASSOCIATION_ASSIGN);

}
-(void)addToolSender{ UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 40)]; [topView setBarStyle:UIBarStyleDefault]; UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]; UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom]; btn.frame = CGRectMake(2, 5, 50, 25); [btn addTarget:self action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside]; [btn setTitle:@"完成" forState:UIControlStateNormal]; [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal]; UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn]; NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil]; [topView setItems:buttonsArray]; self.inputAccessoryView = topView;
    
}
-(void)addToolSenderWithBlock:(void(^)(void))block{ UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)]; [topView setBarStyle:UIBarStyleDefault]; UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil]; UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom]; btn.frame = CGRectMake(2, 5, 50, 25); [btn addTarget:self action:@selector(resignFirstResponderAction) forControlEvents:UIControlEventTouchUpInside]; [btn setTitle:@"完成" forState:UIControlStateNormal]; [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal]; UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithCustomView:btn]; NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneBtn,nil]; [topView setItems:buttonsArray]; if (block && !objc_getAssociatedObject(self, &kBlockActionKey)) { objc_setAssociatedObject(self, &kBlockActionKey, block, OBJC_ASSOCIATION_COPY); } self.inputAccessoryView = topView; }
-(void)resignFirstResponderAction{
    
    void(^block)(void) = objc_getAssociatedObject(self, &kBlockActionKey);
    
    if (block) {
        block();
    }
    
}

-(BOOL)ClickDoneHidenKeyboard
{
    return [objc_getAssociatedObject(self, keyboardhiden_key) integerValue];
}

//(ps:这里提一下，+(void)load方法是一个特例，它会在当前类执行完之后再在category中执行。)
+(void)load {
    // is this the best solution?
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(swizzledDealloc)));
}
- (void)swizzledDealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self.Observer1];
        self.Observer1 = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self.Observer2];
        self.Observer2 = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"field干掉了");
    [self swizzledDealloc];
}
@end
