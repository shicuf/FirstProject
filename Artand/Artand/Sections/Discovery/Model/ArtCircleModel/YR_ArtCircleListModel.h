//
//  YR_ArtCircleListModel.h
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArtCircleOutUserModel,YR_ArtCircleLikedModel,YR_ArtCircleInUserModel,YR_ArtCirclePicsModel;

@interface YR_ArtCircleListModel : YR_BaseModel

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray *remind_uid;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *is_liked;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) NSArray *remind;

@property (nonatomic, strong) NSArray *comment;

@property (nonatomic, copy) NSString *num_view;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, strong) NSArray<YR_ArtCircleLikedModel *> *liked;

@property (nonatomic, strong) YR_ArtCircleOutUserModel *user;

@property (nonatomic, strong) NSArray<YR_ArtCirclePicsModel *> *pics;

@property (nonatomic, copy) NSString *content;

@end