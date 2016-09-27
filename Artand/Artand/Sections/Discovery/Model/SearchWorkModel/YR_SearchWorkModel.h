//
//  YR_SearchWorkModel.h
//  Artand
//
//  Created by dllo on 16/09/22
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_SearchWorkListModel,YR_SearchWorkSizeModel,YR_SearchWorkUserModel,YR_SearchWorkCateModel,YR_SearchWorkPicsModel;

@interface YR_SearchWorkModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSArray<YR_SearchWorkListModel *> *list;

@property (nonatomic, strong) NSNumber *last_id;

@property (nonatomic, copy) NSString *q;

@end