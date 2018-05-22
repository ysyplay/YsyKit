//
//  NSString+ysy.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/16.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "NSString+ysy.h"

@implementation NSString (ysy)
- (CGSize)textSizeWithContentSize:(CGSize)size font:(UIFont *)font {
    //这个地方可以扩展计算行间距
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle setLineSpacing:3];
//    [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font,NSParagraphStyleAttributeName:paragraphStyle} context:nil].size;
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGFloat)textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return [self textSizeWithContentSize:size font:font].height;
}

- (CGFloat)textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    return [self textSizeWithContentSize:size font:font].width;
}
-(NSString *)timeStamp
{
    NSString* timeStr = self;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSLog(@"timeSp:%@",timeSp); //时间戳的值
    return timeSp;
}
-(NSString *)timeString
{
    // iOS 生成的时间戳是10位
    NSTimeInterval interval;
    if (self.length>=10)
    {
       interval = [[self substringToIndex:10] doubleValue];
    }
    else
    {
        interval = [self doubleValue];
    }
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    NSLog(@"服务器返回的时间戳对应的时间是:%@",dateString);
    return dateString;
}
//验证是否在规定范围内
- (BOOL)isBelongString:(NSString *)str
{
    if (self.length>0)
    {
        NSCharacterSet *cs;
        cs = [NSCharacterSet characterSetWithCharactersInString:str];
        NSRange specialrang = [self rangeOfCharacterFromSet:cs];
        if (specialrang.location != NSNotFound)
        {
            return YES;
        }
    }
    if (self.length == 0)
    {
        return YES;
    }
   return NO;
}
-(BOOL)isNum
{
    NSError *error = NULL;
    NSArray *Patterns = @[@"^-?((0\\.)([0-9]+))$",@"^-?(([1-9]+[0-9]*\\.)([0-9]+))$",@"^-?[1-9]+[0-9]*$",@"^0$"];
    for (int i = 0; i<Patterns.count; i++)
    {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:Patterns[i] options:NSRegularExpressionCaseInsensitive error:&error];
        NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, [self length])];
        NSRange resultRange = [result rangeAtIndex:0];
        //从urlString当中截取数据
        NSString *result1 =[self substringWithRange:resultRange];
        NSLog(@"**** %@",result1);
        //    //输出结果
        //    NSLog(@"%@",result);
        if (result)
        {
            NSLog(@"&&&&&&& %@",Patterns[i]);
            return YES;
        }
    }

    return NO;
}
- (BOOL)isToday {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [self substringToIndex:10];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}

- (BOOL) isEmpty
{
    if (!self)
    {
        return true;
    }
    else
    {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [self stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
@end
