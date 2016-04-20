//
//  HistoryView.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/10.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "HistoryView.h"
#import "PicLoadEnableSharedClass.h"
#import "CompareView.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)
@implementation HistoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self topViewInit];
        [self topTipViewInit];
        [self mainViewInit];
        
    }
    return self;
}

- (void)mainViewInit
{
    int count = 0;
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *house = [NSEntityDescription entityForName:@"CompareEntity" inManagedObjectContext:context];
    int initY;
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:house];
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    if (count==0) {
        initY = 1;
    }else{
        initY = 0;
    }
    for (NSManagedObject *entity in resultArray) {
        CompareView *comView = [[CompareView alloc]initWithFrame:CGRectMake(0, 0.145*SCREEN_HEIGHT+count*0.075*SCREEN_HEIGHT-5*count-5*initY, SCREEN_WIDTH, 0.075*SCREEN_HEIGHT)];
        comView.xiaoquLabel.text = [entity valueForKey:@"xiaoqu"];
        comView.priceLabel.text = [entity valueForKey:@"price"];
        comView.typeLabel.text = [entity valueForKey:@"house_type"];
        [comView.typeLabel sizeToFit];
        CGRect rectT=comView.typeLabel.frame;
        rectT.size.height= 0.075*SCREEN_HEIGHT-10;
        comView.typeLabel.frame=rectT;
        [comView.typeScrollView setContentSize:CGSizeMake(comView.typeLabel.frame.size.width, 0.075*SCREEN_HEIGHT-10)];
        
        if ([[entity valueForKey:@"pic_url"] isEqualToString:@"暂无数据"]) {
            comView.houseImageView.image = [UIImage imageNamed:@"pic_nil.jpg"];
        }else{
            [comView.houseImageView sd_setImageWithURL:[NSURL URLWithString:[entity valueForKey:@"pic_url"]]];
        }
        [self addSubview:comView];
        [comView.deleteBtn addTarget:self action:@selector(deleteToDB) forControlEvents:UIControlEventTouchUpInside];
        
        count++;
    }
}


- (void)topViewInit
{
    _topView =[[TopView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.09*SCREEN_HEIGHT)];
    _topView.topLabel.text = @"对比";
    _topView.returnButton.hidden = YES;
    [self addSubview:_topView];
    
}

- (void)selectAll
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *house = [NSEntityDescription entityForName:@"CompareEntity" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:house];
    NSArray *resultArray = [context executeFetchRequest:request error:nil];
    
    for (NSManagedObject *entity in resultArray) {
        NSLog(@"%@ %@ %@ %@",[entity valueForKey:@"house_type"],[entity valueForKey:@"price"],[entity valueForKey:@"xiaoqu"],[entity valueForKey:@"pic_url"]);
    }
    
}

- (void)topTipViewInit
{
    UIView *colorLineBottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0.09*SCREEN_HEIGHT, SCREEN_WIDTH, 0.055*SCREEN_HEIGHT)];
    [colorLineBottom setBackgroundColor:[UIColor whiteColor]];
    [colorLineBottom.layer setMasksToBounds:YES];
    [colorLineBottom.layer setBorderWidth:5.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref;
    colorref = CGColorCreate(colorSpace, (CGFloat[]){250.0/255.0,235.0/255.0,215.0/255.0,1});
    [colorLineBottom.layer setBorderColor:colorref];
    [self addSubview:colorLineBottom];

    UILabel *picLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0.09*SCREEN_HEIGHT+5, 80, 0.055*SCREEN_HEIGHT-10)];
    picLabel.text = @"图片";
    picLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:picLabel];
    UIView *subField1 = [[UIView alloc]initWithFrame:CGRectMake(90, 0.09*SCREEN_HEIGHT+5, 5, 0.055*SCREEN_HEIGHT-10)];
    [subField1 setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:235.0/255.0 blue:215.0/255.0 alpha:1]];
    [self addSubview:subField1];
    

    UILabel *xiaoquLabel = [[UILabel alloc]initWithFrame:CGRectMake(95, 0.09*SCREEN_HEIGHT+5, 90, 0.055*SCREEN_HEIGHT-10)];
    xiaoquLabel.text = @"小区";
    xiaoquLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:xiaoquLabel];
    UIView *subField2 = [[UIView alloc]initWithFrame:CGRectMake(190, 0.09*SCREEN_HEIGHT+5, 5, 0.055*SCREEN_HEIGHT-10)];
    [subField2 setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:235.0/255.0 blue:215.0/255.0 alpha:1]];
    [self addSubview:subField2];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(195, 0.09*SCREEN_HEIGHT+5, 65, 0.055*SCREEN_HEIGHT-10)];
    priceLabel.text = @"租金";
    priceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:priceLabel];
    UIView *subField3 = [[UIView alloc]initWithFrame:CGRectMake(265, 0.09*SCREEN_HEIGHT+5, 5, 0.055*SCREEN_HEIGHT-10)];
    [subField3 setBackgroundColor:[UIColor colorWithRed:250.0/255.0 green:235.0/255.0 blue:215.0/255.0 alpha:1]];
    [self addSubview:subField3];
    
    UILabel *typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(270, 0.09*SCREEN_HEIGHT+5, 100, 0.055*SCREEN_HEIGHT-10)];
    typeLabel.text = @"户型";
    typeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:typeLabel];

}

- (void)deleteToDB
{
    NSLog(@"deleteDB");
    
    for (UIView *view in [self subviews]) {
        if ([view isKindOfClass:[CompareView class]]) {
            [view removeFromSuperview];
        }
    }
    [self mainViewInit];
}

@end
