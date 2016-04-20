//
//  PinCallOutTappedView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/11.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "PinCallOutTappedView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation PinCallOutTappedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self setBackgroundColor:[UIColor whiteColor]];
        _goBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _goBtn.frame = CGRectMake(0, 0, 0.213*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
        [_goBtn setTitle:@"去那儿" forState:UIControlStateNormal];
        _goBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [_goBtn.layer setMasksToBounds:YES];
        [_goBtn.layer setCornerRadius:8.0];
        [_goBtn.layer setBorderWidth:3.0];
        [_goBtn setBackgroundColor:[UIColor whiteColor]];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
        [_goBtn.layer setBorderColor:colorref];
        [self addSubview:_goBtn];
        
        _detailBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _detailBtn.frame = CGRectMake(_goBtn.frame.size.width+0.0267*SCREEN_WIDTH, 0, 0.213*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
        [_detailBtn setTitle:@"详细" forState:UIControlStateNormal];
        _detailBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [_detailBtn.layer setMasksToBounds:YES];
        [_detailBtn.layer setCornerRadius:8.0];
        [_detailBtn.layer setBorderWidth:3.0];
        [_detailBtn setBackgroundColor:[UIColor whiteColor]];
        [_detailBtn.layer setBorderColor:colorref];
        [self addSubview:_detailBtn];
        
    }
    return self;
}

@end
