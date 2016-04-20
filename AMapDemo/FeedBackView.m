//
//  FeedBackView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/21.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "FeedBackView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation FeedBackView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.09*SCREEN_HEIGHT)];
        _label.text = @"意见反馈";
        _label.textAlignment = NSTextAlignmentCenter;
        _label.backgroundColor = [UIColor blueColor];
        _label.textColor = [UIColor whiteColor];
        
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, _label.frame.size.height+_label.frame.origin.y+0.015*SCREEN_WIDTH, SCREEN_WIDTH, 0.18*SCREEN_HEIGHT)];
        
        _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button.frame = CGRectMake(160, _textView.frame.size.height+_textView.frame.origin.y+10, 60, 60);
        [_button setTitle:@"提交" forState:UIControlStateNormal];
        
        [self addSubview:_label];
        [self addSubview:_textView];
        [self addSubview:_button];
        
    }
    return self;
}

@end
