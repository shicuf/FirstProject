//
//  YR_LoginUserModel.h
//  PinkGirl
//
//  Created by dllo on 16/09/14
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_LoginImModel;

@interface YR_LoginUserModel : YR_BaseModel

@property (nonatomic, copy) NSString *rank;

@property (nonatomic, copy) NSString *session_id;

@property (nonatomic, copy) NSString *login_type;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *is_cooperative;

@property (nonatomic, copy) NSString *uname;

@property (nonatomic, copy) NSString *is_kill;

@property (nonatomic, strong) NSNumber *rank_points;

@property (nonatomic, copy) NSString *cover;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, copy) NSString *domain;

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *is_passwd;

@property (nonatomic, strong) YR_LoginImModel *im;

@property (nonatomic, copy) NSString *thead;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *is_verfiy;

@property (nonatomic, strong) NSNumber *rank_ponits;

@property (nonatomic, assign) BOOL disMsg;

@property (nonatomic, copy) NSString *is_vertify;

@end