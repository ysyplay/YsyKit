//
//  YsyBaseViewController.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/7.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YsyNavigationView.h"
#import "SVProgressHUD.h"
@interface YsyBaseViewController : UIViewController
@property (weak, nonatomic) IBOutlet YsyNavigationView *NavView;
@property (assign,nonatomic) float NavViewHeight;
@property (assign,nonatomic) BOOL isHaveBackButt;
@property (nonatomic,assign) BOOL tabBarIsShow;
@property (nonatomic,assign) BOOL isLoadUI;
@property (nonatomic,copy) NSString *moudleType;
-(void)pop;
@end
