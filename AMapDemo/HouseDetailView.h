//
//  HouseDetailView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/1/31.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
@interface HouseDetailView : UIView<UIScrollViewDelegate>
//0-list 1-mainMap 2-collect
@property int typeInt;
@property(strong,nonatomic)UIButton *goToMapBtn;
@property(strong,nonatomic)UIButton *collectBtn;
@property(strong,nonatomic)UIButton *deleteBtn;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *priceLabel;
@property(strong,nonatomic)UILabel *brokerNameLabel;
@property(strong,nonatomic)UILabel *brokerTelLabel;
@property(strong,nonatomic)UILabel *publishTimeLabel;
@property(strong,nonatomic)UILabel *descriptionLabel;
@property(strong,nonatomic)UILabel *configLabel;
@property(strong,nonatomic)UILabel *typeLabel;
@property(strong,nonatomic)UILabel *addressLabel;
@property id imageURL;
@property(strong,nonatomic)UIScrollView *imageScrollView;
@property(strong,nonatomic)UIImageView *houseImageView;
@property(strong,nonatomic)TopView *topView;
@property(strong,nonatomic)UIScrollView *scrollView;

@property(strong,nonatomic)UILabel *price;
@property(strong,nonatomic)UILabel *type;
@property(strong,nonatomic)UILabel *config;
@property(strong,nonatomic)UILabel *house_description;
@property(strong,nonatomic)UILabel *address;
@property(strong,nonatomic)UILabel *publishTime;
@property(strong,nonatomic)UILabel *brokerName;
@property(strong,nonatomic)UILabel *brokerTel;
@property(strong,nonatomic)NSString *xiaoqu;
@property(strong,nonatomic)UIButton *addCompareBtn;
-(void)transTitle:(NSString*)title price:(NSString*)price type:(NSString*)type config:(NSString*)config description:(NSString*)description address:(NSString*)address publishTime:(NSString*)publishTime imageURL:(id)imageURL broker_name:(NSString*)broker_name broker_tel:(NSString*)broker_tel xiaoqu:(NSString*)xiaoqu;
@end
