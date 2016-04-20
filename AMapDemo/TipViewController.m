//
//  TipViewController.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/24.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "TipViewController.h"
#import "ViewController.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

@interface TipViewController ()

@end

@implementation TipViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    UIImageView *initView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    initView.image = [UIImage imageNamed:@"welcome.jpg"];
    [self.view addSubview:initView];

}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"cool");
//    sleep(3);
    ViewController *view  = (ViewController*)[ViewController shareViewController];
    [self presentViewController:view animated:NO completion:nil];
}


- (void)enterMethod
{
    ViewController *view  = (ViewController*)[ViewController shareViewController];
    [self presentViewController:view animated:NO completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
