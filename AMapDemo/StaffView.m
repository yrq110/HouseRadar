//
//  StaffView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/29.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "StaffView.h"

#import "PicLoadEnableSharedClass.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation StaffView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self topViewInit];
        UILabel *mainLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.133*SCREEN_WIDTH, 0.097*SCREEN_HEIGHT, 0.733*SCREEN_WIDTH, 0.075*SCREEN_HEIGHT)];
        mainLabel.text = @"Staff";
        mainLabel.textAlignment = NSTextAlignmentCenter;
        mainLabel.font = [UIFont boldSystemFontOfSize:30.0];
        [self addSubview:mainLabel];
        NSArray *arrayLabel = [NSArray arrayWithObjects:@"Leader", @"Mobile Terminal Coder", @"Database Server Coder",@"Master Server Coder",@"Art Designer",@"Idea",@"Equipment", nil];
        
        NSArray *arrayName = [NSArray arrayWithObjects:@"YTime",@"yrq110",@"YTime      yrq110",@"Dixxxy",@"Dixxxy",@"xiao_hao",@"Rizu",nil];
        for (int i = 0; i<arrayLabel.count; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0.133*SCREEN_WIDTH, 0.15*SCREEN_HEIGHT+i*0.1*SCREEN_HEIGHT, 0.733*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = [arrayLabel objectAtIndex:i];
            label.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:20.0];
            [self addSubview:label];
            UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.133*SCREEN_WIDTH, label.frame.size.height+label.frame.origin.y, 0.733*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT)];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.text = [arrayName objectAtIndex:i];
            nameLabel.font = [UIFont fontWithName:@"MarkerFelt-Thin" size:18.0];
            [self addSubview:nameLabel];
        }
        
    }
    return self;
}

- (void)topViewInit
{
    _topView =[[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.09*SCREEN_HEIGHT)];
    _topView.topLabel.text = @"Staff";
    [_topView.returnButton addTarget:self action:@selector(returnView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_topView];
    
}

- (void)returnView
{
    [self removeFromSuperview];

}
@end
