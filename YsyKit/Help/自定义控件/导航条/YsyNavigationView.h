//
//  YsyNavigationView.h
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/6.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YsyNavigationView : UIView
@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIButton *backbutt,*titleButt;
@property (nonatomic,assign) BOOL isX;
-(UIButton *)setTitleButtTitle:(NSString *)title pic:(UIImage *)pic;
@end
