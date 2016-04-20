//
//  ListTableViewCell.m
//  AMapDemo
//
//  Created by yrq_mac on 16/1/30.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "ListTableViewCell.h"
#define SCREEN_WIDTH    ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT   ([[UIScreen mainScreen] bounds].size.height)

@implementation ListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0.893*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:22.0];
        [_titleLabel setTextColor:[UIColor blueColor]];
        
        _titleScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0533*SCREEN_WIDTH, 0, 0.893*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT)];
        [_titleScrollView addSubview:_titleLabel];
        _titleScrollView.showsVerticalScrollIndicator = NO;
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.bounces = NO;
        [self addSubview:_titleScrollView];
        
        _publishTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.667*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT, 0.32*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        [_publishTimeLabel setTextAlignment:NSTextAlignmentCenter];
        [_publishTimeLabel setTextColor:[UIColor whiteColor]];
        [_publishTimeLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:18.0]];
        [_publishTimeLabel setBackgroundColor:[UIColor colorWithRed:0 green:189.0/255.0 blue:189.0/255.0 alpha:1]];
        [_publishTimeLabel.layer setCornerRadius:12.0];
        [_publishTimeLabel.layer setMasksToBounds:YES];
        [self addSubview:_publishTimeLabel];
        
        _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.293*SCREEN_WIDTH, 0.12*SCREEN_HEIGHT, 0.4*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        [_cityLabel setTextAlignment:NSTextAlignmentCenter];
        _cityLabel.font = [UIFont systemFontOfSize:18.0];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.32*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT, 0.32*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        [_priceLabel setTextAlignment:NSTextAlignmentCenter];
        _priceLabel.font = [UIFont systemFontOfSize:18.0];
        [_priceLabel setTextColor:[UIColor whiteColor]];
        [_priceLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:18.0]];
        [_priceLabel setBackgroundColor:[UIColor orangeColor]];
        [_priceLabel.layer setCornerRadius:12.0];
        [_priceLabel.layer setMasksToBounds:YES];
        [self addSubview:_priceLabel];
        
        _roomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.32*SCREEN_WIDTH, 0.12*SCREEN_HEIGHT, 0.667*SCREEN_WIDTH, 0.045*SCREEN_HEIGHT)];
        [_roomLabel setTextAlignment:NSTextAlignmentCenter];
        [_roomLabel setTextColor:[UIColor whiteColor]];
        [_roomLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:18.0]];
        [_roomLabel setBackgroundColor:[UIColor colorWithRed:57.0/255.0 green:173.0/255.0 blue:37.0/255.0 alpha:1]];
        [_roomLabel.layer setCornerRadius:12.0];
        [_roomLabel.layer setMasksToBounds:YES];
        [self addSubview:_roomLabel];
        
        _clickButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _clickButton.frame = CGRectMake(0, 0.32*SCREEN_HEIGHT, 0.045*SCREEN_HEIGHT, 0.045*SCREEN_HEIGHT);
        [_clickButton setTitle:@"click" forState:UIControlStateNormal];
        
        _houseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0267*SCREEN_WIDTH, 0.06*SCREEN_HEIGHT, 0.267*SCREEN_WIDTH, 0.105*SCREEN_HEIGHT)];
        _houseImageView.image = [UIImage imageNamed:@"pic_nil.jpg"];
        [self addSubview:_houseImageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
