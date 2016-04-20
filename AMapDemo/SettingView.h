//
//  SettingView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/2/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopView.h"
#import "SegmentView.h"
#import <MessageUI/MFMailComposeViewController.h>
@interface SettingView : UIView<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,SegmentDelegate>
@property(strong,nonatomic)TopView *topView;
//@property(strong,nonatomic)UIView *topView;
//@property(strong,nonatomic)UILabel *topLabel;
@property(strong,nonatomic)UILabel *PicLoadLabel;
@property(strong,nonatomic)UISwitch *PicLoadSwitch;
@property(strong,nonatomic)UILabel *netLoadLabel;
@property(strong,nonatomic)UISwitch *netLoadSwitch;
@property(strong,nonatomic)UILabel *clearFavoriteLabel;
@property(strong,nonatomic)UIButton *clearFavoriteBtn;
@property(strong,nonatomic)UILabel *nightModeLabel;
@property(strong,nonatomic)UISwitch *nightModeSwitch;
@property(strong,nonatomic)UILabel *feedbackLabel;
@property(strong,nonatomic)UIButton *feedbackBtn;
@property(strong,nonatomic)UILabel *versionLabel;
@property(strong,nonatomic)UILabel *versionNo;
@property(strong,nonatomic)UILabel *appDetailLabel;
@property(strong,nonatomic)UIButton *appDetailBtn;
@property(strong,nonatomic)UILabel *staffLabel;
@property(strong,nonatomic)UIButton *staffBtn;
@property(strong,nonatomic)UITableView *tableView;
@end
