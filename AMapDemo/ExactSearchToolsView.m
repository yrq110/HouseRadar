//
//  ExactSearchToolsView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/1/31.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "ExactSearchToolsView.h"
#import "PicLoadEnableSharedClass.h"
#import "ListButtonView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)


@implementation ExactSearchToolsView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0267*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.133*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        _priceLabel.text = @"价格: ";
        [self addSubview:_priceLabel];
        
        _priceTF = [[UITextField alloc]initWithFrame:CGRectMake(0.187*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.533*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        _priceTF.borderStyle     = UITextBorderStyleRoundedRect;
        _priceTF.placeholder     = @"输入价格";
        _priceTF.keyboardType    = UIKeyboardTypeNumberPad;
        _priceTF.clearButtonMode = UITextFieldViewModeAlways;
        _priceTF.delegate        = self;
        [self addSubview:_priceTF];
        
        _roomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0267*SCREEN_WIDTH, [self adjustOriginY:_priceLabel]+0.0075*SCREEN_HEIGHT, 0.133*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        _roomLabel.text = @"户型: ";
        [self addSubview:_roomLabel];
        
        _shiBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _shiBtn.frame = CGRectMake(0.187*SCREEN_WIDTH, [self adjustOriginY:_priceLabel]+0.0075*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
        [_shiBtn setTitle:@"1" forState:UIControlStateNormal];
        _shiBtn.tag = 91;
        [_shiBtn addTarget:self action:@selector(ListButtonInit:) forControlEvents:UIControlEventTouchUpInside];
        [_shiBtn.layer setMasksToBounds:YES];
        [_shiBtn.layer setCornerRadius:8.0];
        [_shiBtn.layer setBorderWidth:3.0];
        [_shiBtn setBackgroundColor:[UIColor whiteColor]];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref;
        if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
            
            colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
            
        }else{
            
            colorref = CGColorCreate(colorSpace, (CGFloat[]){25.0/255.0,25.0/255.0,191.0/255.0,1});
            
        }
        [_shiBtn.layer setBorderColor:colorref];
        [self addSubview:_shiBtn];
        
        _shiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.26*SCREEN_WIDTH+10, [self adjustOriginY:_priceLabel]+0.0075*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        _shiLabel.text = @"室";
        [self addSubview:_shiLabel];
        
        _tingBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _tingBtn.frame = CGRectMake(0.373*SCREEN_WIDTH, [self adjustOriginY:_priceLabel]+0.0075*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
        [_tingBtn setTitle:@"1" forState:UIControlStateNormal];
        _tingBtn.tag = 92;
        [_tingBtn addTarget:self action:@selector(ListButtonInit:) forControlEvents:UIControlEventTouchUpInside];
        [_tingBtn.layer setMasksToBounds:YES];
        [_tingBtn.layer setCornerRadius:8.0];
        [_tingBtn.layer setBorderWidth:3.0];
        [_tingBtn setBackgroundColor:[UIColor whiteColor]];
        [_tingBtn.layer setBorderColor:colorref];
        [self addSubview:_tingBtn];
        
        _tingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.467*SCREEN_WIDTH, [self adjustOriginY:_priceLabel]+0.0075*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        _tingLabel.text = @"厅";
        [self addSubview:_tingLabel];
        
        _weiBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _weiBtn.frame = CGRectMake(0.56*SCREEN_WIDTH, [self adjustOriginY:_priceLabel]+0.0075*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
        [_weiBtn setTitle:@"1" forState:UIControlStateNormal];
        _weiBtn.tag = 93;
        [_weiBtn addTarget:self action:@selector(ListButtonInit:) forControlEvents:UIControlEventTouchUpInside];
        [_weiBtn.layer setMasksToBounds:YES];
        [_weiBtn.layer setCornerRadius:8.0];
        [_weiBtn.layer setBorderWidth:3.0];
        [_weiBtn setBackgroundColor:[UIColor whiteColor]];
        [_weiBtn.layer setBorderColor:colorref];
        [self addSubview:_weiBtn];
        
        _weiLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.653*SCREEN_WIDTH, [self adjustOriginY:_priceLabel]+0.0075*SCREEN_HEIGHT, 0.08*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        _weiLabel.text = @"卫";
        [self addSubview:_weiLabel];
        
        _detailButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _detailButton.frame = CGRectMake(0.8*SCREEN_WIDTH,[self adjustOriginY:_priceLabel]-0.0075*SCREEN_HEIGHT, 0.16*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
        [_detailButton setTitle:@"搜索" forState:UIControlStateNormal];
        [self addSubview:_detailButton];
        _detailButton.tag = 1;
//        [_detailButton addTarget:self action:@selector(btnDown:) forControlEvents:UIControlEventTouchUpInside];
        
        _priceTF.text = @"2100";
        [self.layer setMasksToBounds:YES];
        [self.layer setCornerRadius:8.0];
        [self.layer setBorderWidth:3.0];
        [self setBackgroundColor:[UIColor whiteColor]];
//        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

//        CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
        [self.layer setBorderColor:colorref];
    }
    return self;
}

- (void)ListButtonInit:(UIButton*)btn
{

}

-(CGFloat)adjustOriginY:(UIView*)view
{
    return view.frame.size.height+view.frame.origin.y;

}


@end
