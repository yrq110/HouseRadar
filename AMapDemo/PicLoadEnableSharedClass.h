//
//  PicLoadEnableSharedClass.h
//  AMapDemo
//
//  Created by yrq_mac on 16/2/16.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PicLoadEnableSharedClass : NSObject

@property BOOL WWANLoadPicEnabled;
@property BOOL MobileNetLoadEnabled;
@property BOOL isWifi;
@property BOOL isNightMode;

+ (PicLoadEnableSharedClass*)newInstance;

@end
