//
//  HouseDetailView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/1/31.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "HouseDetailView.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import "PicLoadEnableSharedClass.h"
#import "ViewController.h"
#import "HouseListViewController.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation HouseDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
//            NSLog(@"not nightmode");
//        }else{
//            NSLog(@"is nightmode");
//        }
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        _xiaoqu = @"";
        _topView = [[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.09*SCREEN_HEIGHT)];
        _addCompareBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_addCompareBtn setFrame:CGRectMake(0.5*SCREEN_WIDTH+50, 0.03*SCREEN_HEIGHT, 0.267*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        [_addCompareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_addCompareBtn setTitle:@"加入对比" forState:UIControlStateNormal];
        [_addCompareBtn addTarget:self action:@selector(addCompareObject) forControlEvents:UIControlEventTouchUpInside];
        _addCompareBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _topView.topLabel.text = @"房源详细信息";
        [_addCompareBtn.layer setMasksToBounds:YES];
        [_addCompareBtn.layer setCornerRadius:8.0];
        [_addCompareBtn.layer setBorderWidth:3.0];
        [_addCompareBtn setBackgroundColor:[UIColor whiteColor]];
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref;
        colorref = CGColorCreate(colorSpace, (CGFloat[]){255.0/255.0,0/255.0,0/255.0,1});
        //        CGColorRef colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
        [_addCompareBtn.layer setBorderColor:colorref];
//        [_topView addSubview:_addCompareBtn];
        
        _collectBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_collectBtn setFrame:CGRectMake(0.84*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT, 0.133*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [_collectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_collectBtn addTarget:self action:@selector(updateToDB) forControlEvents:UIControlEventTouchUpInside];
        _collectBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_deleteBtn setFrame:CGRectMake(0.84*SCREEN_WIDTH, 0.03*SCREEN_HEIGHT, 0.133*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteBtn.hidden = YES;
        _deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [_topView addSubview:_deleteBtn];
        [_topView addSubview:_collectBtn];
        [self addSubview:_topView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.053*SCREEN_WIDTH, 0.015*SCREEN_HEIGHT, 0.88*SCREEN_WIDTH, 0.075*SCREEN_HEIGHT)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
        [_titleLabel setNumberOfLines:0];
        
        _publishTime = [[UILabel alloc]initWithFrame:CGRectMake(0.053*SCREEN_WIDTH, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.213*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        _publishTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_publishTime.frame.origin.x+_publishTime.frame.size.width+0.0267*SCREEN_WIDTH, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.533*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        _publishTime.text = @"发布日期";
        _publishTime.textColor = [UIColor whiteColor];
        _publishTime.textAlignment = NSTextAlignmentCenter;
        [_publishTime setBackgroundColor:[UIColor colorWithRed:0 green:189.0/255.0 blue:189.0/255.0 alpha:1]];
        [_publishTime.layer setMasksToBounds:YES];
        [_publishTime.layer setCornerRadius:12.0];
        _publishTime.font = [UIFont systemFontOfSize:15.0];
        _publishTimeLabel.font = [UIFont systemFontOfSize:15.0];
        [_publishTimeLabel setTextColor:_publishTime.backgroundColor];
        [_publishTimeLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:18.0]];
        
        
        _goToMapBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _goToMapBtn.frame = CGRectMake( 0.653*SCREEN_WIDTH, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.32*SCREEN_WIDTH,  0.045*SCREEN_HEIGHT);
        _goToMapBtn.backgroundColor = [UIColor orangeColor];
        [_goToMapBtn setTitle:@"在地图中显示" forState:UIControlStateNormal];
        [_goToMapBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _goToMapBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
        [_goToMapBtn.layer setMasksToBounds:YES];
        [_goToMapBtn.layer setCornerRadius:12.0];
        [_goToMapBtn addTarget:self action:@selector(goToMap) forControlEvents:UIControlEventTouchUpInside];
        
        _houseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.107*SCREEN_WIDTH, _publishTimeLabel.frame.origin.y+_publishTimeLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.747*SCREEN_WIDTH, 0.3*SCREEN_HEIGHT)];
        [_houseImageView setImage:[UIImage imageNamed:@"pic_nil.jpg"]];
        
        _imageScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.107*SCREEN_WIDTH, _publishTimeLabel.frame.origin.y+_publishTimeLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.747*SCREEN_WIDTH, 0.3*SCREEN_HEIGHT)];
        _imageScrollView.showsHorizontalScrollIndicator = NO;
        _imageScrollView.pagingEnabled = YES;
        _imageScrollView.bounces = NO;
        
        _price = [[UILabel alloc]initWithFrame:CGRectMake(0.0533*SCREEN_WIDTH, _houseImageView.frame.origin.y+_houseImageView.frame.size.height+0.015*SCREEN_HEIGHT, 0.267*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(_price.frame.size.width+_price.frame.origin.x+0.0267*SCREEN_WIDTH, _houseImageView.frame.origin.y+_houseImageView.frame.size.height+0.015*SCREEN_HEIGHT, 0.8*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _price.text = @"租金(元/月)";
        _price.textColor = [UIColor whiteColor];
        _price.textAlignment = NSTextAlignmentCenter;
        [_price setBackgroundColor:[UIColor orangeColor]];
        [_price.layer setMasksToBounds:YES];
        [_price.layer setCornerRadius:15.0];
        [_priceLabel setTextColor:_price.backgroundColor];
        [_priceLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:18.0]];
        
        _type = [[UILabel alloc]initWithFrame:CGRectMake(0.0533*SCREEN_WIDTH, _priceLabel.frame.origin.y+_priceLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.16*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(_type.frame.size.width+_type.frame.origin.x+0.0267*SCREEN_WIDTH, _priceLabel.frame.origin.y+_priceLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.88*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _type.text = @"户型";
        _type.textColor = [UIColor whiteColor];
        _type.textAlignment = NSTextAlignmentCenter;
        [_type setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:173.0/255.0 blue:37.0/255.0 alpha:1]];
        [_type.layer setMasksToBounds:YES];
        [_type.layer setCornerRadius:15.0];
        [_typeLabel setTextColor:_type.backgroundColor];
        [_typeLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:18.0]];
        
        _config = [[UILabel alloc]initWithFrame:CGRectMake(0.0533*SCREEN_WIDTH, _typeLabel.frame.origin.y+_typeLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.16*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _configLabel = [[UILabel alloc]initWithFrame:CGRectMake(_config.frame.size.width+_config.frame.origin.x+0.0267*SCREEN_WIDTH, _typeLabel.frame.origin.y+_typeLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.747*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _config.text = @"配置";
        _config.textColor = [UIColor whiteColor];
        _config.textAlignment = NSTextAlignmentCenter;
        [_config setBackgroundColor:[UIColor purpleColor]];
        [_config.layer setMasksToBounds:YES];
        [_config.layer setCornerRadius:15.0];
        [_configLabel setNumberOfLines:0];
        [_configLabel setTextColor:_config.backgroundColor];
        [_configLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:18.0]];
        
        _address = [[UILabel alloc]initWithFrame:CGRectMake(0.0533*SCREEN_WIDTH, _configLabel.frame.origin.y+_configLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.16*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_address.frame.size.width+_address.frame.origin.x+0.0267*SCREEN_WIDTH, _configLabel.frame.origin.y+_configLabel.frame.size.height+0.0225*SCREEN_HEIGHT, 0.747*SCREEN_WIDTH, 0.075*SCREEN_HEIGHT)];
        _address.text = @"地址";
        _address.textColor = [UIColor whiteColor];
        _address.textAlignment = NSTextAlignmentCenter;
        [_address setBackgroundColor:[UIColor brownColor]];
        [_address.layer setMasksToBounds:YES];
        [_address.layer setCornerRadius:15.0];
        [_addressLabel setNumberOfLines:0];
        [_addressLabel setTextColor:_address.backgroundColor];
        [_addressLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:18.0]];
        
        _brokerName = [[UILabel alloc]initWithFrame:CGRectMake(0.0533*SCREEN_WIDTH, _addressLabel.frame.origin.y+_addressLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.16*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _brokerNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_brokerName.frame.size.width+_brokerName.frame.origin.x+0.0267*SCREEN_WIDTH, _addressLabel.frame.origin.y+_addressLabel.frame.size.height+0.0225*SCREEN_HEIGHT, 0.747*SCREEN_WIDTH, 0.075*SCREEN_HEIGHT)];
        _brokerName.text = @"经纪人";
        _brokerName.textColor = [UIColor whiteColor];
        _brokerName.textAlignment = NSTextAlignmentCenter;
        [_brokerName setBackgroundColor:[UIColor darkGrayColor]];
        [_brokerName.layer setMasksToBounds:YES];
        [_brokerName.layer setCornerRadius:15.0];
        [_brokerNameLabel setNumberOfLines:0];
        [_brokerNameLabel setTextColor:_brokerName.backgroundColor];
        [_brokerNameLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:18.0]];
        
        _brokerTel = [[UILabel alloc]initWithFrame:CGRectMake(0.0533*SCREEN_WIDTH, _addressLabel.frame.origin.y+_addressLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.16*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _brokerTelLabel = [[UILabel alloc]initWithFrame:CGRectMake(_brokerTel.frame.size.width+_brokerTel.frame.origin.x+0.0267*SCREEN_WIDTH, _brokerNameLabel.frame.origin.y+_brokerNameLabel.frame.size.height+0.0225*SCREEN_HEIGHT, 0.747*SCREEN_WIDTH, 0.075*SCREEN_HEIGHT)];
        _brokerTel.text = @"手机";
        _brokerTel.textColor = [UIColor whiteColor];
        _brokerTel.textAlignment = NSTextAlignmentCenter;
        [_brokerTel setBackgroundColor:[UIColor darkGrayColor]];
        [_brokerTel.layer setMasksToBounds:YES];
        [_brokerTel.layer setCornerRadius:15.0];
        [_brokerTelLabel setNumberOfLines:0];
        [_brokerTelLabel setTextColor:_brokerTel.backgroundColor];
        [_brokerTelLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:18.0]];
        
        _house_description = [[UILabel alloc]initWithFrame:CGRectMake(0.0533*SCREEN_WIDTH, _brokerTelLabel.frame.origin.y+_brokerTelLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.16*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _descriptionLabel = [[UILabel alloc]initWithFrame:CGRectMake(_house_description.frame.size.width+_house_description.frame.origin.x+0.0267*SCREEN_WIDTH, _brokerTelLabel.frame.origin.y+_brokerTelLabel.frame.size.height+0.015*SCREEN_HEIGHT, 0.747*SCREEN_WIDTH, 0.225*SCREEN_HEIGHT)];
        _house_description.text = @"描述";
        _house_description.textColor = [UIColor whiteColor];
        _house_description.textAlignment = NSTextAlignmentCenter;
        [_house_description setBackgroundColor:[UIColor colorWithRed:0/255.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0]];
        [_house_description.layer setMasksToBounds:YES];
        [_house_description.layer setCornerRadius:15.0];
        [_descriptionLabel setNumberOfLines:0];
        [_descriptionLabel setFont:[UIFont fontWithName:@"HiraKakuProN-W6" size:18.0]];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0.09*SCREEN_HEIGHT, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, _descriptionLabel.frame.origin.y+_descriptionLabel.frame.size.height+0.015*SCREEN_HEIGHT);
        [_scrollView addSubview:_titleLabel];
        [_scrollView addSubview:_publishTime];
        [_scrollView addSubview:_publishTimeLabel];
        [_scrollView addSubview:_goToMapBtn];
        [_scrollView addSubview:_price];
        [_scrollView addSubview:_priceLabel];
        [_scrollView addSubview:_type];
        [_scrollView addSubview:_typeLabel];
        [_scrollView addSubview:_config];
        [_scrollView addSubview:_configLabel];
        [_scrollView addSubview:_address];
        [_scrollView addSubview:_addressLabel];
        [_scrollView addSubview:_brokerName];
        [_scrollView addSubview:_brokerNameLabel];
        [_scrollView addSubview:_brokerTel];
        [_scrollView addSubview:_brokerTelLabel];
        [_scrollView addSubview:_house_description];
        [_scrollView addSubview:_descriptionLabel];
        [self addSubview:_scrollView];
        
    }
    
    return self;
}

- (void)transTitle:(NSString*)title price:(NSString*)price type:(NSString*)type config:(NSString*)config description:(NSString*)description address:(NSString*)address publishTime:(NSString *)publishTime imageURL:(id)imageURL broker_name:(NSString*)broker_name broker_tel:(NSString*)broker_tel xiaoqu:(NSString *)xiaoqu
{
    //    NSLog(@"title is %@",title);
    
    _xiaoqu = xiaoqu;
    NSLog(@"xiaoqu is %@",xiaoqu);
    NSLog(@"trans xiaoqu is %@",_xiaoqu);
    _imageURL = imageURL;
    
    int a;
    if ([PicLoadEnableSharedClass newInstance].WWANLoadPicEnabled == YES) {
        if ([imageURL isKindOfClass:[NSString class]]) {
            [_scrollView addSubview:_houseImageView];
            a = 1;
        }else if ([imageURL isKindOfClass:[NSArray class]])
        {
            NSArray *array = imageURL;
            if ([array firstObject] == nil) {
                [_scrollView addSubview:_houseImageView];
                a = 1;
            }else{
                for (int i = 0; i < array.count; i++) {
                    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.747*SCREEN_WIDTH*i, 0, 0.747*SCREEN_WIDTH, 0.3*SCREEN_HEIGHT)];
                    [imageView sd_setImageWithURL:[NSURL URLWithString:[array objectAtIndex:i]]];
                    [_imageScrollView addSubview:imageView];
                    
                }
                [_imageScrollView setContentSize:CGSizeMake(0.747*SCREEN_WIDTH*array.count, 0.3*SCREEN_HEIGHT)];
                [_scrollView addSubview:_imageScrollView];
                a = 2;
            }
        }
    }else{
        [_scrollView addSubview:_houseImageView];
        a = 1;
    }
//    [_houseImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
    _titleLabel.text = title;
    _priceLabel.text = price;
    _typeLabel.text = type;
    _configLabel.text = config;
    _descriptionLabel.text = description;
    _addressLabel.text = address;
    _publishTimeLabel.text = publishTime;
    _brokerNameLabel.text = broker_name;
    _brokerTelLabel.text = broker_tel;
    
    [_titleLabel sizeToFit];
    CGRect rectT = _titleLabel.frame;
    rectT.size.width = 0.88*SCREEN_WIDTH;
    _titleLabel.frame = rectT;
    
    [self adjustY:_publishTime upLabel:_titleLabel];
    
    [self adjustY:_publishTimeLabel upLabel:_titleLabel];
    [self adjustY:_goToMapBtn upLabel:_titleLabel];
    
    if (a==1) {
        [self adjustY:_houseImageView upLabel:_publishTimeLabel];
        [self adjustY:_priceLabel upLabel:_houseImageView];
        [self adjustY:_price upLabel:_houseImageView];
        
        [self adjustY:_addCompareBtn upLabel:_houseImageView];
        [_scrollView addSubview:_addCompareBtn];

    }else if(a==2)
    {
        [self adjustY:_imageScrollView upLabel:_publishTimeLabel];
        [self adjustY:_priceLabel upLabel:_imageScrollView];
        [self adjustY:_price upLabel:_imageScrollView];
        
        [self adjustY:_addCompareBtn upLabel:_imageScrollView];
//        NSLog(@"y is %d",(int)_addCompareBtn.frame.origin.y);
        [_scrollView addSubview:_addCompareBtn];

    }
    
    
    
    [self adjustY:_type upLabel:_priceLabel];
    [self adjustY:_typeLabel upLabel:_priceLabel];
    [self adjustY:_config upLabel:_typeLabel];
    [self adjustY:_configLabel upLabel:_typeLabel];
    [_configLabel sizeToFit];
    CGRect rectC = _configLabel.frame;
    rectC.size.width = 0.747*SCREEN_WIDTH;
    _configLabel.frame = rectC;
    _config.center = CGPointMake(_config.center.x, _configLabel.center.y);

    [self adjustY:_address upLabel:_configLabel];
    [self adjustY:_addressLabel upLabel:_configLabel];
    [_addressLabel sizeToFit];
    CGRect rectA = _addressLabel.frame;
    rectA.size.width = 0.747*SCREEN_WIDTH;
    _addressLabel.frame = rectA;
    _address.center = CGPointMake(_address.center.x, _addressLabel.center.y);
    
    [self adjustLightY:_brokerName upLabel:_addressLabel];
    [self adjustLightY:_brokerNameLabel upLabel:_addressLabel];
    _brokerName.center = CGPointMake(_brokerName.center.x, _brokerNameLabel.center.y);
    
    [self adjustLightY:_brokerTel upLabel:_brokerNameLabel];
    [self adjustLightY:_brokerTelLabel upLabel:_brokerNameLabel];
    _brokerTel.center = CGPointMake(_brokerTel.center.x, _brokerTelLabel.center.y);

    [self adjustY:_house_description upLabel:_brokerTelLabel];
    [self adjustY:_descriptionLabel upLabel:_brokerTelLabel];
    [_descriptionLabel sizeToFit];
    CGRect rectU=_descriptionLabel.frame;
    rectU.size.width=0.747*SCREEN_WIDTH;
    _descriptionLabel.frame=rectU;
    _house_description.center = CGPointMake(_house_description.center.x, _descriptionLabel.center.y);
    
    _scrollView.contentSize=CGSizeMake(0.88*SCREEN_WIDTH,_descriptionLabel.frame.size.height+_descriptionLabel.frame.origin.y+0.03*SCREEN_HEIGHT);
}

- (void)adjustX:(UIView *)rightLabel leftLabel:(UIView *)leftLabel
{
    [rightLabel setFrame:CGRectMake(leftLabel.frame.origin.x+leftLabel.frame.size.width, rightLabel.frame.origin.y, rightLabel.frame.size.width, rightLabel.frame.size.height)];
    NSLog(@"orgin.x is %d",(int)rightLabel.frame.origin.x);
//    NSLog(@"orgin.x is %d",(int)rightLabel.frame.origin.x);
    
}

- (void)adjustY:(UIView *)downLabel upLabel:(UIView *)upLabel
{
    [downLabel setFrame:CGRectMake(downLabel.frame.origin.x, upLabel.frame.origin.y+upLabel.frame.size.height+0.03*SCREEN_HEIGHT, downLabel.frame.size.width, downLabel.frame.size.height)];
}

- (void)adjustLightY:(UIView *)downLabel upLabel:(UIView *)upLabel
{
    [downLabel setFrame:CGRectMake(downLabel.frame.origin.x, upLabel.frame.origin.y+upLabel.frame.size.height+0.01*SCREEN_HEIGHT, downLabel.frame.size.width, downLabel.frame.size.height)];
}

- (void)updateToDB
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;

    int No;
    NSEntityDescription *house = [NSEntityDescription entityForName:@"HouseEntity" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:house];
    
    NSArray *houseArray= [context executeFetchRequest:request error:nil];
    if (houseArray.count>0) {
        No = (int)houseArray.count;
    }else{
        No = 0;
    }

    NSManagedObject *houseObj = [NSEntityDescription insertNewObjectForEntityForName:@"HouseEntity" inManagedObjectContext:context];
    [houseObj setValue:_titleLabel.text forKey:@"title_detail"];
    [houseObj setValue:_priceLabel.text forKey:@"price"];
    [houseObj setValue:_configLabel.text forKey:@"config"];
    [houseObj setValue:[NSNumber numberWithInt:No] forKey:@"id"];
    [houseObj setValue:_publishTimeLabel.text forKey:@"publish_time"];
    [houseObj setValue:_typeLabel.text forKey:@"house_type"];
    [houseObj setValue:_descriptionLabel.text forKey:@"house_description"];
    [houseObj setValue:_addressLabel.text forKey:@"address"];
    [houseObj setValue:_imageURL forKey:@"pic_urls"];
    [houseObj setValue:_brokerNameLabel.text forKey:@"broker_name"];
    [houseObj setValue:_brokerTelLabel.text forKey:@"broker_tel"];
    [houseObj setValue:_xiaoqu forKey:@"xiaoqu"];

    NSError *error;
    if ([context save:&error]) {
        NSLog(@"save ok");
    }else{
        NSLog(@"error:%@",error);
    }

    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加收藏" message:@"收藏成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

- (void)goToMap
{
    NSLog(@"map");

    ViewController *view  = (ViewController*)[ViewController shareViewController];
    [view buttonClick:0];
    [view.segmentView updateSegmentStates:0];
    [view.mapView removeAnnotations:view.mapView.annotations];
    [view searchExcute:_xiaoqu city:@"北京" title:_titleLabel.text price:_priceLabel.text brokerName:_brokerNameLabel.text brokerTel:_brokerTelLabel.text publishTime:_publishTimeLabel.text description:_descriptionLabel.text config:_configLabel.text type:_typeLabel.text address:_addressLabel.text];
}

- (void)addCompareObject
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    int No;
    NSEntityDescription *house = [NSEntityDescription entityForName:@"CompareEntity" inManagedObjectContext:context];
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:house];
    
    NSArray *houseArray= [context executeFetchRequest:request error:nil];
    if (houseArray.count>0) {
        No = (int)houseArray.count;
    }else{
        No = 0;
    }
    NSString *image;
    if ([_imageURL isKindOfClass:[NSString class]]) {
        image = _imageURL;
    }else if ([_imageURL isKindOfClass:[NSArray class]])
    {
        NSArray *array = _imageURL;
        if ([array firstObject] == nil) {
            image = @"暂无数据";
        }else{
            image = [array firstObject];
        }
    
    }
            
    NSManagedObject *houseObj = [NSEntityDescription insertNewObjectForEntityForName:@"CompareEntity" inManagedObjectContext:context];
    [houseObj setValue:_priceLabel.text forKey:@"price"];
    [houseObj setValue:_typeLabel.text forKey:@"house_type"];
    [houseObj setValue:image forKey:@"pic_url"];
    [houseObj setValue:_xiaoqu forKey:@"xiaoqu"];
    
    NSError *error;
    if ([context save:&error]) {
        NSLog(@"save ok");
    }else{
        NSLog(@"error:%@",error);
    }
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"添加对比" message:@"添加成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    

}
@end
