//
//  ViewController.m
//  AMapDemo
//
//  Created by yrq_mac on 16/1/22.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "HouseListViewController.h"
#import "HouseDetailView.h"
#import "RadarSearchToolsView.h"
#import "ExactSearchToolsView.h"
#import "HouseAnnotationView.h"
#import "AFNetworking.h"
#import "Reachability.h"
#import "PicLoadEnableSharedClass.h"
#import "ListButtonView.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
#define poiArrayCount 100
#define radius_meter 6000
@interface ViewController ()
{
    BOOL isFirstTimerRun;
    float progressForeRatio;
    float progressLaterRatio;
    
    BOOL esOn;
    BOOL rsOn;
    //ds = detailSearch
    BOOL dsOn;

    BOOL trafficEnable;
    BOOL typeChange;
    
    BOOL rsViewOut;
    BOOL esViewOut;
    BOOL pcotViewOut;
    
    int tappedNumber;
    CLLocationCoordinate2D userLocation;
    CLLocationCoordinate2D internalOptionLocation[poiArrayCount];
    CLLocationCoordinate2D esSearchLocation[poiArrayCount];
    MAPolyline *polyLine;
    MACircle *circle;
    AMapPOIKeywordsSearchRequest *poiArray[poiArrayCount];
    AMapPOIKeywordsSearchRequest *poiEsArray[poiArrayCount];
    MAUserLocation *user;
    MAPointAnnotation *poiUserAnnotation;
    MAPointAnnotation *poiA;
    MAPointAnnotation *tappedAnnotation;
    NSString *locationTitle;
    int Radius_distance;
    int SearchTimes;
    int rsSearchResultCount;
    int EsSearchResultCount;
//    CGFloat RotateAngle;
    CGFloat ScaleInitY;
    
    NSDictionary *dicList[poiArrayCount];
    NSMutableArray *insideHouseArray;
    NSMutableArray *insidePointArray;
    
    NSDictionary *dicEsList[poiArrayCount];
    NSMutableArray *EsHouseArray;
    NSMutableArray *EsPointArray;

    NSMutableDictionary *DetailHouseDic;
}
@end

@implementation ViewController

static  ViewController  *VC;

+(id)shareViewController
{
    if (VC==nil)
    {
        VC = [[ViewController alloc]init];
    }
    return VC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.isSearch =NO;
    isFirstTimerRun = YES;
    progressForeRatio = 0.0;
    progressLaterRatio = 0.0;
    [PicLoadEnableSharedClass newInstance];
    
    if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
        NSLog(@"not nightmode");
    }else{
        NSLog(@"is nightmode");
    }
    
    [self mapInit];
    
    [self mainViewControlInit];
    
    [self searchInit];
    
    [self trafficAndTypeBtnInit];
    
    [self nightMode];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [self mapInit];
}

#pragma mark - Init
- (void)searchInit
{
    _search = [[AMapSearchAPI alloc]init];
    _search.delegate = self;
    
    _poiRequest = [[AMapPOIKeywordsSearchRequest alloc]init];
}


- (void)mapInit
{
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0.09*SCREEN_HEIGHT, SCREEN_WIDTH, 0.82*SCREEN_HEIGHT)];
//    NSLog(@"width is %f,height is %f",CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    _mapView.delegate = self;
//    NSLog(@"%f",_mapView.zoomLevel);
//    NSLog(@"latitude:%f longitude:%f",_mapView.centerCoordinate.latitude,_mapView.centerCoordinate.longitude);
    //    卫星图
    //    _mapView.mapType = MAMapTypeSatellite;
    
    //    实施交通图
    //    _mapView.showTraffic = YES;
    
    _mapView.logoCenter = CGPointMake(0.85*SCREEN_WIDTH, 0.82*SCREEN_HEIGHT);
    
    
    [self.view addSubview:_mapView];
    poiA = [[MAPointAnnotation alloc]init];
    poiUserAnnotation = [[MAPointAnnotation alloc]init];
    
    _userLocationManager = [[CLLocationManager alloc]init];
    _userLocationManager.delegate = self;
    locationTitle = @"当前位置";
    
    [_userLocationManager requestAlwaysAuthorization];
    ScaleInitY = _mapView.scaleOrigin.y;
    
    
}

- (void)mainViewControlInit
{
    _listButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _listButton.frame = CGRectMake(0, SCREEN_HEIGHT*0.015, SCREEN_WIDTH*0.277, SCREEN_HEIGHT*0.09);
    [_listButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_listButton setTitle:@"房源列表" forState:UIControlStateNormal];
    [_listButton addTarget:self action:@selector(ListlView) forControlEvents:UIControlEventTouchUpInside];
    _listButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [_listButton.layer setMasksToBounds:YES];
    [_listButton.layer setCornerRadius:8.0];
    [_listButton.layer setBorderWidth:5.0];
    [_listButton.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor blueColor])];
    //    [self.view addSubview:_listButton];
    
    _radarSearchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _radarSearchButton.frame = CGRectMake(_listButton.frame.size.width+_listButton.frame.origin.x+SCREEN_WIDTH*0.08, SCREEN_HEIGHT*0.015, SCREEN_WIDTH*0.277, SCREEN_HEIGHT*0.09);
    [_radarSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_radarSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_radarSearchButton setTitle:@"雷达搜索" forState:UIControlStateNormal];
    [_radarSearchButton addTarget:self action:@selector(RadarSearch) forControlEvents:UIControlEventTouchUpInside];
    _radarSearchButton.titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
    [_radarSearchButton.layer setMasksToBounds:YES];
    [_radarSearchButton.layer setCornerRadius:8.0];
    [_radarSearchButton.layer setBorderWidth:1.0];
    [_radarSearchButton.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor blueColor])];
    //    [self.view addSubview:_radarSearchButton];
    
    _exactSearchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _exactSearchButton.frame = CGRectMake(_radarSearchButton.frame.size.width+_radarSearchButton.frame.origin.x+SCREEN_WIDTH*0.08, SCREEN_HEIGHT*0.015, SCREEN_WIDTH*0.277, SCREEN_HEIGHT*0.09);
    [_exactSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_exactSearchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [_exactSearchButton setTitle:@"条件搜索" forState:UIControlStateNormal];
    [_exactSearchButton addTarget:self action:@selector(ExactSearch) forControlEvents:UIControlEventTouchUpInside];
    _exactSearchButton.titleLabel.font = [UIFont boldSystemFontOfSize:18.0];
    [_exactSearchButton.layer setMasksToBounds:YES];
    [_exactSearchButton.layer setCornerRadius:8.0];
    [_exactSearchButton.layer setBorderWidth:1.0];
    [_exactSearchButton.layer setBorderColor:(__bridge CGColorRef _Nullable)([UIColor blueColor])];
    //    [self.view addSubview:_exactSearchButton];
    
    _topView = [[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT*0.09)];
    _topView.returnButton.hidden = YES;
    [_topView addSubview:_listButton];
    [_topView addSubview:_radarSearchButton];
    [_topView addSubview:_exactSearchButton];
    
    
    esViewOut = NO;
    _esView = [[ExactSearchToolsView alloc]init];
    [_esView.detailButton addTarget:self action:@selector(detailSearchExcute) forControlEvents:UIControlEventTouchUpInside];
    [_esView.shiBtn addTarget:self action:@selector(ListButtonInit:) forControlEvents:UIControlEventTouchUpInside];
    [_esView.tingBtn addTarget:self action:@selector(ListButtonInit:) forControlEvents:UIControlEventTouchUpInside];
    [_esView.weiBtn addTarget:self action:@selector(ListButtonInit:) forControlEvents:UIControlEventTouchUpInside];
    _listBtnView = [[ListButtonView alloc]initWithFrame:CGRectMake(0.187*SCREEN_WIDTH, _esView.shiBtn.frame.origin.y+_esView.shiBtn.frame.size.height+_topView.frame.size.height, 0.08*SCREEN_WIDTH, 3*0.045*SCREEN_HEIGHT)];
    
    rsViewOut = YES;
//    _rsView = [[RadarSearchToolsView alloc]init];
    _rsView = [[RadarSearchToolsView alloc]init];
    _rsView.frame = CGRectMake(0,0.09*SCREEN_HEIGHT, SCREEN_WIDTH, _rsView.locationBtn.frame.size.height+0.03*SCREEN_HEIGHT);
    [_rsView.locationBtn addTarget:self action:@selector(LocationExcute) forControlEvents:UIControlEventTouchUpInside];
    [_rsView.searchBtn addTarget:self action:@selector(radarSearchExcute) forControlEvents:UIControlEventTouchUpInside];
    _rsView.radiusTF.delegate = self;
    
    NSLog(@"height is %f",_rsView.frame.size.height);
    [self moveScaleAndCompass:_rsView.frame.size.height];
    [_radarSearchButton setSelected:YES];
    [self.view addSubview:_rsView];
   
//    NSLog(@"thanks");
//    _rsView.radiusTF.text = @"6000";
    //    [self.view addSubview:_toolView];
    [self.view addSubview:_topView];
    
    pcotViewOut = NO;
    _pcotView = [[PinCallOutTappedView alloc]init];
    [_pcotView.goBtn addTarget:self action:@selector(RouteSeachExcute) forControlEvents:UIControlEventTouchUpInside];
    [_pcotView.detailBtn addTarget:self action:@selector(detailViewExcute) forControlEvents:UIControlEventTouchUpInside];
    
    _segmentView = [[SegmentView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.91, SCREEN_WIDTH, SCREEN_HEIGHT*0.09)];
    [_segmentView updateSegmentStates:0];
    _segmentView.myDelegate = self;
    [self.view addSubview:_segmentView];
    
    insideHouseArray = [[NSMutableArray alloc]init];
    insidePointArray = [[NSMutableArray alloc]init];
    
    EsHouseArray = [[NSMutableArray alloc]init];
    EsPointArray = [[NSMutableArray alloc]init];
    
    DetailHouseDic = [[NSMutableDictionary alloc]init];
    
    SearchTimes = 0;
    esOn = NO;
    rsOn = NO;
    
}


- (void)trafficAndTypeBtnInit
{
    
    _trafficBtn = [QQButton buttonWithType:UIButtonTypeCustom];
    [_trafficBtn setFrame:CGRectMake(0.833*SCREEN_WIDTH, 0.425*SCREEN_HEIGHT,0.15*SCREEN_WIDTH, 0.15*SCREEN_WIDTH)];
    [_trafficBtn setTitle:@"交通" forState:UIControlStateNormal];
    _trafficBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_trafficBtn addTarget:self action:@selector(showTraffic) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_trafficBtn];
    
    
    _mapTypeBtn = [QQButton buttonWithType:UIButtonTypeCustom];
    [_mapTypeBtn setFrame:CGRectMake(0.833*SCREEN_WIDTH, 0.535*SCREEN_HEIGHT, 0.15*SCREEN_WIDTH, 0.15*SCREEN_WIDTH)];
    [_mapTypeBtn setTitle:@"类型" forState:UIControlStateNormal];
    _mapTypeBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_mapTypeBtn addTarget:self action:@selector(changeMapType) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_mapTypeBtn];
    
    _rsProgress = [[ZFProgressView alloc] initWithFrame:CGRectMake(0.367*SCREEN_WIDTH, 0.425*SCREEN_HEIGHT, 0.267*SCREEN_WIDTH, 0.15*SCREEN_HEIGHT)];
    _rsProgress.innerBackgroundColor = [UIColor clearColor];
    _rsProgress.backgroundStrokeColor = [UIColor whiteColor];
    _rsProgress.digitTintColor = [UIColor orangeColor];
    _rsProgress.progressStrokeColor = [UIColor orangeColor];
    [_rsProgress setProgress:0 Animated:NO];
    
}

- (void)nightMode
{
    if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
//        NSLog(@"not nightmode");
        _topView.backgroundColor = [UIColor colorWithRed:0/255.0 green:191.0/255.0 blue:255.0/255.0 alpha:1.0];
    }else{
//        NSLog(@"is nightmode");
        _topView.backgroundColor = [UIColor colorWithRed:25.0/255.0 green:25.0/255.0 blue:112.0/255.0 alpha:1];
    }
}


- (void)showTraffic
{
    if (trafficEnable == NO) {
        _mapView.showTraffic = YES;
        trafficEnable = YES;
    }else{
        _mapView.showTraffic = NO;
        trafficEnable = NO;
    }

}


- (void)changeMapType
{
    if (typeChange == NO) {
        _mapView.mapType = MAMapTypeSatellite;
        typeChange = YES;
    }else{
        _mapView.mapType = MAMapTypeStandard;
        typeChange = NO;
    }
}


#pragma mark - LocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"UpdateLocationMessage");
    
    poiUserAnnotation.coordinate = CLLocationCoordinate2DMake(0, 0);
    [_mapView removeAnnotations:_mapView.annotations];
    [_mapView removeOverlays:_mapView.overlays];
    [_mapView removeAnnotation:poiUserAnnotation];
    
    CLLocation *location = [locations lastObject];
    
    if (poiUserAnnotation.coordinate.longitude == 0) {
        poiUserAnnotation.coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
//        NSLog(@"%f %f",location.coordinate.latitude,location.coordinate.longitude);
        poiUserAnnotation.title = locationTitle;
//        poiUserAnnotation.subtitle = @"2";
        [_mapView addAnnotation:poiUserAnnotation];
        _mapView.centerCoordinate = poiUserAnnotation.coordinate;
        [_userLocationManager stopUpdatingLocation];
    }
    
    
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);

}


#pragma mark - SearchExcute
- (void)searchExcute:(NSString*)keyword city:(NSString*)city title:(NSString*)title price:(NSString*)price brokerName:(NSString*)brokerName brokerTel:(NSString*)brokerTel publishTime:(NSString*)publishTime description:(NSString*)description config:(NSString*)config type:(NSString*)type address:(NSString*)address
{
    [DetailHouseDic setObject:keyword forKey:@"xiaoqu"];
    [DetailHouseDic setObject:title forKey:@"title_detail"];
    [DetailHouseDic setObject:price forKey:@"price_detail"];
    [DetailHouseDic setObject:brokerName forKey:@"broker_name"];
    [DetailHouseDic setObject:brokerTel forKey:@"broker_tel"];
    [DetailHouseDic setObject:publishTime forKey:@"publish_time"];
    [DetailHouseDic setObject:description forKey:@"description"];
    [DetailHouseDic setObject:config forKey:@"config"];
    [DetailHouseDic setObject:type forKey:@"house_type"];
    [DetailHouseDic setObject:address forKey:@"address"];

    dsOn = YES;
    AMapPOIKeywordsSearchRequest *poiRequest = [[AMapPOIKeywordsSearchRequest alloc]init];
    poiRequest.keywords            = keyword;

    poiRequest.city                = city;
//    poiRequest.types               = @"餐饮服务";
    poiRequest.requireExtension    = YES;
    poiRequest.cityLimit           = YES;
    poiRequest.requireSubPOIs      = YES;
    [_search AMapPOIKeywordsSearch:poiRequest];
}


#pragma mark - TopViewMethod
- (void)ListlView
{
    HouseListViewController *list = [[HouseListViewController alloc]init];
    [self presentViewController:list animated:YES completion:nil];
//    NSLog(@"Enter ListView");
}

- (void)ExactSearch
{
    
    if (esViewOut == NO) {
        
        if (rsViewOut == YES) {
            
            [_radarSearchButton setSelected:NO];
            [_rsView.radiusTF resignFirstResponder];
            [self rsViewFadeOut];
        }
//        [NSThread sleepForTimeInterval:1.0f];
        
        [self.view addSubview:_esView];
        
        esViewOut = YES;
        [self changeSearchToolColor];
        
        [self esViewFadeIn];
        [self moveScaleAndCompass:_esView.frame.size.height];
        poiUserAnnotation.coordinate = CLLocationCoordinate2DMake(0, 0);
         [_mapView removeAnnotations:_mapView.annotations];
//        NSLog(@"annotations %d",(int)_mapView.annotations.count);
        [_mapView removeAnnotation:poiUserAnnotation];
        NSLog(@"%f %f",poiUserAnnotation.coordinate.longitude,poiUserAnnotation.coordinate.latitude);
        if (polyLine!=nil) {
            for (id overlay in _mapView.overlays) {
                if ([overlay isKindOfClass:[MAPolyline class]]) {
                    [_mapView removeOverlay:overlay];
                }
            }
        }
        
        if (circle!=nil) {
            for (id overlay in _mapView.overlays) {
                if ([overlay isKindOfClass:[MACircle class]]) {
                    [_mapView removeOverlay:overlay];
                }
            }
        }
        
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.911477, 116.405272);
        _mapView.zoomLevel = 10.145280;
        
        [_exactSearchButton setSelected:YES];
        
//        if (_rsProgress) {
//            [_rsProgress removeFromSuperview];
//        }
        

    }else{
        
        [self esViewFadeOut];
        [self moveScaleAndCompass:ScaleInitY];
        
        [_exactSearchButton setSelected:NO];
        [_esView.priceTF resignFirstResponder];
        
        if (_shiListOut == 1) {
            [_listBtnView removeFromSuperview];
             _shiListOut = 0;
        }
           
    }
    
}


- (void)RadarSearch
{
    
//    NSLog(@"radar search");
//    _mapView.showsUserLocation = YES;
//    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
//    [_mapView setZoomLevel:16.1 animated:YES];
    
    if (rsViewOut == NO) {
        if (esViewOut == YES) {
            [_exactSearchButton setSelected:NO];
            [_esView.priceTF resignFirstResponder];
            if (_shiListOut == 1) {
                [_listBtnView removeFromSuperview];
                _shiListOut = 0;
            }
            [self esViewFadeOut];
        }
        [self.view addSubview:_rsView];
        
        rsViewOut = YES;
        [self changeSearchToolColor];
        
        [self rsViewFadeIn];
        NSLog(@"%f",(double)_mapView.scaleOrigin.y);
        [self moveScaleAndCompass:_rsView.frame.size.height];
        [_mapView removeAnnotations:_mapView.annotations];
        
        _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.911477, 116.405272);
        _mapView.zoomLevel = 10.145280;
        
        [_radarSearchButton setSelected:YES];
        
    }else{
        
        [self rsViewFadeOut];
        [self moveScaleAndCompass:ScaleInitY];
        
        [_radarSearchButton setSelected:NO];
        [_rsView.radiusTF resignFirstResponder];
    }
    
}

- (void)moveScaleAndCompass:(CGFloat)y
{
    _mapView.scaleOrigin = CGPointMake(_mapView.scaleOrigin.x, y);
    _mapView.compassOrigin = CGPointMake(_mapView.compassOrigin.x, y);
}


#pragma mark - AFNetworking
int poiCount;
- (void)AFN:(int)times
{
    rsOn =YES;
    [_mapTypeBtn setEnabled:NO];
    [_rsProgress setProgress:0 Animated:NO];
    [self.view addSubview:_rsProgress];
    
//    _timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(progressZeroTimer:) userInfo:nil repeats:YES];
//    [_timer fire];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = @"https://house-radar-server.herokuapp.com/list/?count=";
    int a = poiArrayCount;
    NSString *s = [str stringByAppendingString:[NSString stringWithFormat:@"%d",a]];
    NSString *b = [@"&times=" stringByAppendingString:[NSString stringWithFormat:@"%d",SearchTimes]];
    NSLog(@"SearchTimes = %d",SearchTimes+1);
    NSString *c = [s stringByAppendingString:b];
    poiCount = 0;
    [manager GET:c parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        for(NSDictionary *dic in responseObject)
        {
            NSString *xiaoquStr;
            if ([dic[@"xiaoqu"] isKindOfClass:[NSNull class]]) {
                xiaoquStr = @"";
            }else if ([dic[@"xiaoqu"] isKindOfClass:[NSArray class]]) {
                NSArray *array = dic[@"xiaoqu"];
                xiaoquStr = [array lastObject];;
            }else if([dic[@"xiaoqu"] isKindOfClass:[NSString class]]){
                xiaoquStr = dic[@"xiaoqu"];
            }else{
                xiaoquStr = @"";
            }
            
//            NSLog(@"%@",xiaoquStr);
            if (xiaoquStr != nil) {
                if (poiCount==poiArrayCount) {
                    poiCount = 0;
                }
                if (poiArray[poiCount]==NULL) {
                    poiArray[poiCount] = [[AMapPOIKeywordsSearchRequest alloc]init];
                }
                
//                NSLog(@"%@",xiaoquStr);
                dicList[poiCount] = dic;
                poiArray[poiCount].keywords            = xiaoquStr;
                poiArray[poiCount].city                = @"北京";
                poiArray[poiCount].cityLimit           = YES;
                poiArray[poiCount].requireSubPOIs      = YES;
                [_search AMapPOIKeywordsSearch:poiArray[poiCount]];
                poiCount++;
            }
            
//            NSLog(@"poiConut = %d",poiCount);
        }
//        NSLog(@"over");
    } failure:^(NSURLSessionTask *operation, NSError *error) {
//        NSLog(@"%@",error);
        NSString *str = [NSString stringWithString:error.domain];
//        NSLog(@"str:%@",str);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [self enableBtns];
    }];
}


#pragma mark - Animation

- (void)animationDidStart:(CAAnimation *)anim
{
//    NSLog(@"123");
    [self disenableBtns];
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
//    if ([_esView.layer valueForKey:@"fadeInESView"]==anim) {
    if (flag == YES) {
        [self enableBtns];
    }
//    }
//    NSLog(@"des:%@   anim:%@",[anim description],anim);

}

#pragma mark - ESViewMethod
int poiEsCount;
- (void)detailSearchExcute
{
    [self disenableBtns];
//    NSLog(@"detailSearch");
    esOn =YES;
    poiEsCount = 0;
    esLocationNo = 0;
    EsSearchResultCount = 0;
    [_mapView removeAnnotations:_mapView.annotations];
    [_esView.priceTF resignFirstResponder];
    [_esView.shiTF resignFirstResponder];
    [_esView.tingTF resignFirstResponder];
    [_esView.weiTF resignFirstResponder];
    
    [_rsProgress setProgress:0 Animated:NO];
//    [self.view addSubview:_rsProgress];
    [_mapTypeBtn setEnabled:NO];
//    _timer = [NSTimer scheduledTimerWithTimeInterval:8 target:self selector:@selector(progressZeroTimer:) userInfo:nil repeats:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = @"https://house-radar-server.herokuapp.com/hello/";
    
    NSString *price = [@"?price=" stringByAppendingString:_esView.priceTF.text];
    
    NSString *shiNo =  [@"&room=" stringByAppendingString:_esView.shiBtn.titleLabel.text];
    NSString *shiStr = [@"室" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *shi = [shiNo stringByAppendingString:shiStr];
    
    NSString *tingNo =  _esView.tingBtn.titleLabel.text;
    NSString *tingStr = [@"厅" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *ting = [tingNo stringByAppendingString:tingStr];
    
    NSString *weiNo =  _esView.weiBtn.titleLabel.text;
    NSString *weiStr = [@"卫" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    NSString *wei = [weiNo stringByAppendingString:weiStr];
    
    NSString *requestString = [NSString stringWithFormat:@"%@%@%@%@%@",str,price,shi,ting,wei];
    NSLog(@"request is %@",requestString);
    
    [manager GET:requestString parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        for(NSDictionary *dic in responseObject)
        {
            EsSearchResultCount++;
        }
        NSLog(@"dic is %@",responseObject);
        
        for(NSDictionary *dic in responseObject)
        {
//            NSLog(@"%@",dic);
            NSString *xiaoquStr;
            if ([dic[@"xiaoqu"] isKindOfClass:[NSNull class]]) {
                xiaoquStr = @"";
                NSLog(@"is nil");
            }else if ([dic[@"xiaoqu"] isKindOfClass:[NSArray class]]) {
                NSArray *array = dic[@"xiaoqu"];
                xiaoquStr = [array lastObject];;
            }else if([dic[@"xiaoqu"] isKindOfClass:[NSString class]]){
                xiaoquStr = dic[@"xiaoqu"];
            }else{
                xiaoquStr = @"";
                NSLog(@"is nil");
            }
            
//            NSLog(@"%@",xiaoquStr);
            if (xiaoquStr != nil) {
//                NSLog(@"%@",xiaoquStr);
                if (poiEsCount==poiArrayCount) {
                    poiEsCount = 0;
                }
                if (poiEsArray[poiEsCount]==NULL) {
                    poiEsArray[poiEsCount] = [[AMapPOIKeywordsSearchRequest alloc]init];
                }
                //                NSLog(@"%@",xiaoquStr);
//                [dic setValue:xiaoquStr forKey:@"xiaoqu"];
                dicEsList[poiEsCount] = dic;
                poiEsArray[poiEsCount].keywords            = xiaoquStr;
                poiEsArray[poiEsCount].city                = @"北京";
                poiEsArray[poiEsCount].cityLimit           = YES;
                poiEsArray[poiEsCount].requireSubPOIs      = YES;
                [_search AMapPOIKeywordsSearch:poiEsArray[poiEsCount]];
                poiEsCount++;
            }
        }
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSString *str = [NSString stringWithString:error.domain];
        NSLog(@"error is str:%@",error);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        [self enableBtns];
    }];

}

- (void)ListButtonInit:(UIButton*)btn
{
    if (_shiListOut == 0 ) {
        NSLog(@"tag is %d",(int)btn.tag);
        switch ((int)btn.tag) {
            case 91:
                [_listBtnView setFrame:CGRectMake(0.187*SCREEN_WIDTH, _esView.shiBtn.frame.origin.y+_esView.shiBtn.frame.size.height+_topView.frame.size.height, 0.08*SCREEN_WIDTH, 3*0.045*SCREEN_HEIGHT)];
                _ListOutNo = (int)btn.tag;
                break;
            case 92:
                [_listBtnView setFrame:CGRectMake(0.373*SCREEN_WIDTH, _esView.shiBtn.frame.origin.y+_esView.shiBtn.frame.size.height+_topView.frame.size.height, 0.08*SCREEN_WIDTH, 3*0.045*SCREEN_HEIGHT)];
                _ListOutNo = (int)btn.tag;
                break;
            case 93:
                [_listBtnView setFrame:CGRectMake(0.56*SCREEN_WIDTH, _esView.shiBtn.frame.origin.y+_esView.shiBtn.frame.size.height+_topView.frame.size.height, 0.08*SCREEN_WIDTH, 3*0.045*SCREEN_HEIGHT)];
                _ListOutNo = (int)btn.tag;
                break;
        }
        [self.view addSubview:_listBtnView];
        _shiListOut = 1;
    }else{
        [_listBtnView removeFromSuperview];
        if(_ListOutNo == (int)btn.tag){
            _shiListOut = 0;
        }else{
            switch ((int)btn.tag) {
                case 91:
                    [_listBtnView setFrame:CGRectMake(0.187*SCREEN_WIDTH, _esView.shiBtn.frame.origin.y+_esView.shiBtn.frame.size.height+_topView.frame.size.height, 0.08*SCREEN_WIDTH, 3*0.045*SCREEN_HEIGHT)];
                    _ListOutNo = (int)btn.tag;
                    break;
                case 92:
                    [_listBtnView setFrame:CGRectMake(0.373*SCREEN_WIDTH, _esView.shiBtn.frame.origin.y+_esView.shiBtn.frame.size.height+_topView.frame.size.height, 0.08*SCREEN_WIDTH, 3*0.045*SCREEN_HEIGHT)];
                    _ListOutNo = (int)btn.tag;
                    break;
                case 93:
                    [_listBtnView setFrame:CGRectMake(0.56*SCREEN_WIDTH, _esView.shiBtn.frame.origin.y+_esView.shiBtn.frame.size.height+_topView.frame.size.height, 0.08*SCREEN_WIDTH, 3*0.045*SCREEN_HEIGHT)];
                    _ListOutNo = (int)btn.tag;
                    break;
            }
            [self.view addSubview:_listBtnView];
            _shiListOut = 1;
        }
        
    }
}


- (void)esViewFadeIn
{
    _esView.frame = CGRectMake(0,0.09*SCREEN_HEIGHT, SCREEN_WIDTH, _esView.roomLabel.frame.size.height+_esView.roomLabel.frame.origin.y+0.015*SCREEN_HEIGHT);
    CATransition *animation = [CATransition animation];
    [animation setDuration:1];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    animation.delegate = self;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [_esView.layer addAnimation:animation forKey:@"fadeInESView"];
    esViewOut = YES;
}

- (void)esViewFadeOut
{
    _esView.frame = CGRectMake( SCREEN_WIDTH, 0.09*SCREEN_HEIGHT, SCREEN_WIDTH, 0.36*SCREEN_HEIGHT);
    CATransition *animation = [CATransition animation];
    [animation setDuration:1];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    animation.delegate = self;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [_esView.layer addAnimation:animation forKey:@"fadeOutESView"];
    esViewOut = NO;
}

#pragma mark - RSViewMethod
- (void)LocationExcute
{
    NSLog(@"locationExcute");
    if ([CLLocationManager locationServicesEnabled]) {
        NSLog(@"LocationServerEnable");
        if (!_userLocationManager) {
//            NSLog(@"hehe");
        }else{
            [_userLocationManager startUpdatingLocation];
        }
    }else{
//        NSLog(@"sad");
    }

}


- (void)radarSearchExcute
{
//    NSLog(@"radarExcute");
    [self disenableBtns];
    rsSearchResultCount = 0;
    [_rsView.radiusTF resignFirstResponder];
    double radius = _rsView.radiusTF.text.doubleValue;
//    if ((str == nil)||(str == NULL)||([str isKindOfClass:[NSNull class]])) {
    if (radius == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"大哥能不能填个半径" delegate:self cancelButtonTitle:@"收到长官" otherButtonTitles: nil];
        [alert show];
    }else{
        if (poiUserAnnotation.coordinate.latitude == 0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"大哥能不能先定个位" delegate:self cancelButtonTitle:@"收到长官" otherButtonTitles: nil];
            [alert show];

        }else{
            if (circle != nil) {
                [_mapView removeOverlay:circle];
            }
            Radius_distance = _rsView.radiusTF.text.doubleValue;
            circle = [MACircle circleWithCenterCoordinate:poiUserAnnotation.coordinate radius:Radius_distance+300];
            [_mapView addOverlay:circle];
            _mapView.centerCoordinate = poiUserAnnotation.coordinate;
            [self distanceToZoomLevel:Radius_distance];
            [self AFN:0];
        }
    }
}

- (void)distanceToZoomLevel:(double)radius
{
    double zoomLevel;
    double ra = radius/1000.0;
    if (ra<2) {
        zoomLevel = 15.0 -ra;
    }else if(ra<4){
        zoomLevel = 14.0 - 0.5*ra;
    }else if(ra<7){
        zoomLevel = 13.333 - 0.333*ra;
    }else if(ra<11){
        zoomLevel = 12.75 - 0.25*ra;
    }else{
        zoomLevel = 9;
    }
    [_mapView setZoomLevel:zoomLevel];
}

//-(void)mapView:(MAMapView *)mapView mapDidZoomByUser:(BOOL)wasUserAction
//{
//    NSLog(@"%f",_mapView.zoomLevel);
//
//}

- (void)rsViewFadeIn
{
    _rsView.frame = CGRectMake(0,0.09*SCREEN_HEIGHT, SCREEN_WIDTH, _rsView.locationBtn.frame.size.height+0.03*SCREEN_HEIGHT);
    CATransition *animation = [CATransition animation];
    [animation setDuration:1];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    animation.delegate = self;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [_rsView.layer addAnimation:animation forKey:@"fadeInRSView"];
    rsViewOut = YES;
    
}

- (void)rsViewFadeOut
{
    _rsView.frame = CGRectMake(SCREEN_WIDTH,0.09*SCREEN_HEIGHT, SCREEN_WIDTH, 0.36*SCREEN_HEIGHT);
    CATransition *animation = [CATransition animation];
    [animation setDuration:1];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    animation.delegate = self;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [_rsView.layer addAnimation:animation forKey:@"fadeOutRSView"];
    rsViewOut = NO;
}

#pragma mark - POCTViewMethod


- (void)RouteSeachExcute
{
//    NSLog(@"routeSearch");
    if (polyLine!=nil) {
        NSLog(@"%d overs",(int)_mapView.overlays.count);
        for (id overlay in _mapView.overlays) {
            if ([overlay isKindOfClass:[MAPolyline class]]) {
                [_mapView removeOverlay:overlay];
            }
        }
    }
//    NSLog(@"%f %f",tappedAnnotation.coordinate.longitude,tappedAnnotation.coordinate.latitude);
    AMapWalkingRouteSearchRequest *transitRequest = [[AMapWalkingRouteSearchRequest alloc]init];
    transitRequest.origin      = [AMapGeoPoint locationWithLatitude:poiUserAnnotation.coordinate.latitude longitude:poiUserAnnotation.coordinate.longitude];
    transitRequest.destination = [AMapGeoPoint locationWithLatitude:tappedAnnotation.coordinate.latitude longitude:tappedAnnotation.coordinate.longitude];
    [_search AMapWalkingRouteSearch:transitRequest];

    [self pcotViewFadeOut];
}


-(void)detailViewExcute
{
    NSLog(@"detailView");
    int i = 0;
    for (NSString *str in insidePointArray) {
        
        NSArray *array = [str componentsSeparatedByString:@";"];
//        NSLog(@"%@",array[0]);
        if (([array[0] isEqualToString:[NSString stringWithFormat:@"%f",tappedAnnotation.coordinate.latitude]] )&&([array[1] isEqualToString:[NSString stringWithFormat:@"%f",tappedAnnotation.coordinate.longitude]])) {
//            NSLog(@"you got it!");
//            NSLog(@"%@",insideHouseArray[i]);
            [self pcotViewFadeOut];
            
            HouseDetailView *detail = [[HouseDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            [detail.topView.returnButton addTarget:self action:@selector(cancelDetailView:) forControlEvents:UIControlEventTouchUpInside];
//            [detail.returnButton addTarget:self action:@selector(cancelDetailView:) forControlEvents:UIControlEventTouchUpInside];
            detail.tag = 99;
            detail.goToMapBtn.hidden = YES;
            [self.view addSubview:detail];
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromRight];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [detail.layer addAnimation:animation forKey:@"transView"];
            
            
            
            [detail transTitle:[self nilTransToString:[insideHouseArray[i] objectForKey:@"title_detail"]] price:[self nilTransToString:[insideHouseArray[i] objectForKey:@"price_detail"]] type:[insideHouseArray[i] objectForKey:@"house_type"] config:[insideHouseArray[i] objectForKey:@"config"] description:[insideHouseArray[i] objectForKey:@"description"] address:[self nilTransToString:[insideHouseArray[i] objectForKey:@"address"]] publishTime:[self nilTransToString:[insideHouseArray[i] objectForKey:@"publish_time"]] imageURL:[self filterString:[insideHouseArray[i] objectForKey:@"pic_urls"]] broker_name:[self nilTransToString:[insideHouseArray[i] objectForKey:@"broker_name"]] broker_tel:[self nilTransToString:[insideHouseArray[i] objectForKey:@"broker_tel"]] xiaoqu:[self nilTransToString:[insideHouseArray[i] objectForKey:@"xiaoqu"]]];
        }
        i++;
    }
    
}

- (NSString*)nilTransToString:(id)dicValue
{
    NSString *str;
//    if ([array isKindOfClass:[NSNull class]]) {
//        str = @"暂无数据";
//    }else
//    {
//        str = [array firstObject];
//    }
//    return str;
    
    if ([dicValue isKindOfClass:[NSNull class]]) {
        str = @"暂无数据";
    }else{
        if ([dicValue isKindOfClass:[NSArray class]]) {
            NSArray *iT = dicValue;
            if ([iT firstObject]==nil) {
                str = @"暂无数据";
            }else{
                str = [iT firstObject];
            }
        }else if([dicValue isKindOfClass:[NSString class]]){
            str = dicValue;
        }else{
            str = @"暂无数据";
        }
    }
    
    return str;
}

- (id)filterString:(id)dicValue
{
    if ([dicValue isKindOfClass:[NSNull class]]) {
        return @"暂无数据";
    }else{
        if ([dicValue isKindOfClass:[NSArray class]]) {
            NSArray *iT = dicValue;
            if ([iT firstObject]==nil) {
                return @"暂无数据";
            }else{
                return iT;
            }
        }else if([dicValue isKindOfClass:[NSString class]]){
            return dicValue;
        }
    }
    return @"暂无数据";
}

- (void)cancelDetailView:(UIButton*)btn
{
    NSLog(@"1");
    for (UIView *child in self.view.subviews){
        if (child.tag == 99) {
            [child setFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromLeft];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [child.layer addAnimation:animation forKey:@"cancelView"];
        }
        
    }
    
}

- (void)pcotViewFadeIn
{
    _pcotView.frame = CGRectMake(0.287*SCREEN_WIDTH,0.18*SCREEN_HEIGHT, 0.427*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
    CATransition *animation = [CATransition animation];
    [animation setDuration:1];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromBottom];
    animation.delegate = self;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [_pcotView.layer addAnimation:animation forKey:@"fadeInPCOTView"];
    pcotViewOut = YES;
    
}

- (void)pcotViewFadeOut
{
    _pcotView.frame = CGRectMake(SCREEN_WIDTH,0.18*SCREEN_HEIGHT, 0.427*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT);
    CATransition *animation = [CATransition animation];
    [animation setDuration:1];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromTop];
    animation.delegate = self;
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [_pcotView.layer addAnimation:animation forKey:@"fadeOutPCOTView"];
    pcotViewOut = NO;
}

#pragma mark - ToolViewMethod
- (void)searchBtn:(UIButton*)btn
{
    

}


#pragma mark - SegmentControlDelegate
- (void)buttonClick:(NSInteger)sender{
    
//    NSLog(@"%d",(int)sender);
    
    int i = (int)sender;
    if (i==3) {
        
        [self removeFromSuperView:_historyView];
        [self removeFromSuperView:_favoriteView];
        if (!_settingView) {
            _settingView = [[SettingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
        }else{
            [self removeFromSuperView:_settingView];
            _settingView = [[SettingView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
        }
        
        [self.view addSubview:_settingView];
        
    }else if(i==2){
        
        [self removeFromSuperView:_settingView];
        [self removeFromSuperView:_favoriteView];
        if (!_historyView) {
            _historyView = [[HistoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
        }else{
            [self removeFromSuperView:_historyView];
            _historyView = [[HistoryView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
        }
        
        [self.view addSubview:_historyView];
    }else if (i==1){
        
        [self removeFromSuperView:_settingView];
        [self removeFromSuperView:_historyView];
        if (!_favoriteView) {
            _favoriteView = [[FavoriteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
        }else{
            [self removeFromSuperView:_favoriteView];
            _favoriteView = [[FavoriteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
        }
        
        [self.view addSubview:_favoriteView];
    }else if (i==0){
        
        [self removeFromSuperView:_favoriteView];
        [self removeFromSuperView:_historyView];
        [self removeFromSuperView:_settingView];
        [self nightMode];
        [self changeSearchToolColor];
    }else{
        
    }
}



- (void)changeSearchToolColor
{
    if (rsViewOut==YES) {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref;
        if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
            
            colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
            
        }else{
            
            colorref = CGColorCreate(colorSpace, (CGFloat[]){25.0/255.0,25.0/255.0,191.0/255.0,1});
            
        }
        [_rsView.layer setBorderColor:colorref];
    }else if(esViewOut ==YES)
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref;
        if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
            
            colorref = CGColorCreate(colorSpace, (CGFloat[]){0,191.0/255.0,1,1});
            
        }else{
            
            colorref = CGColorCreate(colorSpace, (CGFloat[]){25.0/255.0,25.0/255.0,191.0/255.0,1});
            
        }
        [_esView.layer setBorderColor:colorref];
    
    
    }
}

- (void)removeFromSuperView:(UIView*)view
{
    if (view) {
        [view removeFromSuperview];
    }

}

#pragma mark - TextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if ([textField isEqual:_rsView.radiusTF]) {
//        NSLog(@"begin input");
//    return YES;
//    }
//    return YES;
//}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField isEqual:_rsView.radiusTF]) {
//        NSLog(@"begin input");
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([textField isEqual:_rsView.radiusTF]) {
        NSString *str = [_rsView.radiusTF.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
        if (str.length == 0) {
            if (circle != nil) {
                double a = _rsView.radiusTF.text.doubleValue;
                [_mapView removeOverlay:circle];
                circle = [MACircle circleWithCenterCoordinate:poiUserAnnotation.coordinate radius:a+150];
                [_mapView addOverlay:circle];
                [self distanceToZoomLevel:a];
                _mapView.centerCoordinate = poiUserAnnotation.coordinate;
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入不含小数的数字" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
            _rsView.radiusTF.text = nil;
            
        }
//        [_mapView removeOverlay:circle];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:_searchTextField]) {
        [_searchTextField resignFirstResponder];
        return YES;
    }else if ([textField isEqual:_cityTextField])
    {
        [_cityTextField resignFirstResponder];
        return YES;
    }else if ([textField isEqual:_rsView.radiusTF])
    {
        [_rsView.radiusTF resignFirstResponder];
        return YES;
    }
    return YES;
}

#pragma mark - POI and Route Search
int SearchDownNo;
int locationNo;

int esSearchDownNo;
int esLocationNo;
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        NSLog(@"No data");
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"遗憾" message:@"未搜到结果" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
        return;
    }
    
    if (rsOn ==YES) {
        SearchDownNo++;
    }else if(esOn == YES)
    {
        esSearchDownNo++;
    }
    
    if (rsOn == YES) {
        if ([request isKindOfClass:[AMapPOIKeywordsSearchRequest class]]) {
            AMapPOIKeywordsSearchRequest *map = (AMapPOIKeywordsSearchRequest*)request;
            NSLog(@"keyword:%@",map.keywords);
            NSString *strPoi = @"";
            int a = 0;
            for (AMapPOI *p in response.pois)
            {
                if (a == 0) {
                    if (locationNo == poiArrayCount) {
                        locationNo = 0;
                    }
                    _MIP = p;
                    internalOptionLocation[locationNo] = CLLocationCoordinate2DMake(_MIP.location.latitude, _MIP.location.longitude);
                    
                    NSDictionary *dic;
//                    NSLog(@"poiCount = %d",poiCount);
                    NSString *xiaoquStr;
                    
                    
                    MAMapPoint sourcePoint = MAMapPointForCoordinate(poiUserAnnotation.coordinate);
                    MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake(_MIP.location.latitude, _MIP.location.longitude));
                    if (MAMetersBetweenMapPoints(sourcePoint, point1)<Radius_distance) {
                        rsSearchResultCount++;
                        for (int i =0; i<poiCount; i++) {
                            
                            if ([[dicList[i] objectForKey:@"xiaoqu"] isKindOfClass:[NSArray class]]) {
                                NSArray *array = [dicList[i] objectForKey:@"xiaoqu"];
                                xiaoquStr = [array lastObject];;
                            }else if([[dicList[i] objectForKey:@"xiaoqu"] isKindOfClass:[NSString class]]){
                                xiaoquStr = [dicList[i] objectForKey:@"xiaoqu"];
                            }
                            
                            if ([xiaoquStr isEqualToString:map.keywords]) {
                                NSLog(@"got it!%@",map.keywords);
//                                xiaoquStr = map.keywords;
                                dic = dicList[i];
                            }
                        }
                        
                        NSArray *priArray = [dic objectForKey:@"price_detail"];
                        NSString *priString;
                        if ([priArray firstObject]==nil) {
                            priString = @"暂无数据";
                        }else{
                            priString = [[priArray firstObject] stringByAppendingString:@"元/月"];
                        }
                        
//                        NSLog(@"add is %@ , price is %@",xiaoquStr,priString);
                        [self addAnnotation:(double)p.location.latitude :(double)p.location.longitude :map.keywords :priString];
                        [insidePointArray addObject:[NSString stringWithFormat:@"%f;%f",(double)p.location.latitude, (double)p.location.longitude]];
                        [insideHouseArray addObject:dic];
                    }else{
                        NSLog(@"outside");
                    
                    }
                    locationNo++;
                }
                a++;
                strPoi = [NSString stringWithFormat:@"%@\nPOI: %@",strPoi,p.address];
            }
            
            float prog = (double)SearchDownNo/(double)poiArrayCount;
            progressForeRatio = progressLaterRatio;
            progressLaterRatio = prog;
            if (prog > 0.95) {
                prog = 1;
            }
            [_rsProgress setProgress:prog Animated:NO];
            
            if (prog == 1) {
                NSLog(@"SearchDone");
                rsOn = NO;
                NSString *mes = [NSString stringWithFormat:@"共搜到%d处符合条件的房源",rsSearchResultCount];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"雷达搜索" message:mes delegate:self cancelButtonTitle:@"确定" otherButtonTitles: @"再搜一次",nil];
                alert.tag = 99;
                [alert show];
                [_rsProgress removeFromSuperview];
                [_mapTypeBtn setEnabled:YES];
                
                [self enableBtns];
            }
            
            if (SearchDownNo == poiArrayCount) {
                SearchDownNo = 0;
            }
        }
    }else if(esOn==YES){
        if ([request isKindOfClass:[AMapPOIKeywordsSearchRequest class]]) {
            AMapPOIKeywordsSearchRequest *map = (AMapPOIKeywordsSearchRequest*)request;
            NSLog(@"keyword:%@",map.keywords);
//        }
            NSString *strPoi = @"";
            int a = 0;
            for (AMapPOI *p in response.pois)
            {
                if (a == 0) {
                    
                    _MIP = p;
                    esSearchLocation[esLocationNo] = CLLocationCoordinate2DMake(_MIP.location.latitude, _MIP.location.longitude);
                    NSString *xiaoquStr;
                    NSDictionary *dic;
                    NSLog(@"poiEsCount = %d",poiEsCount);
//                    NSString *xqString;
                    
                    for (int i =0; i<poiEsCount; i++) {
                        
//                        NSLog(@"keyword is %@",map.keywords);
//                        NSLog(@"dicKey is %@",[dicEsList[i] objectForKey:@"xiaoqu"]);
                        
                        if ([[dicEsList[i] objectForKey:@"xiaoqu"] isKindOfClass:[NSArray class]]) {
                            NSArray *array = [dicEsList[i] objectForKey:@"xiaoqu"];
                            xiaoquStr = [array lastObject];;
                        }else if([[dicEsList[i] objectForKey:@"xiaoqu"] isKindOfClass:[NSString class]]){
                            xiaoquStr = [dicEsList[i] objectForKey:@"xiaoqu"];
                        }
                        
                        if ([xiaoquStr isEqualToString:map.keywords]) {
                            NSLog(@"got it!%@",map.keywords);
//                            xiaoquStr = map.keywords;
//                            [dicEsList[i] setValue:xqString forKey:@"xiaoqu"];
                            dic = dicEsList[i];
                            
                        }
                    }
                    
                    NSArray *priArray = [dic objectForKey:@"price_detail"];
                    NSString *priString;
                    if ([priArray firstObject]==nil) {
                        priString = @"暂无数据";
                    }else{
                        priString = [[priArray firstObject] stringByAppendingString:@"元/月"];
                    }
                    
                    [self addAnnotation:(double)p.location.latitude :(double)p.location.longitude :xiaoquStr :priString];
                    [EsPointArray addObject:[NSString stringWithFormat:@"%f;%f",(double)p.location.latitude, (double)p.location.longitude]];
                    [EsHouseArray addObject:dic];
                    esLocationNo++;
                }
                a++;
                strPoi = [NSString stringWithFormat:@"%@\nPOI: %@",strPoi,p.address];
            }
            
            float prog = (double)esSearchDownNo/(double)EsSearchResultCount;
            [_rsProgress setProgress:prog Animated:NO];
            if (prog == 1) {
                NSLog(@"SearchDone");
                esOn = NO;
                NSString *mes = [NSString stringWithFormat:@"共搜到%d处符合条件的房源",EsSearchResultCount];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"条件搜索" message:mes delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                alert.tag = 99;
                [alert show];
                [_rsProgress removeFromSuperview];
                [_mapTypeBtn setEnabled:YES];
                
                [self enableBtns];
            }
            
            if (esSearchDownNo == EsSearchResultCount) {
                esSearchDownNo = 0;
            }
        }
    }else if(dsOn==YES){
        NSLog(@"outPoiSearch");
        if ([request isKindOfClass:[AMapPOIKeywordsSearchRequest class]]) {
            AMapPOIKeywordsSearchRequest *map = (AMapPOIKeywordsSearchRequest*)request;
            NSLog(@"keyword:%@",map.keywords);
            NSString *strPoi = @"";
            int a = 0;
            for (AMapPOI *p in response.pois)
            {
                
                if (a == 0) {
                    _mapView.centerCoordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
                    [self addAnnotation:(double)p.location.latitude :(double)p.location.longitude :[DetailHouseDic objectForKey:@"xiaoqu"] :[DetailHouseDic objectForKey:@"price_detail"]];
                }
                a++;
                strPoi = [NSString stringWithFormat:@"%@\nPOI: %@",strPoi,p.address];
            }
        }
    }
    
}


- (void)progressPercentTimer:(NSTimer*)timer
{
    if (isFirstTimerRun == YES) {
        isFirstTimerRun = NO;
    }else{
//        NSLog(@"good");
        if (_rsProgress.Percentage == progressForeRatio) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"搜索结束" message:@"您的网速有点慢" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 3;
            [alert show];
            isFirstTimerRun = YES;
            [timer invalidate];
            timer = nil;
            NSLog(@"invalidate");
        }
    }
}

- (void)progressZeroTimer:(NSTimer*)timer
{
    if (isFirstTimerRun == YES) {
        isFirstTimerRun = NO;
    }else{
        //        NSLog(@"good");
        if (_rsProgress.Percentage == 0.0) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络" message:@"您的网速有点慢" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag = 3;
            [alert show];
        }
            isFirstTimerRun = YES;
            [_timer invalidate];
            _timer = nil;
            NSLog(@"invalidate");
        
    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99) {
        if (buttonIndex == 1) {
            NSLog(@"cool");
            SearchTimes++;
            [self AFN:SearchTimes];
        }
    }

}
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response{
    if (response.route == nil) {
        return;
    }else{
        //公交路径
        if([request isKindOfClass:[AMapTransitRouteSearchRequest class]]){
//        NSString *route =[NSString stringWithFormat:@"navi: %@", response.route];
        NSLog(@"%lu",(unsigned long)response.route.paths.count);
        NSLog(@"%lu",(unsigned long)response.route.transits.count);
        int a = 0;
        for (AMapTransit *T in response.route.transits) {
            a++;
            NSLog(@"No%d\n",a);
            for (AMapSegment *S in T.segments) {
                NSLog(@"enter:%@,exit:%@",S.enterName,S.exitName);
            }
            NSLog(@"No%d ,cost is %f,duration is %ld,distance is %ld",a,T.cost,(long)T.duration,(long) T.distance);
            }
        }else
        //步行路径
        if ([request isKindOfClass:[AMapWalkingRouteSearchRequest class]]){
        
//            NSLog(@"%lu",(unsigned long)response.route.paths.count);
            for (AMapWalking *W in response.route.paths){
//                NSLog(@"%lu",(unsigned long)W.steps.count);
                
                for (AMapStep *S in W.steps) {
                    NSString *str = S.polyline;
                    NSArray *array = [str componentsSeparatedByString:@";"];
                    CLLocationCoordinate2D location[array.count];
                    int i = 0;
                    for(NSString *coor in array)
                    {
                        NSArray *coorArray = [coor componentsSeparatedByString:@","];
                        NSString *longtitude = (NSString*)[coorArray objectAtIndex:1];
                        NSString *latitude = (NSString*)[coorArray objectAtIndex:0];
                        location[i] = CLLocationCoordinate2DMake(longtitude.doubleValue, latitude.doubleValue);
//                        NSLog(@"%f %f",location[i].longitude,location[i].latitude);
                        i++;
                    }
                    polyLine = [MAPolyline polylineWithCoordinates:location count:array.count];
                    [_mapView addOverlay:polyLine];
                }
            }
        }
    }
}


#pragma mark - Annotation

- (void)addAnnotation:(double)latitude :(double)longitude :(NSString*)name :(NSString*)address
{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    pointAnnotation.title = name;
    pointAnnotation.subtitle = address;
    [_mapView addAnnotation:pointAnnotation];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        MAPointAnnotation *poi = (MAPointAnnotation*)annotation;

        
        if (rsOn == YES) {
            if ([poi.title isEqualToString:locationTitle]) {
                _mapView.centerCoordinate = poi.coordinate;
                static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
                MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
                if (annotationView == nil) {
                    annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
                }
                annotationView.canShowCallout = YES;
                annotationView.animatesDrop = YES;
                annotationView.draggable =YES;
                annotationView.pinColor = MAPinAnnotationColorPurple;
                
                return annotationView;
            }
        
            static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
            MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
            if (annotationView == nil) {
                annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            }
            annotationView.canShowCallout = YES;
            annotationView.animatesDrop = YES;
            annotationView.draggable =YES;
            annotationView.pinColor = MAPinAnnotationColorGreen;
            
            return annotationView;
        }
        else
        {
            static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
            MAPinAnnotationView *annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
            if (annotationView == nil) {
                annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            }
            annotationView.canShowCallout = YES;
            annotationView.animatesDrop = YES;
            annotationView.draggable =YES;
            annotationView.pinColor = MAPinAnnotationColorRed;
            
            return annotationView;
        
        }
        
    }else if([annotation isKindOfClass:[MAUserLocation class]])
    {
        NSLog(@"MAUserAnnotation");
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
//    NSLog(@"viewSelected");
    if (pcotViewOut == YES) {
        [self pcotViewFadeOut];
    }
}

- (void)mapView:(MAMapView *)mapView didAnnotationViewCalloutTapped:(MAAnnotationView *)view
{
    if ([view isKindOfClass:[MAPinAnnotationView class]]){
//        NSLog(@"PinView");
        MAPointAnnotation *poi = view.annotation;
        MAPinAnnotationView *pinView = (MAPinAnnotationView*)view;
        if (pinView.pinColor == MAPinAnnotationColorGreen) {
            tappedAnnotation = poi;
            if (pcotViewOut == NO) {
                
                [self.view addSubview:_pcotView];
                [self pcotViewFadeIn];
                
            }else{
                
                [self pcotViewFadeOut];
            }
        }else if(pinView.pinColor == MAPinAnnotationColorRed)
        {
            if ((poi.title!=nil)||(![poi.title isEqualToString:locationTitle])) {
                tappedAnnotation = poi;
//                NSLog(@"hehe");
                int i = 0;
//                NSLog(@"pointArrayCount is %d",(int)EsPointArray.count);
                for (NSString *str in EsPointArray) {
                    NSArray *array = [str componentsSeparatedByString:@";"];
                    NSLog(@"%@",array[0]);
                    if (([array[0] isEqualToString:[NSString stringWithFormat:@"%f",tappedAnnotation.coordinate.latitude]] )&&([array[1] isEqualToString:[NSString stringWithFormat:@"%f",tappedAnnotation.coordinate.longitude]])) {
//                        NSLog(@"you got it!");
//                        NSLog(@"%@",EsHouseArray[i]);
                        HouseDetailView *detail = [[HouseDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                        detail.typeInt = 1;
                        detail.goToMapBtn.hidden = YES;
//                        [detail.goToMapBtn addTarget:self action:@selector(goToMap) forControlEvents:UIControlEventTouchUpInside];
                        [detail.topView.returnButton addTarget:self action:@selector(cancelDetailView:) forControlEvents:UIControlEventTouchUpInside];
                        detail.tag = 99;
                        [self.view addSubview:detail];
                        CATransition *animation = [CATransition animation];
                        [animation setDuration:0.5];
                        [animation setType:kCATransitionPush];
                        [animation setSubtype:kCATransitionFromRight];
                        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                        [detail.layer addAnimation:animation forKey:@"transView"];
                        
                        NSLog(@"xiaoqu: %@",[self nilTransToString:[EsHouseArray[i] objectForKey:@"xiaoqu"]]);
                        [detail transTitle:[self nilTransToString:[EsHouseArray[i] objectForKey:@"title_detail"]] price:[self nilTransToString:[EsHouseArray[i] objectForKey:@"price_detail"]] type:[self nilTransToString:[EsHouseArray[i] objectForKey:@"house_type"]] config:[self nilTransToString:[EsHouseArray[i] objectForKey:@"config"]] description:[self nilTransToString:[EsHouseArray[i] objectForKey:@"description"]] address:[self nilTransToString:[EsHouseArray[i] objectForKey:@"address"]] publishTime:[self nilTransToString:[EsHouseArray[i] objectForKey:@"publish_time"]] imageURL:[self filterString:[EsHouseArray[i] objectForKey:@"pic_urls"]] broker_name:[self nilTransToString:[EsHouseArray[i] objectForKey:@"broker_name"]] broker_tel:[self nilTransToString:[EsHouseArray[i] objectForKey:@"broker_tel"]] xiaoqu:[self nilTransToString:[EsHouseArray[i] objectForKey:@"xiaoqu"]]];
                    }
                    i++;
                }
            }
            
        }
        
    }else if ([view isKindOfClass:[HouseAnnotationView class]]){
        NSLog(@"HouseView!");
    }
}

- (void)goToMap
{
    for (UIView *view in [self.view subviews]) {
        if ([view isKindOfClass:[HouseDetailView class]]) {
            NSLog(@"you got it");
            [view removeFromSuperview];
        }
    }
}


- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];

    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        user = view.annotation;
        NSLog(@"%f %f",user.location.coordinate.longitude,user.location.coordinate.latitude);
        userLocation = user.location.coordinate;
        circle = [MACircle circleWithCenterCoordinate:user.location.coordinate radius:radius_meter];
        [_mapView addOverlay:circle];

        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc]init];
        pre.fillColor = [UIColor colorWithRed:0.8 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6,@3];
        [_mapView updateUserLocationRepresentation:pre];
        view.calloutOffset = CGPointMake(0, 0);
        
        view.draggable = YES;
    }else if([view.annotation isKindOfClass:[MAPointAnnotation class]])
    {
        MAPointAnnotation *anno = (MAPointAnnotation *)view.annotation;
        if ([anno.title isEqual:locationTitle]) {
            view.draggable = YES;
            poiUserAnnotation = view.annotation;
            userLocation = poiUserAnnotation.coordinate;
        }else{
            view.draggable = NO;
        }
    }
    
}


- (void)mapView:(MAMapView *)mapView annotationView:(MAAnnotationView *)view didChangeDragState:(MAAnnotationViewDragState)newState fromOldState:(MAAnnotationViewDragState)oldState
{
    MAPointAnnotation *anno = (MAPointAnnotation *)view.annotation;
    if ([anno.title isEqual:locationTitle]) {
//        poiA = [view annotation];
        switch (newState) {
            case MAAnnotationViewDragStateStarting:
                NSLog(@"start");
                break;
            case MAAnnotationViewDragStateDragging:
                NSLog(@"dragging");
                if (circle!=nil) {
                    [_mapView removeOverlay:circle];
                }
                
//              NSLog(@"%f",user.location.coordinate.longitude);
                NSLog(@"%f",poiUserAnnotation.coordinate.longitude);
                break;
            case MAAnnotationViewDragStateEnding:
                NSLog(@"ending");
                
                if ((_rsView.radiusTF.text != nil)||(_rsView.radiusTF!=NULL)) {
                    circle = [MACircle circleWithCenterCoordinate:poiUserAnnotation.coordinate radius:_rsView.radiusTF.text.doubleValue+300];
                    [_mapView addOverlay:circle];
                }
//                NSLog(@"%lu",(unsigned long)_mapView.annotations.count);
                poiUserAnnotation = [view annotation];
                userLocation = poiUserAnnotation.coordinate;
                
                [_mapView removeAnnotations:_mapView.annotations];
//                NSLog(@"%lu",(unsigned long)_mapView.annotations.count);
                
                poiUserAnnotation = [[MAPointAnnotation alloc]init];
                poiUserAnnotation.coordinate = userLocation;
                poiUserAnnotation.title = locationTitle;
                [_mapView addAnnotation:poiUserAnnotation];
                
                _mapView.centerCoordinate = userLocation;
                
                if (polyLine!=nil) {
                    NSLog(@"%d overs",(int)_mapView.overlays.count);
                    for (id overlay in _mapView.overlays) {
                        if ([overlay isKindOfClass:[MAPolyline class]]) {
                            [_mapView removeOverlay:overlay];
                        }
                    }
                }
//                NSLog(@"final coor is %f %f",poiUserAnnotation.coordinate.longitude,poiUserAnnotation.coordinate.latitude);
                break;
            default:
                break;
        }
    }
}

- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"clicked");
    if (pcotViewOut == YES) {
        [self pcotViewFadeOut];
    }

}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"Location Error: %@",error);
}

#pragma mark - Overlay

-(MAOverlayView*)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MACircle class]]) {
        
        MACircleView *circleView = [[MACircleView alloc]initWithCircle:overlay];
        circleView.lineWidth = 2.f;
        circleView.strokeColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        circleView.fillColor = [UIColor colorWithRed:0.1 green:1.0 blue:0.5 alpha:0.2];
        
        return circleView;
    }else if([overlay isKindOfClass:[MAPolyline class]]){
//        MAPolyline *line = overlay;
//        NSLog(@"%lu",(unsigned long)line.pointCount);
        MAPolylineView *polylineView = [[MAPolylineView alloc]initWithPolyline:overlay];
        polylineView.lineWidth = 5.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:1];
        return polylineView;
    }
    return  nil;
}

#pragma mark - TopViewButtonEnabled

- (void)disenableBtns
{
    [_listButton setEnabled:NO];
    [_radarSearchButton setEnabled:NO];
    [_exactSearchButton setEnabled:NO];
}

- (void)enableBtns
{
    [_listButton setEnabled:YES];
    [_radarSearchButton setEnabled:YES];
    [_exactSearchButton setEnabled:YES];

}

# pragma mark - CoreDataMethod

- (void)insert
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSManagedObject *houseObj = [NSEntityDescription insertNewObjectForEntityForName:@"HouseEntity" inManagedObjectContext:context];
    [houseObj setValue:@"title" forKey:@"title_detail"];
    [houseObj setValue:@"1800" forKey:@"price"];
    [houseObj setValue:@"床/网/暖气" forKey:@"config"];
    [houseObj setValue:@"华庭小区" forKey:@"xiaoqu"];
    [houseObj setValue:[NSNumber numberWithInt:3] forKey:@"id"];
    [houseObj setValue:@"16-02-03" forKey:@"publish_time"];
    [houseObj setValue:@"3室2厅1卫" forKey:@"house_type"];
    [houseObj setValue:@"描述" forKey:@"house_description"];
    [houseObj setValue:@"长安中路17号" forKey:@"address"];
    [houseObj setValue:[NSArray arrayWithObjects:@"1",@"2", nil] forKey:@"pic_urls"];
    
    NSError *error;
    if ([context save:&error]) {
        NSLog(@"save ok");
    }else{
    
        NSLog(@"error:%@",error);
    }

}

- (void)selectAll
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *house = [NSEntityDescription entityForName:@"HouseEntity" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:house];
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    
    for (NSManagedObject *entity in resultArray) {
        NSLog(@"%@ %@ %@ %@",[entity valueForKey:@"title_detail"],[entity valueForKey:@"price"],[entity valueForKey:@"xiaoqu"],[entity valueForKey:@"address"]);
    }
    
}

- (NSMutableArray*)selectFromKey:(NSString*)key
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *house = [NSEntityDescription entityForName:@"HouseEntity" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:house];
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSManagedObject *entity in resultArray) {
//        NSLog(@"%@ %@ %@",[entity valueForKey:@"title_detail"],[entity valueForKey:@"price"],[entity valueForKey:@"xiaoqu"]);
        [array addObject:[entity valueForKey:key]];
    }
//    NSLog(@"array:%@",array);
    return array;
}


- (void)update
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *house = [NSEntityDescription entityForName:@"HouseEntity" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:house];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id=%i",1];
//    [request setPredicate:predicate];
    
    NSArray *houseArray= [context executeFetchRequest:request error:nil];
    if (houseArray.count>0) {
//        NSManagedObject *obj = houseArray[0];
//        [obj setValue:@"2300" forKey:@"price"];
//        NSLog(@"true");
        NSLog(@"count is %d",(int)houseArray.count);
    }else{
        NSLog(@"nil");
    }
}

- (void)delete
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    
    NSEntityDescription *house = [NSEntityDescription entityForName:@"HouseEntity" inManagedObjectContext:context];
    
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:house];
    
    NSManagedObject *obj = [[context executeFetchRequest:request error:nil]lastObject];
    if (obj) {
        [context deleteObject:obj];
        [context save:nil];
    }

}

- (void)deleteAll
{
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
}


@end
