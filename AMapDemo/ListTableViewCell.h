//
//  ListTableViewCell.h
//  AMapDemo
//
//  Created by yrq_mac on 16/1/30.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTableViewCell : UITableViewCell
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *cityLabel;
@property(strong,nonatomic)UILabel *priceLabel;
@property(strong,nonatomic)UILabel *publishTimeLabel;
@property(strong,nonatomic)UILabel *roomLabel;
@property(strong,nonatomic)UIButton *clickButton;
@property(strong,nonatomic)UIImageView *houseImageView;
@property(strong,nonatomic)UIScrollView *titleScrollView;
@end