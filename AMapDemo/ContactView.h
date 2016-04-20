//
//  ContactView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/2/23.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
@interface ContactView : UIView
@property(strong,nonatomic)TopView *topView;
@property(strong,nonatomic)UILabel *email;
@property(strong,nonatomic)UILabel *emailDetail;
@property(strong,nonatomic)UILabel *qq;
@property(strong,nonatomic)UILabel *qqDetail;
@property(strong,nonatomic)UILabel *weibo;
@property(strong,nonatomic)UILabel *weiboDetail;
@end
