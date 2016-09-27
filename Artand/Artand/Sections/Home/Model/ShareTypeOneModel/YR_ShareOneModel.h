//
//  YR_ShareOneModel.h
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/27
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ShareOneShareModel,YR_ShareOneMomentsModel,YR_ShareOneWechatModel,YR_ShareOneNormalModel,YR_ShareOneSinaModel;

@interface YR_ShareOneModel : YR_BaseModel

@property (nonatomic, strong) YR_ShareOneShareModel *share;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSNumber *code;

@end