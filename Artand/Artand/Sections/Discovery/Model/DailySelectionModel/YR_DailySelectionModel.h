//
//  YR_DailySelectionModel.h
//  Artand
//
//  Created by dllo on 16/09/03
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_DailySelectionListModel;

@interface YR_DailySelectionModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSNumber *next_time;

@property (nonatomic, strong) NSArray<YR_DailySelectionListModel *> *list;

@property (nonatomic, strong) NSNumber *last_id;

@property (nonatomic, copy) NSString *time;

@end