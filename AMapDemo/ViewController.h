//
//  ViewController.h
//  AMapDemo
//
//  Created by yrq_mac on 16/1/22.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "AppDelegate.h"
#import "ExactSearchToolsView.h"
#import "RadarSearchToolsView.h"
#import "SegmentView.h"
#import "SettingView.h"
#import "FavoriteView.h"
#import "HistoryView.h"
#import "PinCallOutTappedView.h"
#import "ZFProgressView.h"
#import "QQButton.h"
#import "TopView.h"
#import "ListButtonView.h"
@interface ViewController : UIViewController<UITextFieldDelegate,MAMapViewDelegate,AMapSearchDelegate,CLLocationManagerDelegate,SegmentDelegate,UIAlertViewDelegate>

@property(strong,nonatomic)MAMapView *mapView;
@property(strong,nonatomic)AMapSearchAPI *search;
@property(strong,nonatomic)AMapPOI *MIP;
@property(strong,nonatomic)AMapPOIKeywordsSearchRequest *poiRequest;
@property(strong,nonatomic)CLLocationManager *userLocationManager;

@property(strong,nonatomic)UITextField *cityTextField;
@property(strong,nonatomic)UITextField *searchTextField;
@property(strong,nonatomic)UIButton *searchButton;

@property(strong,nonatomic)UIButton *listButton;
@property(strong,nonatomic)UIButton *radarSearchButton;
@property(strong,nonatomic)UIButton *exactSearchButton;

@property(strong,nonatomic)ExactSearchToolsView *esView;
@property(strong,nonatomic)ListButtonView *listBtnView;
@property int shiListOut;
@property int ListOutNo;
@property(strong,nonatomic)RadarSearchToolsView *rsView;
@property(strong,nonatomic)PinCallOutTappedView *pcotView;
@property(strong,nonatomic)UIView *toolView;
@property(strong,nonatomic)TopView *topView;
//@property(strong,nonatomic)UIView *topView;

@property BOOL isSearch;
+(id)shareViewController;
- (void)searchExcute:(NSString*)keyword city:(NSString*)city title:(NSString*)title price:(NSString*)price brokerName:(NSString*)brokerName brokerTel:(NSString*)brokerTel publishTime:(NSString*)publishTime description:(NSString*)description config:(NSString*)config type:(NSString*)type address:(NSString*)address;
@property(strong,nonatomic)NSArray *longArray;
@property(strong,nonatomic)NSArray *latiArray;

@property(strong,nonatomic)SegmentView *segmentView;
@property(strong,nonatomic)SettingView *settingView;
@property(strong,nonatomic)FavoriteView *favoriteView;
@property(strong,nonatomic)HistoryView *historyView;

@property(strong,nonatomic)ZFProgressView *rsProgress;
@property(strong,nonatomic)QQButton *mapTypeBtn;
@property(strong,nonatomic)QQButton *trafficBtn;
@property(strong,nonatomic)NSTimer *timer;
@end

