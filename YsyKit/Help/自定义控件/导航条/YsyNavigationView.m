//
//  YsyNavigationView.m
//  IntelligentNetwork
//
//  Created by Runa on 2017/3/6.
//  Copyright © 2017年 Runa. All rights reserved.
//

#import "YsyNavigationView.h"
@interface YsyNavigationView ()
@property (nonatomic,strong) UILabel *titleLab;
@end

@implementation YsyNavigationView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = RGBFrom0X(BasicColor);
}
-(void)setIsX:(BOOL)isX
{
    _isX = isX;
    if (isX)
    {
        _titleLab.center = CGPointMake(SCREEN_WIDTH/2, 88-24);
        _titleButt.center = CGPointMake(SCREEN_WIDTH/2, 88-24);
        _backbutt.frame = CGRectMake(0, 88-42, 50, 40);
    }
}
-(void)setTitle:(NSString *)title
{
    if (!_titleLab)
    {
        _titleLab = [[UILabel alloc] init];
        _titleLab.center = CGPointMake(SCREEN_WIDTH/2, self.bounds.size.height-24);
        if (_isX)
        {
            _titleLab.center = CGPointMake(SCREEN_WIDTH/2, 88-24);
        }
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.bounds = CGRectMake(0, 0, 260, 24);
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.font = [UIFont systemFontOfSize:19];
        [self addSubview:_titleLab];
    }
    _title = title;
    _titleLab.text = title;
}
-(UIButton *)setTitleButtTitle:(NSString *)title pic:(UIImage *)pic
{
    if (!_titleButt)
    {
        _titleButt = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleButt.center = CGPointMake(SCREEN_WIDTH/2, self.frame.size.height-24);
        if (_isX)
        {
            _titleButt.center = CGPointMake(SCREEN_WIDTH/2, 88-24);
        }
        _titleButt.bounds = CGRectMake(0, 0, 260, 24);
        _titleButt.titleLabel.textColor = [UIColor whiteColor];
        _titleButt.titleLabel.font = [UIFont systemFontOfSize:19];
        _titleButt.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_titleButt setTitle:title forState:0];
        [_titleButt setImage:pic forState:0];
        [self addSubview:_titleButt];
    }
    return _titleButt;
}
-(UIButton *)backbutt
{
    if (!_backbutt)
    {
        _backbutt = [UIButton buttonWithType:UIButtonTypeCustom];
        _backbutt.frame = CGRectMake(0, self.frame.size.height-42, 50, 40);
        [_backbutt setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
        _backbutt.imageEdgeInsets = UIEdgeInsetsMake(6,8,6,10);
        [self addSubview:_backbutt];
    }
    return _backbutt;
}


@end
