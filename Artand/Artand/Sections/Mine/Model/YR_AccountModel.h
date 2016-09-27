//
//  YR_AccountModel.h
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_AccountUserModel,YR_AccountSyncModel,YR_AccountBirthdayModel;

@interface YR_AccountModel : YR_BaseModel

@property (nonatomic, strong) YR_AccountUserModel *user;

@property (nonatomic, strong) NSNumber *code;

@end