//
//  HouseListViewController.h
//  AMapDemo
//
//  Created by yrq_mac on 16/1/30.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
@interface HouseListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

+(id)shareHouseListViewController;
@property(strong,nonatomic)UITableView *tableView;
@property(strong,nonatomic)UIRefreshControl *refresh;
@property(strong,nonatomic)UIView *infiniteScrollView;
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
@property(strong,nonatomic)NSString *outXiaoqu;
@property(strong,nonatomic)NSString *outPrice;
@property(strong,nonatomic)TopView *topView;
//@property(strong,nonatomic)UIView *topView;
//@property(strong,nonatomic)UIButton *returnButton;
//@property(strong,nonatomic)UILabel *topLabel;
@property(strong,nonatomic)UIImageView *loadingImageView;
@property(strong,nonatomic)NSTimer *loadingTimer;
@property(strong,nonatomic)NSTimer *GETTimer;
@end
