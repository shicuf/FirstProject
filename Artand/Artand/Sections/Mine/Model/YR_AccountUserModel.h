//
//  YR_AccountUserModel.h
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_AccountSyncModel,YR_AccountBirthdayModel;

@interface YR_AccountUserModel : YR_BaseModel

@property (nonatomic, copy) NSString *account;

@property (nonatomic, strong) YR_AccountBirthdayModel *birthday;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, copy) NSString *rank_points;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *is_allow_view_liked;

@property (nonatomic, copy) NSString *role_name;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *address_id;

@property (nonatomic, copy) NSString *gender;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, strong) YR_AccountSyncModel *sync;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *is_verfiy;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *address;

@end