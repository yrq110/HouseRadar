//
//  FavoriteView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/2/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
@interface FavoriteView : UIView<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)NSString *titleString;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)TopView *topView;
//@property(strong,nonatomic)UIView *topView;
//@property(strong,nonatomic)UILabel *topLabel;
@property(strong,nonatomic)NSMutableArray *titleArray;
@property(strong,nonatomic)NSMutableArray *addressArray;
@property(strong,nonatomic)NSMutableArray *priceArray;
@property(strong,nonatomic)NSMutableArray *roomArray;
@property(strong,nonatomic)NSMutableArray *picURLArray;
@property(strong,nonatomic)NSMutableArray *configArray;
@property(strong,nonatomic)NSMutableArray *descriptionArray;
@property(strong,nonatomic)NSMutableArray *publishTimeArray;
@property(strong,nonatomic)NSMutableArray *brokerNameArray;
@property(strong,nonatomic)NSMutableArray *brokerTelArray;
@property(strong,nonatomic)NSMutableArray *xiaoquArray;

- (void)reloadTableViewData:(NSMutableArray*)titleArray address:(NSMutableArray*)addressArray price:(NSMutableArray*)priceArray room:(NSMutableArray*)roomArray priURL:(NSMutableArray*)picURLArray config:(NSMutableArray*)configArray description:(NSMutableArray*)descriptionArray publishTime:(NSMutableArray*)publishTimeArray brokerName:(NSMutableArray*)brokerNameArray brokerTel:(NSMutableArray*)brokerTelArray xiaoqu:(NSMutableArray*)xiaoquArray;
+ (FavoriteView*)sharedFavoriteView;
@end
