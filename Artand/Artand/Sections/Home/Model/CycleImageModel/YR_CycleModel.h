//
//  YR_CycleModel.h
//  Artand
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_Ads;

@interface YR_CycleModel : YR_BaseModel

@property (nonatomic, strong) NSArray<YR_Ads *> *ads;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSNumber *code;

@end
