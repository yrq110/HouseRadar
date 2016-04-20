//
//  HouseEntity+CoreDataProperties.h
//  AMapDemo
//
//  Created by yrq_mac on 16/3/1.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HouseEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface HouseEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *address;
@property (nullable, nonatomic, retain) NSString *broker_name;
@property (nullable, nonatomic, retain) NSString *broker_tel;
@property (nullable, nonatomic, retain) NSString *config;
@property (nullable, nonatomic, retain) NSString *house_description;
@property (nullable, nonatomic, retain) NSString *house_type;
@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) id pic_urls;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *publish_time;
@property (nullable, nonatomic, retain) NSString *title_detail;
@property (nullable, nonatomic, retain) NSString *xiaoqu;

@end

NS_ASSUME_NONNULL_END
