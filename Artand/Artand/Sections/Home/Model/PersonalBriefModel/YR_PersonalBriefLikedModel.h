//
//  YR_PersonalBriefLikedModel.h
//  Artand
//
//  Created by Dendi on 16/09/11
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@interface YR_PersonalBriefLikedModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *num_followed;

@property (nonatomic, strong) NSNumber *num_work;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, copy) NSString *rank;

@property (nonatomic, copy) NSString *rank_points;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *is_verfiy;

@end