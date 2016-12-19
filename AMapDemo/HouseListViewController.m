//
//  HouseListViewController.m
//  AMapDemo
//
//  Created by yrq_mac on 16/1/30.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//
#import "ViewController.h"
#import "HouseListViewController.h"
#import "ListTableViewCell.h"
#import "HouseDetailView.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "PicLoadEnableSharedClass.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@interface HouseListViewController ()
{
    BOOL loadLock;

}
@end

@implementation HouseListViewController

static  HouseListViewController *VC;

+(id)shareHouseListViewController
{
    if (VC==nil)
    {
        VC = [[HouseListViewController alloc]init];
    }
    return VC;
}

int i = 1;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
//        NSLog(@"not nightmode");
    }else{
//        NSLog(@"is nightmode");
    }
    
    [self dataInit];
    [self topViewInit];

    [self initAnimation];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT*0.09, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _infiniteScrollView = [[UIView alloc]initWithFrame:CGRectMake(0, _tableView.contentSize.height, _tableView.bounds.size.width, 0.09*SCREEN_HEIGHT)];
    _infiniteScrollView.backgroundColor = [UIColor whiteColor];
    _infiniteScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.color = [UIColor grayColor];
    indicatorView.frame = CGRectMake(_infiniteScrollView.frame.size.width/2-indicatorView.frame.size.width/2, _infiniteScrollView.frame.size.height/2-indicatorView.frame.size.height/2, indicatorView.frame.size.width, indicatorView.frame.size.height);
    [indicatorView startAnimating];
    [_infiniteScrollView addSubview:indicatorView];
    [self AFNHouseList];
}

- (void)dataInit
{
    _titleArray = [[NSMutableArray alloc]init];
    _addressArray = [[NSMutableArray alloc]init];
    _priceArray = [[NSMutableArray alloc]init];
    _roomArray = [[NSMutableArray alloc]init];
    _picURLArray = [[NSMutableArray alloc]init];
    _configArray = [[NSMutableArray alloc]init];
    _descriptionArray = [[NSMutableArray alloc]init];
    _publishTimeArray = [[NSMutableArray alloc]init];
    _brokerNameArray = [[NSMutableArray alloc]init];
    _brokerTelArray = [[NSMutableArray alloc]init];
    _xiaoquArray = [[NSMutableArray alloc]init];
}


-(void)topViewInit
{
    
    _topView = [[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.09*SCREEN_HEIGHT)];
    [_topView.returnButton addTarget:self action:@selector(returnExcute) forControlEvents:UIControlEventTouchUpInside];
    _topView.topLabel.text = @"房源列表";
    [self.view addSubview:_topView];

}

- (void)initAnimation
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0.09*SCREEN_HEIGHT, SCREEN_WIDTH, 0.91*SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor whiteColor];
    self.loadingImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.447*SCREEN_WIDTH, 0.47*SCREEN_HEIGHT,0.107*SCREEN_WIDTH, 0.059*SCREEN_HEIGHT)];
    [view addSubview:self.loadingImageView];
    [self.view addSubview:view];
    self.loadingTimer = [NSTimer scheduledTimerWithTimeInterval:0.125 target:self selector:@selector(setNextImage) userInfo:nil repeats:YES];
}


-(void)setNextImage
{
    if(i<8)
    {
        [self.loadingImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"load%i.png",i]]];
        i=i+1;
    }
    else i=1;
}

- (void)returnExcute
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName=@"123";
    if((indexPath.row == _titleArray.count-1)&&(loadLock == NO)){
        NSLog(@"last one");
        _tableView.tableFooterView = _infiniteScrollView;
        [self loadMore];
    }
    
    ListTableViewCell *cell = [[ListTableViewCell alloc]init];
//    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellName];
//    if (cell==nil) {
//        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
//    }
    if (cell==nil) {
        cell=[[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.titleLabel.text = [_titleArray objectAtIndex:indexPath.row];
    cell.publishTimeLabel.text = [_publishTimeArray objectAtIndex:indexPath.row];
    cell.cityLabel.text = @"北京";
    cell.priceLabel.text = [[_priceArray objectAtIndex:indexPath.row] stringByAppendingString:@"元/月"];
    cell.roomLabel.text = [_roomArray objectAtIndex:indexPath.row];
    if ([PicLoadEnableSharedClass newInstance].WWANLoadPicEnabled == YES) {
        if ([PicLoadEnableSharedClass newInstance].MobileNetLoadEnabled ==YES) {
            if ([[_picURLArray objectAtIndex:indexPath.row] isKindOfClass:[NSArray class]]) {
                NSArray *array = [_picURLArray objectAtIndex:indexPath.row];
                [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:[array firstObject]]];
            }else if ([[_picURLArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])
            {
                if ([[_picURLArray objectAtIndex:indexPath.row] isEqualToString:@"暂无数据"]) {
                    cell.houseImageView.image = [UIImage imageNamed:@"pic_nil.jpg"];
                }else{
                    [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:[_picURLArray objectAtIndex:indexPath.row]]];
                }
                
            }else{
                cell.houseImageView.image = [UIImage imageNamed:@"pic_nil.jpg"];
            }
        }else if (([PicLoadEnableSharedClass newInstance].isWifi == YES)){
            if ([[_picURLArray objectAtIndex:indexPath.row] isKindOfClass:[NSArray class]]) {
                NSArray *array = [_picURLArray objectAtIndex:indexPath.row];
                [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:[array firstObject]]];
            }else if ([[_picURLArray objectAtIndex:indexPath.row] isKindOfClass:[NSString class]])
            {
                if ([[_picURLArray objectAtIndex:indexPath.row] isEqualToString:@"暂无数据"]) {
                    cell.houseImageView.image = [UIImage imageNamed:@"pic_nil.jpg"];
                }else{
                    [cell.houseImageView sd_setImageWithURL:[NSURL URLWithString:[_picURLArray objectAtIndex:indexPath.row]]];
                }
                
            }else{
                cell.houseImageView.image = [UIImage imageNamed:@"pic_nil.jpg"];
            }
        }else{
            cell.houseImageView.image = [UIImage imageNamed:@"pic_nil.jpg"];
        }
    }else{
        cell.houseImageView.image = [UIImage imageNamed:@"pic_nil.jpg"];
    }
    
    [cell.titleLabel sizeToFit];
    CGRect rectT=cell.titleLabel.frame;
    rectT.size.height=40.0;
    cell.titleLabel.frame=rectT;
    [cell.titleScrollView setContentSize:CGSizeMake(cell.titleLabel.frame.size.width+10, 40)];
    return  cell;
}

- (void)loadMore
{
    loadLock = YES;
    NSLog(@"load more");
    SearchTimes++;
    NSLog(@"times is %d",SearchTimes);
    [self AFNHouseList];
//    [_tableView reloadData];
    
}


- (void)btnDown:(UIButton *)btn
{
    NSLog(@"click");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return 0;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0.18*SCREEN_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    HouseDetailView *detail = [[HouseDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [detail.returnButton addTarget:self action:@selector(cancelDetailView:) forControlEvents:UIControlEventTouchUpInside];
    [detail.goToMapBtn addTarget:self action:@selector(goToMap) forControlEvents:UIControlEventTouchUpInside];
    detail.typeInt = 0;
    [detail.topView.returnButton addTarget:self action:@selector(cancelDetailView:) forControlEvents:UIControlEventTouchUpInside];
    detail.tag = 99;
    [self.view addSubview:detail];
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [detail.layer addAnimation:animation forKey:@"transView"];
    
    [detail transTitle:[_titleArray objectAtIndex:indexPath.row] price:[_priceArray objectAtIndex:indexPath.row] type:[_roomArray objectAtIndex:indexPath.row] config:[_configArray objectAtIndex:indexPath.row] description:[_descriptionArray objectAtIndex:indexPath.row] address:[_addressArray objectAtIndex:indexPath.row] publishTime:[_publishTimeArray objectAtIndex:indexPath.row] imageURL:[_picURLArray objectAtIndex:indexPath.row] broker_name:[_brokerNameArray objectAtIndex:indexPath.row] broker_tel:[_brokerTelArray objectAtIndex:indexPath.row] xiaoqu:[_xiaoquArray objectAtIndex:indexPath.row]];
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    

}

- (void)goToMap
{
    NSLog(@"coolMap");
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)cancelDetailView:(UIButton*)btn
{
//    NSLog(@"1");
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
int a;
int SearchTimes;
- (void)AFNHouseList
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSString *str = @"https://house-radar-server.herokuapp.com/list/?count=";
    int a = 10;
    NSString *s = [str stringByAppendingString:[NSString stringWithFormat:@"%d",a]];
    NSString *b = [@"&times=" stringByAppendingString:[NSString stringWithFormat:@"%d",SearchTimes]];
    NSString *c = [s stringByAppendingString:b];
    
    [manager GET:c parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        for(NSDictionary *dic in responseObject)
        {
//            NSLog(@"dic is %@",dic);
            
            [self filterString:dic[@"price_detail"] array:_priceArray];
            [self filterString:dic[@"house_type"] array:_roomArray];

                if ([dic[@"pic_urls"] isKindOfClass:[NSNull class]]) {
                    [_picURLArray addObject:@"暂无数据"];
                }else{
                    if ([dic[@"pic_urls"] isKindOfClass:[NSArray class]]) {
                        NSArray *iT = dic[@"pic_urls"];
                        if ([iT firstObject]==nil) {
                            [_picURLArray addObject:@"暂无数据"];
                        }else{
                            [_picURLArray addObject:iT];
                        }
                    }else if([dic[@"pic_urls"] isKindOfClass:[NSString class]]){
                        [_picURLArray addObject:@"暂无数据"];
                    }
                }
        
            [self filterString:dic[@"title_detail"] array:_titleArray];
            [self filterString:dic[@"address"] array:_addressArray];
            
            [self filterString:dic[@"config"] array:_configArray];
            [self filterString:dic[@"description"] array:_descriptionArray];
            [self filterString:dic[@"publish_time"] array:_publishTimeArray];
            [self filterString:dic[@"broker_name"] array:_brokerNameArray];
            [self filterString:dic[@"broker_tel"] array:_brokerTelArray];
            [self filterString:dic[@"xiaoqu"] array:_xiaoquArray];
            
        }
        [self.view addSubview:_tableView];
        [_tableView reloadData];
        [self.loadingTimer invalidate];
        loadLock = NO;
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"%@",error);
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络错误" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
        
    }];
}


- (void)filterString:(id)dicValue array:(NSMutableArray*)array
{
    if ([dicValue isKindOfClass:[NSNull class]]) {
        [array addObject:@"暂无数据"];
    }else{
        if ([dicValue isKindOfClass:[NSArray class]]) {
            NSArray *iT = dicValue;
            if ([iT firstObject]==nil) {
                [array addObject:@"暂无数据"];
            }else{
                [array addObject:[iT firstObject]];
            }
        }else if([dicValue isKindOfClass:[NSString class]]){
            [array addObject:dicValue];
        }
    }

}

- (void)viewWillAppear:(BOOL)animated
{

//    NSLog(@"willAppear");

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
