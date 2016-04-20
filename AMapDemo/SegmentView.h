//
//  SegmentView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/2/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentDelegate <NSObject>

- (void)buttonClick:(NSInteger)sender;
- (void)topButtonClick:(NSString*)sender;

@end


@interface SegmentView : UIView
@property(strong,nonatomic)NSMutableArray *segmentArray;
@property(strong,nonatomic)NSArray *array;
@property(strong,nonatomic)id<SegmentDelegate>myDelegate;
-(void)updateSegmentStates:(NSUInteger)index;
-(void)changeColor;
@end
