//
//  ContactView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/23.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "ContactView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#define LabelHeight 30
#define LabelTitleWidth 80
@implementation ContactView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];

        _topView =[[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.09*SCREEN_HEIGHT)];
        _topView.topLabel.text = @"联系我们";
        _topView.returnButton.hidden = NO;
        [_topView.returnButton addTarget:self action:@selector(returnView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_topView];
        
        _email = [[UILabel alloc]initWithFrame:CGRectMake(60, 100, LabelTitleWidth, LabelHeight)];
        _email.text = @"e-mail:";
        _email.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:22.0];
        
        [self addSubview:_email];
        
        _emailDetail = [[UILabel alloc]initWithFrame:CGRectMake(60, [self getLightYFrom:_email], 300, LabelHeight)];
        _emailDetail.text = @"house_radar@126.com";
        _emailDetail.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:22.0];
        [self addSubview:_emailDetail];
        
        _qq = [[UILabel alloc]initWithFrame:CGRectMake(60, [self getYFrom:_emailDetail], LabelTitleWidth, LabelHeight)];
        _qq.text = @"qq:";
        _qq.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:22.0];
        [self addSubview:_qq];
        
        _qqDetail = [[UILabel alloc]initWithFrame:CGRectMake(60, [self getLightYFrom:_qq],200, LabelHeight)];
        _qqDetail.text = @"360581440";
        _qqDetail.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:22.0];
        [self addSubview:_qqDetail];
        
        _weibo = [[UILabel alloc]initWithFrame:CGRectMake(60, [self getYFrom:_qqDetail], LabelTitleWidth, LabelHeight)];
        _weibo.text = @"weibo:";
        _weibo.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:20.0];
        [self addSubview:_weibo];
        
        _weiboDetail = [[UILabel alloc]initWithFrame:CGRectMake(60, [self getLightYFrom:_weibo], 200, LabelHeight)];
        _weiboDetail.text = @"House Radar";
        _weiboDetail.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:22.0];
        [self addSubview:_weiboDetail];
        
    }
    return self;
}


- (CGFloat)getLightYFrom:(UIView*)view
{
    return view.frame.size.height+view.frame.origin.y;
}

- (CGFloat)getYFrom:(UIView*)view
{
    return view.frame.size.height+view.frame.origin.y+10;
}

- (CGFloat)getXFrom:(UIView*)view
{
    return view.frame.size.width+view.frame.origin.x+10;
}


- (void)returnView
{
    [self removeFromSuperview];
}

@end
