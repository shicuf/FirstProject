//
//  YR_ArtistWorksModel.h
//  __PRODUCTNAME__
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArtistPicModel,YR_ArtistInUserModel,YR_ArtistAuthModel,YR_ArtistPicsModel;

@interface YR_ArtistWorksModel : YR_BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *owner_id;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) NSNumber *vv;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *goods_num;

@property (nonatomic, copy) NSString *row_type;

@property (nonatomic, strong) YR_ArtistInUserModel *user;

@property (nonatomic, strong) YR_ArtistAuthModel *auth;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *times;

@property (nonatomic, strong) YR_ArtistPicModel *pic;

@property (nonatomic, copy) NSString *size_label;

@property (nonatomic, strong) NSArray<YR_ArtistPicsModel *> *pics;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *row_id;

@property (nonatomic, copy) NSString *mark;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *is_sale;

@end