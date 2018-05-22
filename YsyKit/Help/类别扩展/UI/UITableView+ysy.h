//
//  UITableView+ysy.h
//  IntelligentNetwork
//
//  Created by Runa on 2018/2/7.
//  Copyright © 2018年 Runa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (ysy)
- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;
@end
