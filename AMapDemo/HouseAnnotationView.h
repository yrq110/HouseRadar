//
//  HouseAnnotationView.h
//  AMapDemo
//
//  Created by yrq_mac on 16/2/6.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "HouseCalloutView.h"
@interface HouseAnnotationView : MAPinAnnotationView
@property (nonatomic, readonly) HouseCalloutView *calloutView;
@end
