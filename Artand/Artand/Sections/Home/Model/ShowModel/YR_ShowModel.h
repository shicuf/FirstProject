//
//  YR_ShowModel.h
//  Artand
//
//  Created by Dendi on 16/08/30
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ShowListModel,YR_ShowUserModel;

@interface YR_ShowModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSArray<YR_ShowListModel *> *list;

@property (nonatomic, strong) NSNumber *last_id;

@property (nonatomic, copy) NSString *time;

@end