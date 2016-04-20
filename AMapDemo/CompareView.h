//
//  CompareView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/2/29.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompareView : UIView
@property(strong,nonatomic)UILabel *priceLabel;
@property(strong,nonatomic)UILabel *xiaoquLabel;
@property(strong,nonatomic)UILabel *typeLabel;
@property(strong,nonatomic)UIImageView *houseImageView;
@property(strong,nonatomic)UIScrollView *typeScrollView;
@property(strong,nonatomic)UIScrollView *mainScrollView;
@property(strong,nonatomic)UIButton *deleteBtn;
@end
