//
//  SegementView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "SegmentView.h"
#import "PicLoadEnableSharedClass.h"
@implementation SegmentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        _segmentArray = [[NSMutableArray alloc]init];
        _array = [NSArray arrayWithObjects:@"地图",@"收藏",@"对比",@"设置",nil];
        float width = frame.size.width/_array.count;
        
        for (int i = 0; i<[_array count]; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame = CGRectMake(width*i, 0, width, frame.size.height);
            [btn setTitle:[_array objectAtIndex:i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(clickSegment:) forControlEvents:UIControlEventTouchUpInside];
//            [btn setBackgroundColor:[UIColor orangeColor]];
            if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
//                NSLog(@"not nightmode");
                [btn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0]];
            }else{
//                NSLog(@"is nightmode");
                [btn setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:112.0/255.0 alpha:1.0]];
            }
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
            [_segmentArray addObject:btn];
//            NSLog(@"%@",_array[i]);
            [self addSubview:btn];
        }
        self.layer.masksToBounds = YES;
        
       
        
    }
    return self;
}


- (void)clickSegment:(id)sender{
    UIButton *btn = (UIButton*)sender;
    NSUInteger index = [_segmentArray indexOfObject:btn];
    [self.myDelegate buttonClick:index];
    [self updateSegmentStates:index];

}

-(void)updateSegmentStates:(NSUInteger)index{
    for (int i = 0; i<[_segmentArray count]; i++) {
        if (i == index) {
            UIButton *btn =[_segmentArray objectAtIndex:index];
            [btn setBackgroundColor:[UIColor whiteColor]];
            if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {

                [btn setTitleColor:[UIColor colorWithRed:0/255.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:112.0/255.0 alpha:1.0] forState:UIControlStateNormal];
            }

        }else{
            UIButton *btn = [_segmentArray objectAtIndex:i];
            if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
                [btn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0]];
            }else{
                [btn setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:112.0/255.0 alpha:1.0]];
            }
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        }
    }

}


-(void)changeColor
{
    NSLog(@"changeColor");
    for (int i = 0; i<[_segmentArray count]; i++) {
        
        UIButton *btn =[_segmentArray objectAtIndex:i];
        
        if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
            
            [btn setBackgroundColor:[UIColor colorWithRed:0/255.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0]];
        }else{
        
            [btn setBackgroundColor:[UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:112.0/255.0 alpha:1.0]];
        }
    }

}

@end


