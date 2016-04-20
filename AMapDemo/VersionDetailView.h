//
//  VersionDetailView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/2/21.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
@interface VersionDetailView : UIView
@property(strong,nonatomic)TopView *topView;
@property(strong,nonatomic)UILabel *versionNum;
@property(strong,nonatomic)UILabel *versionTime;
@property(strong,nonatomic)UILabel *introduction;
@property(strong,nonatomic)UILabel *detail;
@end
