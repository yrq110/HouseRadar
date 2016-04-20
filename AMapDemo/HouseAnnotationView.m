//
//  HouseAnnotationView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/6.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "HouseAnnotationView.h"
@interface HouseAnnotationView ()

@property (nonatomic, strong, readwrite) HouseCalloutView *calloutView;

@end

@implementation HouseAnnotationView
#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[HouseCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.image = [UIImage imageNamed:@"ep.png"];
        self.calloutView.title = self.annotation.title;
//        self.calloutView.subtitle = self.annotation.subtitle;
        [self.calloutView.btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}


- (void)click:(UIButton*)btn
{
    NSLog(@"hahaha");
}
@end
