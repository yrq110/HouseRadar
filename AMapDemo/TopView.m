//
//  TopView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/21.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "TopView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#import "PicLoadEnableSharedClass.h"
@implementation TopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _returnButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_returnButton setFrame:CGRectMake(-0.0267*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT, 0.267*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        [_returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_returnButton setTitle:@"返回" forState:UIControlStateNormal];
//        [_returnButton addTarget:self action:@selector(returnExcute) forControlEvents:UIControlEventTouchUpInside];
        _returnButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.133*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT, 0.733*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
//        _topLabel.text = @"房源列表";
        [_topLabel setTextAlignment:NSTextAlignmentCenter];
        _topLabel.font = [UIFont boldSystemFontOfSize:24.0];
        _topLabel.textColor = [UIColor whiteColor];
        [self addSubview:_topLabel];
        [self addSubview:_returnButton];
        
        if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
//            NSLog(@"not nightmode");
            self.backgroundColor = [UIColor colorWithRed:0/255.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0];
        }else{
//            NSLog(@"is nightmode");
            self.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:112.0/255.0 alpha:1];
        }
        
    }
    
    return self;
}


@end
