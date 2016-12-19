//
//  SettingView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "SettingView.h"
#import "Reachability.h"
#import "PicLoadEnableSharedClass.h"
#import "AppDelegate.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "FeedBackView.h"
#import "VersionDetailView.h"
#import "ContactView.h"
#import "ViewController.h"
#import "StaffView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation SettingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self topViewInit];
        [self tableViewInit];
//        [self ToolViewInit];
        
//        FeedBackView *view = [[FeedBackView alloc]initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.bounds), 270)];
//        [self addSubview:view];
        
//        VersionDetailView *view = [[VersionDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.9*SCREEN_HEIGHT)];
//        [self addSubview:view];
        
//        Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
//        switch ([r currentReachabilityStatus]) {
//            case NotReachable:
//                NSLog(@"No Net");
//                break;
//            case ReachableViaWWAN:
//                NSLog(@"3G");
//                break;
//            case ReachableViaWiFi: 
//                NSLog(@"Wifi");
//                break;
//        }
    }
    return self;
}

- (void)topViewInit
{
    _topView =[[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.09*SCREEN_HEIGHT)];
    _topView.topLabel.text = @"设置";
    _topView.returnButton.hidden = YES;

    [self addSubview:_topView];
    
}

- (void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0.1*SCREEN_HEIGHT, SCREEN_WIDTH, 0.81*SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];

}

- (void)PicLoadToolInit
{
    _PicLoadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.08*SCREEN_WIDTH, 0.0075*SCREEN_HEIGHT, 0.48*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _PicLoadLabel.text = @"加载图片";
    
    _PicLoadSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0.8*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.107*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _PicLoadSwitch.on = [PicLoadEnableSharedClass newInstance].WWANLoadPicEnabled;
    _PicLoadSwitch.tag = 1;
    [_PicLoadSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)netLoadToolInit
{
    _netLoadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.08*SCREEN_WIDTH, 0.0075*SCREEN_HEIGHT, 0.48*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _netLoadLabel.text = @"移动网络下加载图片";
    
    _netLoadSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0.8*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.107*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _netLoadSwitch.on = [PicLoadEnableSharedClass newInstance].MobileNetLoadEnabled;
    _netLoadSwitch.tag = 3;
    [_netLoadSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
//    if ([PicLoadEnableSharedClass newInstance].MobileNetLoadEnabled == YES) {
//        _netLoadSwitch
//    }
    if ([PicLoadEnableSharedClass newInstance].WWANLoadPicEnabled == YES) {
        _netLoadSwitch.enabled = YES;
        _netLoadLabel.textColor = [UIColor blackColor];
    }else{
        _netLoadSwitch.enabled = NO;
        _netLoadLabel.textColor = [UIColor grayColor];
    }
}


- (void)switchAction:(UISwitch*)control
{
    switch (control.tag) {
        case 1:
            if (_PicLoadSwitch.on == YES) {
                [PicLoadEnableSharedClass newInstance].WWANLoadPicEnabled = YES;
                [self picEnabled:[PicLoadEnableSharedClass newInstance].WWANLoadPicEnabled];
            }else if(_PicLoadSwitch.on == NO){
                [PicLoadEnableSharedClass newInstance].WWANLoadPicEnabled = NO;
                [self picEnabled:[PicLoadEnableSharedClass newInstance].WWANLoadPicEnabled];
            }
            break;
        case 2:
//            NSLog(@"night cool");
            if (_nightModeSwitch.on == YES) {
                [PicLoadEnableSharedClass newInstance].isNightMode = YES;
//                NSLog(@"is nightmode");
                [_tableView reloadData];
                _topView.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:112.0/255.0 alpha:1];
                
                ViewController *VC = (ViewController*)[ViewController shareViewController];
                if(VC.segmentView)
                {
                    [VC.segmentView updateSegmentStates:3];
                }
            }else if(_nightModeSwitch.on == NO){
                [PicLoadEnableSharedClass newInstance].isNightMode = NO;
//                NSLog(@"not nightmode");
                [_tableView reloadData];
                _topView.backgroundColor = [UIColor colorWithRed:0/255.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0];
                
                ViewController *VC = (ViewController*)[ViewController shareViewController];
                if(VC.segmentView)
                {
                    [VC.segmentView updateSegmentStates:3];

                }
            }
            break;
        case 3:
            if (_netLoadSwitch.on == YES) {
                [PicLoadEnableSharedClass newInstance].MobileNetLoadEnabled = YES;
            }else if(_netLoadSwitch.on == NO){
                [PicLoadEnableSharedClass newInstance].MobileNetLoadEnabled = NO;
            }
            break;
    }
    
}

-(void)picEnabled:(BOOL)status
{
    if (status == YES) {
        NSLog(@"yes");
        _netLoadSwitch.enabled = YES;
        _netLoadLabel.textColor = [UIColor blackColor];
    }else if (status == NO)
    {
        NSLog(@"no");
        _netLoadSwitch.enabled = NO;
        _netLoadLabel.textColor = [UIColor grayColor];
    }
}

- (void)clearFavoriteToolInit{
    _clearFavoriteLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.08*SCREEN_WIDTH, 0.0075*SCREEN_HEIGHT, 0.48*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _clearFavoriteLabel.text = @"清空收藏夹";
    
    _clearFavoriteBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _clearFavoriteBtn.frame = CGRectMake(0.8*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.133*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
    [_clearFavoriteBtn setTitle:@"清除" forState:UIControlStateNormal];
    [_clearFavoriteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_clearFavoriteBtn addTarget:self action:@selector(clearAction) forControlEvents:UIControlEventTouchUpInside];
    [_clearFavoriteBtn setBackgroundColor:[UIColor orangeColor]];
    [_clearFavoriteBtn.layer setMasksToBounds:YES];
    [_clearFavoriteBtn.layer setCornerRadius:15.0];
}


- (void)clearAction
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"清空收藏夹" message:@"确定清空吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = 3;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 3) {
        if (buttonIndex == 0) {
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            NSManagedObjectContext *context = delegate.managedObjectContext;
            
            NSEntityDescription *house = [NSEntityDescription entityForName:@"HouseEntity" inManagedObjectContext:context];
            
            NSFetchRequest *request = [NSFetchRequest new];
            [request setEntity:house];
            NSArray *objArray = [context executeFetchRequest:request error:nil];
            for (NSManagedObject *obj in objArray) {
                if (obj) {
                    [context deleteObject:obj];
                    [context save:nil];
                }
            }
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"已清空" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
    
}

- (void)nightModeToolInit
{
    _nightModeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.08*SCREEN_WIDTH, 0.0075*SCREEN_HEIGHT, 0.48*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _nightModeLabel.text = @"夜间模式";
    
    _nightModeSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(0.8*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.107*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _nightModeSwitch.on = [PicLoadEnableSharedClass newInstance].isNightMode;
    _nightModeSwitch.tag = 2;
    [_nightModeSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)feedbackInit
{
    _feedbackLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.08*SCREEN_WIDTH, 0.0075*SCREEN_HEIGHT, 0.48*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _feedbackLabel.text = @"意见反馈";
    
    _feedbackBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _feedbackBtn.frame = CGRectMake(0.8*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.133*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
    [_feedbackBtn addTarget:self action:@selector(contactView) forControlEvents:UIControlEventTouchUpInside];
    [_feedbackBtn setTitle:@"查看" forState:UIControlStateNormal];
    [_feedbackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_feedbackBtn setBackgroundColor:[UIColor orangeColor]];
    [_feedbackBtn.layer setMasksToBounds:YES];
    [_feedbackBtn.layer setCornerRadius:15.0];
}

- (void)contactView
{
    NSLog(@"mailView");
    ContactView *contact = [[ContactView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
    [self addSubview:contact];
    
}

- (void)versionInit
{
    _versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.08*SCREEN_WIDTH, 0.0075*SCREEN_HEIGHT, 0.48*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _versionLabel.text = @"当前版本";
    
    _versionNo = [[UILabel alloc]initWithFrame:CGRectMake(0.827*SCREEN_WIDTH, 0.0075*SCREEN_HEIGHT, 0.48*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithContentsOfFile:path];
    NSString *str = [dict objectForKey:@"version"];
    _versionNo.text = str;
    _versionNo.textColor = [UIColor orangeColor];
    _versionNo.font = [UIFont fontWithName:@"DBLCDTempBlack" size:25.0];
}

- (void)appDetailInit
{
    _appDetailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.08*SCREEN_WIDTH, 0.0075*SCREEN_HEIGHT, 0.48*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _appDetailLabel.text = @"关于HouseRadar";
    
    _appDetailBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _appDetailBtn.frame = CGRectMake(0.8*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.133*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
    [_appDetailBtn setTitle:@"查看" forState:UIControlStateNormal];
    [_appDetailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_appDetailBtn addTarget:self action:@selector(detailView) forControlEvents:UIControlEventTouchUpInside];
    [_appDetailBtn setBackgroundColor:[UIColor orangeColor]];
    [_appDetailBtn.layer setMasksToBounds:YES];
    [_appDetailBtn.layer setCornerRadius:15.0];
}

- (void)detailView
{
    VersionDetailView *detailView = [[VersionDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
    [self addSubview:detailView];
}

- (void)staffInit
{
    _staffLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.08*SCREEN_WIDTH, 0.0075*SCREEN_HEIGHT, 0.48*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
    _staffLabel.text = @"Staff";
    
    _staffBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _staffBtn.frame = CGRectMake(0.8*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.133*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
    [_staffBtn setTitle:@"查看" forState:UIControlStateNormal];
    [_staffBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_staffBtn addTarget:self action:@selector(staffView) forControlEvents:UIControlEventTouchUpInside];
    [_staffBtn setBackgroundColor:[UIColor orangeColor]];
    [_staffBtn.layer setMasksToBounds:YES];
    [_staffBtn.layer setCornerRadius:15.0];
}

- (void)staffView
{
     StaffView *staffView = [[StaffView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
    [self addSubview:staffView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
//    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName=@"123";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    UIView *colorLineBottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.075*SCREEN_HEIGHT)];
//    NSLog(@"%d",(int)cell.frame.size.height);
    [colorLineBottom setBackgroundColor:[UIColor whiteColor]];
    [colorLineBottom.layer setMasksToBounds:YES];
    [colorLineBottom.layer setCornerRadius:8.0];
    [colorLineBottom.layer setBorderWidth:5.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref;
    if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
//        NSLog(@"not nightmode");
        colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
    }else{
//        NSLog(@"is nightmode");
        colorref = CGColorCreate(colorSpace, (CGFloat[]){25.0/255.0,25.0/255.0,112.0/255.0,1});
    }
    
    [colorLineBottom.layer setBorderColor:colorref];
//    [colorLineBottom.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor blueColor])];
    [cell addSubview:colorLineBottom];

    switch (indexPath.row) {
        case 0:
            [self PicLoadToolInit];
            [cell addSubview:_PicLoadSwitch];
            [cell addSubview:_PicLoadLabel];
            break;
        case 1:
            [self netLoadToolInit];
            [cell addSubview:_netLoadLabel];
            [cell addSubview:_netLoadSwitch];
            break;
        case 2:
            [self clearFavoriteToolInit];
            [cell addSubview:_clearFavoriteLabel];
            [cell addSubview:_clearFavoriteBtn];
            break;
        case 3:
            [self nightModeToolInit];
            [cell addSubview:_nightModeLabel];
            [cell addSubview:_nightModeSwitch];
            break;
        case 4:
            [self feedbackInit];
            [cell addSubview:_feedbackLabel];
            [cell addSubview:_feedbackBtn];
            break;
        case 5:
            [self versionInit];
            [cell addSubview:_versionLabel];
            [cell addSubview:_versionNo];
            break;
        case 6:
            [self appDetailInit];
            [cell addSubview:_appDetailLabel];
            [cell addSubview:_appDetailBtn];
            break;
        case 7:
//            break;
            [self staffInit];
            [cell addSubview:_staffLabel];
            [cell addSubview:_staffBtn];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return  cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}


@end
