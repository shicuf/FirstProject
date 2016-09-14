//
//  YR_PersonalBriefOwnerModel.h
//  Artand
//
//  Created by Dendi on 16/09/11
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@interface YR_PersonalBriefOwnerModel : YR_BaseModel

@property (nonatomic, copy) NSString *rank;

@property (nonatomic, strong) NSNumber *num_about;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSNumber *is_artist;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, strong) NSNumber *num_followed;

@property (nonatomic, copy) NSString *is_kill;

@property (nonatomic, copy) NSString *rank_points;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, strong) NSNumber *num_liked;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, strong) NSNumber *num_work;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *is_verfiy;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *is_open_liked;

@property (nonatomic, copy) NSString *is_collect;

@end