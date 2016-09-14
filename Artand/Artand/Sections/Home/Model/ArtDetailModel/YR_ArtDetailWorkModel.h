//
//  YR_ArtDetailWorkModel.h
//  cbsSegmentView
//
//  Created by dllo on 16/09/01
//  Copyright (c) cbs. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArtDetailPicModel,YR_ArtDetailSizeModel,YR_ArtDetailPicsModel;

@interface YR_ArtDetailWorkModel : YR_BaseModel

@property (nonatomic, copy) NSString *is_delete;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *is_framed;

@property (nonatomic, copy) NSString *is_secured;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *num_show;

@property (nonatomic, strong) NSNumber *is_liked;

@property (nonatomic, strong) NSNumber *is_rewardable;

@property (nonatomic, strong) NSArray<YR_ArtDetailPicsModel *> *pics;

@property (nonatomic, strong) NSNumber *is_inquiry;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, strong) NSNumber *view;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *size_label;

@property (nonatomic, copy) NSString *is_sale;

@property (nonatomic, copy) NSString *album_id;

@property (nonatomic, copy) NSString *times;

@property (nonatomic, copy) NSString *mark;

@property (nonatomic, copy) NSString *work_type;

@property (nonatomic, strong) NSNumber *row_type;

@property (nonatomic, copy) NSString *num_view;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSNumber *num_liked;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *is_book;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) YR_ArtDetailSizeModel *size;

@property (nonatomic, copy) NSString *is_certificates;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *row_id;

@property (nonatomic, strong) YR_ArtDetailPicModel *pic;

@property (nonatomic, copy) NSString *owner_id;

@property (nonatomic, copy) NSString *is_edite;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, copy) NSString *num_comment;

@property (nonatomic, strong) NSNumber *is_buyable;

@end