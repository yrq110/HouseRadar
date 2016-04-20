//
//  CompareEntity+CoreDataProperties.h
//  AMapDemo
//
//  Created by yrq_mac on 16/3/1.
//  Copyright © 2016年 yrq_mac. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CompareEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface CompareEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *house_type;
@property (nullable, nonatomic, retain) NSString *pic_url;
@property (nullable, nonatomic, retain) NSString *price;
@property (nullable, nonatomic, retain) NSString *xiaoqu;

@end

NS_ASSUME_NONNULL_END
