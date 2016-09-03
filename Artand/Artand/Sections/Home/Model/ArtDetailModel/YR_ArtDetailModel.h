//
//  YR_ArtDetailModel.h
//  cbsSegmentView
//
//  Created by dllo on 16/09/01
//  Copyright (c) cbs. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArtDetailOwnerModel,YR_ArtDetailWorkModel,YR_ArtDetailPicModel,YR_ArtDetailSizeModel,YR_ArtDetailPicsModel,YR_ArtDetailLikesModel;

@interface YR_ArtDetailModel : YR_BaseModel

@property (nonatomic, strong) YR_ArtDetailOwnerModel *owner;

@property (nonatomic, strong) YR_ArtDetailWorkModel *work;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, copy) NSString *collector;

@property (nonatomic, strong) NSArray<YR_ArtDetailLikesModel *> *likes;

@property (nonatomic, strong) NSArray *comment;

@end