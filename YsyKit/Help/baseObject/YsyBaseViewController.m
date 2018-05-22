//
//  YsyBaseViewController.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/7.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "YsyBaseViewController.h"
#import "YsyNavigationView.h"
#import "YsyDeviceInfoToos.h"
#import "UITextField+ysy.h"
@interface YsyBaseViewController ()

@end

@implementation YsyBaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [SVProgressHUD setMaximumDismissTimeInterval:1.8];
//    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:[UIColor darkGrayColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//    [self hideTabBar];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tabBarController.tabBar.hidden = YES;
    _NavViewHeight = 64;

    WEAK;
    //适配X
    if ([[YsyDeviceInfoToos getDeviceName] containsString:@"iPhone X"])
    {
        weakSelf.NavView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 88);
        _NavViewHeight = 88;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.03 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                for (NSLayoutConstraint *constraint in weakSelf.NavView.constraints)
                {
                    if (constraint.firstAttribute == NSLayoutAttributeHeight)
                    {
                        constraint.constant = 88;
                        weakSelf.NavView.isX = YES;
                    }
                }
            });
        });
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setIsHaveBackButt:(BOOL)isHaveBackButt
{
    if (isHaveBackButt)
    {
       [self.NavView.backbutt addTarget:self action:@selector(pop) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)pop
{
    [SVProgressHUD dismiss];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
