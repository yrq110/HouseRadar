//
//  RadarSearchToolsView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/1/31.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "RadarSearchToolsView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#import "PicLoadEnableSharedClass.h"

@implementation RadarSearchToolsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];

        _locationBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _locationBtn.frame = CGRectMake(0, 0.015*SCREEN_HEIGHT, SCREEN_WIDTH*0.133, SCREEN_HEIGHT*0.045);
        [_locationBtn setTitle:@"定位" forState:UIControlStateNormal];
        [self addSubview:_locationBtn];
       
        _radiusLabel = [[UILabel alloc]initWithFrame:CGRectMake(_locationBtn.frame.origin.x+_locationBtn.frame.size.width+0.0267*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.267*SCREEN_WIDTH, SCREEN_HEIGHT*0.045)];
        _radiusLabel.text = @"搜索半径(m)";
        _radiusLabel.textColor = [UIColor colorWithRed:0/255.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0];
        [self addSubview:_radiusLabel];
        
        _radiusTF = [[UITextField alloc]initWithFrame:CGRectMake(_radiusLabel.frame.origin.x+_radiusLabel.frame.size.width, 0.015*SCREEN_HEIGHT, 0.32*SCREEN_WIDTH, SCREEN_HEIGHT*0.045)];
        _radiusTF.placeholder = @"请输入半径";
        _radiusTF.borderStyle     = UITextBorderStyleRoundedRect;
        _radiusTF.clearButtonMode = UITextFieldViewModeAlways;
        [self addSubview:_radiusTF];
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _searchBtn.frame = CGRectMake(_radiusTF.frame.origin.x+_radiusTF.frame.size.width+0.0267*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.213*SCREEN_WIDTH, SCREEN_HEIGHT*0.045);
        [_searchBtn setTitle:@"搜！" forState:UIControlStateNormal];
        [self addSubview:_searchBtn];
        
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:8.0];
        [self.layer setBorderWidth:3.0];
        [self setBackgroundColor:[UIColor whiteColor]];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref;
        if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {

            colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});

        }else{
            
            colorref = CGColorCreate(colorSpace, (CGFloat[]){25.0/255.0,25.0/255.0,191.0/255.0,1});

        }
//        CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
        [self.layer setBorderColor:colorref];
    }
    return self;
}

- (void)viewViewAppear
{

}

@end
