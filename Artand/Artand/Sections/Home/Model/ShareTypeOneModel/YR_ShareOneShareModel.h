//
//  YR_ShareOneShareModel.h
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/27
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ShareOneMomentsModel,YR_ShareOneWechatModel,YR_ShareOneNormalModel,YR_ShareOneSinaModel;

@interface YR_ShareOneShareModel : YR_BaseModel

@property (nonatomic, strong) YR_ShareOneMomentsModel *moments;

@property (nonatomic, strong) YR_ShareOneWechatModel *wechat;

@property (nonatomic, strong) YR_ShareOneNormalModel *normal;

@property (nonatomic, strong) YR_ShareOneSinaModel *sina;

@property (nonatomic, copy) NSString *url;

@end