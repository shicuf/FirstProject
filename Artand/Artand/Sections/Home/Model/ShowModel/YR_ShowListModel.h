//
//  YR_ShowListModel.h
//  Artand
//
//  Created by Dendi on 16/08/30
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ShowUserModel;

@interface YR_ShowListModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *num_liked;

@property (nonatomic, copy) NSString *row_type;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *is_block;

@property (nonatomic, copy) NSString *row_id;

@property (nonatomic, strong) NSNumber *version;

@property (nonatomic, strong) NSNumber *is_liked;

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, strong) YR_ShowUserModel *user;

@property (nonatomic, strong) NSNumber *v;

@end