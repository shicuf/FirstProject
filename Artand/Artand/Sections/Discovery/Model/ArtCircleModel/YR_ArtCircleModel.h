//
//  YR_ArtCircleModel.h
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArtCircleListModel,YR_ArtCircleOutUserModel,YR_ArtCircleLikedModel,YR_ArtCircleInUserModel,YR_ArtCirclePicsModel;

@interface YR_ArtCircleModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSArray<YR_ArtCircleListModel *> *list;

@property (nonatomic, strong) NSNumber *last_id;

@property (nonatomic, copy) NSString *time;

@end