//
//  NSDate+ysy.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/23.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "NSDate+ysy.h"

@implementation NSDate (ysy)
-(NSString *)timeString
{
    //时间格式器
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式器的日期格式
    [fomatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    //把一个日期转化为字符串
    NSString *str =  [fomatter stringFromDate:self];
    
    
    NSLog(@"。》》》 %@",str);
    return str;
}
-(NSString *)timeStringByFormatter:(NSString *)Formatter
{
    //时间格式器
    NSDateFormatter *fomatter = [[NSDateFormatter alloc] init];
    
    //设置时间格式器的日期格式
    [fomatter setDateFormat:Formatter];
    
    //把一个日期转化为字符串
    NSString *str =  [fomatter stringFromDate:self];
    
    
    NSLog(@"。》》》 %@",str);
    return str;
}
- (NSString *)timeStamp
{

    NSLog(@"时间戳%ld",(long)[self timeIntervalSince1970]);
    return [NSString stringWithFormat:@"%ld",(long)[self timeIntervalSince1970]];
}
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday {
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}
@end
