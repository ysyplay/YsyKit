//
//  UILabel+ysy.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/29.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "UILabel+ysy.h"

@implementation UILabel (ysy)

- (void)settingLabelRowOfHeight:(CGFloat)height string:(NSString*)string{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:height]; //调整行间距
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
    self.attributedText = attributedString;
    [self sizeToFit];
}
-(void)setMaxLenght:(NSInteger)length
{
    if (self.text.length>length)
    {
        self.text = [[self.text substringToIndex:length-1] stringByAppendingString:@"..."];
    }
}

-(void)setText:(NSString *)text color:(UIColor *)color range:(NSRange)range
{
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:text];
    
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:color
     
                          range:range];
    
    self.attributedText = AttributedStr;
    
    
}
@end
