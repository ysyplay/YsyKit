//
//  NSTimer+ysy.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/9/21.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "NSTimer+ysy.h"

@implementation NSTimer (ysy)
+ (NSTimer*)ysy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval                                         block:(void(^)(void))block repeats:(BOOL)repeats
{
    return[self
     scheduledTimerWithTimeInterval:interval target:self selector:@selector(ysy_blockInvoke:)                                                userInfo:[block copy] repeats:repeats];
}
+ (void)ysy_blockInvoke:(NSTimer*)timer
{
    void(^block)(void) = timer.userInfo;
         if(block)
         {
             block();
         }
}
@end
