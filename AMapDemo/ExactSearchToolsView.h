//
//  ExactSearchToolsView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/1/31.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ExactSearchToolsView : UIView<UITextFieldDelegate>
@property(strong,nonatomic)UILabel *priceLabel;
@property(strong,nonatomic)UITextField *priceTF;
@property(strong,nonatomic)UILabel *roomLabel;
@property(strong,nonatomic)UITextField *shiTF;
@property(strong,nonatomic)UILabel *shiLabel;
@property(strong,nonatomic)UITextField *tingTF;
@property(strong,nonatomic)UILabel *tingLabel;
@property(strong,nonatomic)UITextField *weiTF;
@property(strong,nonatomic)UILabel *weiLabel;
@property(strong,nonatomic)UIButton *detailButton;

@property(strong,nonatomic)UIButton *shiBtn;
@property(strong,nonatomic)UIButton *tingBtn;
@property(strong,nonatomic)UIButton *weiBtn;
@end
