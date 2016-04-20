//
//  FavoriteView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "FavoriteView.h"
#import "ListTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "HouseDetailView.h"
#import "PicLoadEnableSharedClass.h"
#import "ViewController.h"
#import "AppDelegate.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation FavoriteView

static FavoriteView *FavoriteInstanceView;
+ (FavoriteView*)sharedFavoriteView
{
    if (FavoriteInstanceView == nil) {
        FavoriteInstanceView = [[FavoriteView alloc]init];
    }
    return FavoriteInstanceView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self arrayInit];
        [self topViewInit];
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)-60) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_tableView];
    }
    return self;
}

- (void)arrayInit
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
    
    _titleArray = [self selectFromKey:@"title_detail"];
    _addressArray = [self selectFromKey:@"address"];
    _priceArray = [self selectFromKey:@"price"];
    _roomArray = [self selectFromKey:@"house_type"];
    _picURLArray = [self selectFromKey:@"pic_urls"];
    _configArray = [self selectFromKey:@"config"];
    _descriptionArray = [self selectFromKey:@"house_description"];
    _publishTimeArray = [self selectFromKey:@"publish_time"];
    _brokerNameArray = [self selectFromKey:@"broker_name"];
    _brokerTelArray = [self selectFromKey:@"broker_tel"];
    _xiaoquArray = [self selectFromKey:@"xiaoqu"];
}

- (void)topViewInit
{
    
    _topView =[[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.09*SCREEN_HEIGHT)];
    _topView.topLabel.text = @"喜欢的房源";
    _topView.returnButton.hidden = YES;
    [self addSubview:_topView];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"titlecount is %d",(int)_titleArray.count);
    return [_titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellName=@"123";
    
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
    cell.priceLabel.text = [[_priceArray objectAtIndex:indexPath.row] stringByAppendingString:@"元/月"]  ;
    cell.roomLabel.text = [_roomArray objectAtIndex:indexPath.row];
    if ([PicLoadEnableSharedClass newInstance].WWANLoadPicEnabled == YES) {
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
            
        }else
        {
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (void)reloadTableViewData:(NSMutableArray*)titleArray address:(NSMutableArray*)addressArray price:(NSMutableArray*)priceArray room:(NSMutableArray*)roomArray priURL:(NSMutableArray*)picURLArray config:(NSMutableArray*)configArray description:(NSMutableArray*)descriptionArray publishTime:(NSMutableArray*)publishTimeArray brokerName:(NSMutableArray*)brokerNameArray brokerTel:(NSMutableArray*)brokerTelArray xiaoqu:(NSMutableArray *)xiaoquArray
{
    _titleArray =  titleArray;
    _addressArray = addressArray;
    _priceArray = priceArray;
    _roomArray = roomArray;
    _picURLArray = picURLArray;
    _configArray = configArray;
    _descriptionArray = descriptionArray;
    _publishTimeArray = publishTimeArray;
    _brokerNameArray = brokerNameArray;
    _brokerTelArray = brokerTelArray;
    _xiaoquArray = xiaoquArray;
    [_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cool");
    HouseDetailView *detail = [[HouseDetailView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
//    [detail.returnButton addTarget:self action:@selector(cancelDetailView:) forControlEvents:UIControlEventTouchUpInside];
    detail.typeInt = 2;
    [detail.topView.returnButton addTarget:self action:@selector(cancelDetailView:) forControlEvents:UIControlEventTouchUpInside];
    detail.collectBtn.hidden = YES;
    detail.deleteBtn.hidden = NO;
    detail.tag = 99;
    [self addSubview:detail];
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [detail.layer addAnimation:animation forKey:@"transView"];
    [detail.deleteBtn addTarget:self action:@selector(deleteToDB) forControlEvents:UIControlEventTouchUpInside];
    [detail transTitle:[_titleArray objectAtIndex:indexPath.row] price:[_priceArray objectAtIndex:indexPath.row] type:[_roomArray objectAtIndex:indexPath.row] config:[_configArray objectAtIndex:indexPath.row] description:[_descriptionArray objectAtIndex:indexPath.row] address:[_addressArray objectAtIndex:indexPath.row] publishTime:[_publishTimeArray objectAtIndex:indexPath.row] imageURL:[_picURLArray objectAtIndex:indexPath.row] broker_name:[_brokerNameArray objectAtIndex:indexPath.row] broker_tel:[_brokerTelArray objectAtIndex:indexPath.row] xiaoqu:[_xiaoquArray objectAtIndex:indexPath.row]];
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    _titleString = [NSString stringWithString:[_titleArray objectAtIndex:indexPath.row]];
    
    detail.scrollView.frame = CGRectMake(0, 0.09*SCREEN_HEIGHT, SCREEN_WIDTH, 0.82*SCREEN_HEIGHT);
}


- (void)deleteToDB
{
//    NSLog(@"Favorite delete");
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *house = [NSEntityDescription entityForName:@"HouseEntity" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:house];
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    //    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSManagedObject *entity in resultArray) {
        if ([[entity valueForKey:@"title_detail"] isEqualToString: _titleString]) {
            if (entity) {
                [context deleteObject:entity];
                [context save:nil];
                
                [_titleArray removeAllObjects];
                [_addressArray removeAllObjects];
                [_priceArray removeAllObjects];
                [_roomArray removeAllObjects];
                [_picURLArray removeAllObjects];
                [_configArray removeAllObjects];
                [_descriptionArray removeAllObjects];
                [_publishTimeArray removeAllObjects];
                [_xiaoquArray removeAllObjects];
                
                _titleArray = [self selectFromKey:@"title_detail"];
                _addressArray = [self selectFromKey:@"address"];
                _priceArray = [self selectFromKey:@"price"];
                _roomArray = [self selectFromKey:@"house_type"];
                _picURLArray = [self selectFromKey:@"pic_urls"];
                _configArray = [self selectFromKey:@"config"];
                _descriptionArray = [self selectFromKey:@"house_description"];
                _publishTimeArray = [self selectFromKey:@"publish_time"];
                _xiaoquArray = [self selectFromKey:@"xiaoqu"];
                
                [_tableView reloadData];
                for (UIView* view in [self subviews]) {
                    if ([view.class isSubclassOfClass:[HouseDetailView class]]) {
//                        NSLog(@"cool view");
                        [view removeFromSuperview];
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除" message:@"删除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [alert show];
                    }
                }
                
            }
        }
    }
    
//    NSLog(@"titlecount is %d",(int)_titleArray.count);
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
        [array addObject:[entity valueForKey:key]];
    }
    return array;
}

- (void)cancelDetailView:(UIButton*)btn
{
    for (UIView *child in self.subviews){
        if (child.tag == 99) {
            [child setFrame:CGRectMake(CGRectGetWidth(self.bounds), 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
            CATransition *animation = [CATransition animation];
            [animation setDuration:0.5];
            [animation setType:kCATransitionPush];
            [animation setSubtype:kCATransitionFromLeft];
            [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [child.layer addAnimation:animation forKey:@"cancelView"];
        }
        
    }
    
}

@end
