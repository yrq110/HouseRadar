//
//  VersionDetailView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/21.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "VersionDetailView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

@implementation VersionDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _topView =[[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.09*SCREEN_HEIGHT)];
        _topView.topLabel.text = @"版本详情";
        _topView.returnButton.hidden = NO;
        [_topView.returnButton addTarget:self action:@selector(returnView) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_topView];
        
        
        self.versionNum=[[UILabel alloc]initWithFrame:CGRectMake(0, 0.09*SCREEN_HEIGHT, SCREEN_WIDTH, 44)];
        self.versionNum.text=@"当前版本v0.1";
        self.versionNum.textAlignment=NSTextAlignmentCenter;
        self.versionNum.font=[UIFont boldSystemFontOfSize:16.0];
        
        self.versionTime=[[UILabel alloc]initWithFrame:CGRectMake(0, [self getY:self.versionNum], self.frame.size.width, 44)];
        self.versionTime.text=@"2016-2";
        self.versionTime.textAlignment=NSTextAlignmentCenter;
        self.versionTime.font=[UIFont boldSystemFontOfSize:16.0];
        
        self.introduction=[[UILabel alloc]initWithFrame:CGRectMake(10, [self getY:self.versionTime]+5, self.frame.size.width-20, 300)];
//        self.introduction.text=@"      本应用具有同";
        self.introduction.font = [UIFont systemFontOfSize:14.0f];
        self.introduction.numberOfLines = 0;
        self.introduction.lineBreakMode = NSLineBreakByCharWrapping;
        [self.introduction sizeToFit];
        
        self.detail=[[UILabel alloc]initWithFrame:CGRectMake(10, [self getY:self.introduction]+10, self.frame.size.width-20, 300)];
        self.detail.text=@"      使用了以下第三方类库\n      ● AFNetworking\n      ● SDWebImage\n      ● MAMapKit\n      ● AMapSearchKit\n      ● ZFProgressView\n      ● QQButton";
        self.detail.font=[UIFont boldSystemFontOfSize:18.0f];
        self.detail.numberOfLines=0;
        self.detail.lineBreakMode=NSLineBreakByCharWrapping;
        self.detail.textColor=[UIColor redColor];
        [self.detail sizeToFit];
        
        [self addSubview:self.versionNum];
        [self addSubview:self.versionTime];
        [self addSubview:self.introduction];
        [self addSubview:self.detail];
    }
    return self;
}

- (void)returnView
{
    [self removeFromSuperview];
}


-(CGFloat)getY:(UIView*)view
{
    return view.frame.origin.y+view.frame.size.height;
}

@end
