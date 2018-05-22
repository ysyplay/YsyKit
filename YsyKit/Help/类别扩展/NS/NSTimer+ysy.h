//
//  NSTimer+ysy.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/9/21.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (ysy)
+ (NSTimer*)ysy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval                                         block:(void(^)(void))block repeats:(BOOL)repeats;
@end
