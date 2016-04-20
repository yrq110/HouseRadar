//
//  PicLoadEnableSharedClass.m
//  AMapDemo
//
//  Created by yrq_mac on 16/2/16.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//

#import "PicLoadEnableSharedClass.h"
#import "Reachability.h"
@implementation PicLoadEnableSharedClass


static PicLoadEnableSharedClass *sharedInstance;
+ (PicLoadEnableSharedClass*)newInstance
{
    if (sharedInstance == nil) {
        sharedInstance = [[PicLoadEnableSharedClass alloc]init];
    }
    return sharedInstance;
}

- (id)init
{
    if (sharedInstance) {
        return sharedInstance;
    }
    if (self = [super init]) {
        _WWANLoadPicEnabled = YES;
        _MobileNetLoadEnabled = YES;
        _isNightMode = NO;
        Reachability *r = [Reachability reachabilityWithHostName:@"www.apple.com"];
        if ([r currentReachabilityStatus]==ReachableViaWiFi) {
            _isWifi = YES;
        }else{
            _isWifi = NO;
        }
    }
    return self;
}
@end
