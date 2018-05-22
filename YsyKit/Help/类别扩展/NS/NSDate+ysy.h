//
//  NSDate+ysy.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/23.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ysy)
//获得标准时间字符串
-(NSString *)timeString;
/** 字符串时间戳。 */
- (NSString *)timeStamp;
-(NSString *)timeStringByFormatter:(NSString *)Formatter;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
@end
