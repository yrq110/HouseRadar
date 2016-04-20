//
//  RadarSearchToolsView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/1/31.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadarSearchToolsView : UIView<UITextFieldDelegate>
@property(strong,nonatomic)UIButton *locationBtn;
@property(strong,nonatomic)UITextField *radiusTF;
@property(strong,nonatomic)UILabel *radiusLabel;
@property(strong,nonatomic)UIButton *searchBtn;
@end
