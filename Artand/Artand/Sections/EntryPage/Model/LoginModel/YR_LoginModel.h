//
//  YR_LoginModel.h
//  PinkGirl
//
//  Created by dllo on 16/09/14
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_LoginUserModel,YR_LoginImModel;

@interface YR_LoginModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, copy) NSString *session_id;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, strong) YR_LoginUserModel *user;

@end