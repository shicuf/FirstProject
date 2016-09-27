//
//  YR_ArtCircleLikedModel.h
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArtCircleInUserModel;

@interface YR_ArtCircleLikedModel : YR_BaseModel

@property (nonatomic, strong) YR_ArtCircleInUserModel *user;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *topic_id;

@end