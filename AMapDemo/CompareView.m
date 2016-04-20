//
//  CompareView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/29.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "CompareView.h"
#import "PicLoadEnableSharedClass.h"
#import "AppDelegate.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation CompareView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self listCellView];
        
    }
    return self;
}

- (void)listCellView
{
    UIView *colorLineBottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.075*SCREEN_HEIGHT)];
    [colorLineBottom setBackgroundColor:[UIColor whiteColor]];
    [colorLineBottom.layer setMasksToBounds:YES];
    [colorLineBottom.layer setBorderWidth:5.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref;
//    if ([PicLoadEnableSharedClass newInstance].isNightMode == NO) {
        //        NSLog(@"not nightmode");
    colorref = CGColorCreate(colorSpace, (CGFloat[]){250.0/255.0,235.0/255.0,215.0/255.0,1});
//    }else{
        //        NSLog(@"is nightmode");
//        colorref = CGColorCreate(colorSpace, (CGFloat[]){25.0/255.0,25.0/255.0,112.0/255.0,1});
//    }
    [colorLineBottom.layer setBorderColor:colorref];
//    [self addSubview:colorLineBottom];
    
    _houseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 85, 0.075*SCREEN_HEIGHT-10)];
    _houseImageView.image = [UIImage imageNamed:@"pic_nil.jpg"];
//    [self addSubview:_houseImageView];

    UIView *subField1 = [[UIView alloc]initWithFrame:CGRectMake(90, 5, 5, 0.075*SCREEN_HEIGHT-10)];
    [subField1 setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:235.0/255.0 blue:215.0/255.0 alpha:1]];
//    [self addSubview:subField1];
    
    
    _xiaoquLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 5, 90, 0.075*SCREEN_HEIGHT-10)];
//    _xiaoquLabel.text = @"111111111";
    _xiaoquLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_xiaoquLabel];
    UIView *subField2 = [[UIView alloc]initWithFrame:CGRectMake(190, 5, 5, 0.075*SCREEN_HEIGHT-10)];
    [subField2 setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:235.0/255.0 blue:215.0/255.0 alpha:1]];
//    [self addSubview:subField2];
    
    _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(195, 5, 65, 0.075*SCREEN_HEIGHT-10)];
//    _priceLabel.text = @"租金";
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_priceLabel];
    UIView *subField3 = [[UIView alloc]initWithFrame:CGRectMake(265, 5, 5, 0.075*SCREEN_HEIGHT-10)];
    [subField3 setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:235.0/255.0 blue:215.0/255.0 alpha:1]];
//    [self addSubview:subField3];
    
    _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 0.075*SCREEN_HEIGHT-10)];
//    _typeLabel.text = @"户型";
//    _typeLabel.textAlignment = NSTextAlignmentCenter;
//    [self addSubview:_typeLabel];
    
    _typeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(270, 5, 100, 0.075*SCREEN_HEIGHT-10)];
    [_typeScrollView addSubview:_typeLabel];
    _typeScrollView.showsVerticalScrollIndicator = NO;
    _typeScrollView.showsHorizontalScrollIndicator = NO;
//    [self addSubview:_typeScrollView];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _deleteBtn.frame = CGRectMake(SCREEN_WIDTH, 0, 60, 0.075*SCREEN_HEIGHT);
    [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18.0]];
    [_deleteBtn setBackgroundColor:[UIColor redColor]];
    [_deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteToDB) forControlEvents:UIControlEventTouchUpInside];
    
    _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.075*SCREEN_HEIGHT)];
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [_mainScrollView addSubview:colorLineBottom];
    [_mainScrollView addSubview:_houseImageView];
    [_mainScrollView addSubview:subField1];
    [_mainScrollView addSubview:_xiaoquLabel];
    [_mainScrollView addSubview:subField2];
    [_mainScrollView addSubview:_priceLabel];
    [_mainScrollView addSubview:subField3];
    [_mainScrollView addSubview:_typeScrollView];
    [_mainScrollView addSubview:_deleteBtn];
    [_mainScrollView setContentSize:CGSizeMake(SCREEN_WIDTH+60, 0.075*SCREEN_HEIGHT-10)];
    
    [self addSubview:_mainScrollView];
}

- (void)deleteToDB
{
    //    NSLog(@"Favorite delete");
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *house = [NSEntityDescription entityForName:@"CompareEntity" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:house];
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    //    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSManagedObject *entity in resultArray) {
        if ([[entity valueForKey:@"xiaoqu"] isEqualToString: _xiaoquLabel.text]) {
            if (entity) {
                NSLog(@"you got it");
                [context deleteObject:entity];
                [context save:nil];
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除" message:@"删除成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
//                [alert show];
            }
        }
    }
    //    NSLog(@"titlecount is %d",(int)_titleArray.count);
}

- (NSMutableArray*)selectFromKey:(NSString*)key
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *house = [NSEntityDescription entityForName:@"CompareEntity" inManagedObjectContext:context];
    
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
@end
