//
//  ListButtonView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/3/2.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "ListButtonView.h"
#import "ViewController.h"
#import "PicLoadEnableSharedClass.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation ListButtonView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref;
        if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
            
            colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
            
        }else{
            
            colorref = CGColorCreate(colorSpace, (CGFloat[]){25.0/255.0,25.0/255.0,191.0/255.0,1});
            
        }
        
        [self setBackgroundColor:[UIColor clearColor]];
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 0.08*SCREEN_WIDTH, 3*0.045*SCREEN_HEIGHT)];
        for (int i = 1 ; i<10; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(0, (i-1)*0.045*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
            btn.tag = i;
            [btn addTarget:self action:@selector(btnTap:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];
//            [btn.layer setMasksToBounds:YES];
//            [btn.layer setCornerRadius:8.0];
//            [btn.layer setBorderWidth:3.0];
//            [btn setBackgroundColor:[UIColor whiteColor]];
//            [btn.layer setBorderColor:colorref];
            [_scrollView addSubview:btn];
        }
        [_scrollView setContentSize:CGSizeMake(0.08*SCREEN_WIDTH, 9*0.045*SCREEN_HEIGHT)];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:8.0];
        [self.layer setBorderWidth:3.0];
        [self setBackgroundColor:[UIColor whiteColor]];
        
        //        CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
        [self.layer setBorderColor:colorref];
    }
    return self;
}

- (void)btnTap:(UIButton*)btn
{
    NSLog(@"tag is %d",(int)btn.tag);
    ViewController *vc = (ViewController*)[ViewController shareViewController];
    switch (vc.ListOutNo) {
        case 91:
            [vc.esView.shiBtn setTitle:[NSString stringWithFormat:@"%d",(int)btn.tag] forState:UIControlStateNormal];
            break;
        case 92:
            [vc.esView.tingBtn setTitle:[NSString stringWithFormat:@"%d",(int)btn.tag] forState:UIControlStateNormal];
            break;
        case 93:
            [vc.esView.weiBtn setTitle:[NSString stringWithFormat:@"%d",(int)btn.tag] forState:UIControlStateNormal];
            break;
    }
    
    vc.shiListOut = 0;
    [self removeFromSuperview];
}


@end
