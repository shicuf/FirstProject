//
//  YR_SearchArticleListModel.h
//  Artand
//
//  Created by dllo on 16/09/22
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_SearchArticleUserModel;

@interface YR_SearchArticleListModel : YR_BaseModel

@property (nonatomic, copy) NSString *num_liked;

@property (nonatomic, copy) NSString *row_type;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *row_id;

@property (nonatomic, copy) NSString *is_block;

@property (nonatomic, copy) NSString *num_view;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, copy) NSString *num_comment;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, strong) YR_SearchArticleUserModel *user;

@end