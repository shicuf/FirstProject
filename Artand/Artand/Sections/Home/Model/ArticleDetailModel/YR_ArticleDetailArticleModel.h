//
//  YR_ArticleDetailArticleModel.h
//  Artand
//
//  Created by Dendi on 16/09/05
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArticleDetailUserModel,YR_ArticleDetailLikedModel;

@interface YR_ArticleDetailArticleModel : YR_BaseModel

@property (nonatomic, copy) NSString *is_block;

@property (nonatomic, strong) NSArray<YR_ArticleDetailLikedModel *> *liked;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, copy) NSString *artid;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, assign) BOOL is_liked;

@property (nonatomic, strong) NSNumber * num_liked;

@property (nonatomic, copy) NSString *version;

@property (nonatomic, strong) NSNumber * is_ownr;

@property (nonatomic, copy) NSString *type;

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *is_show_feed;

@property (nonatomic, copy) NSString *row_type;

@property (nonatomic, strong) NSNumber * num_comment;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *subtitle;

@property (nonatomic, strong) YR_ArticleDetailUserModel *user;

@property (nonatomic, copy) NSString *is_show_home;

@property (nonatomic, copy) NSString *num_view;

@property (nonatomic, copy) NSString *content1;

@property (nonatomic, copy) NSString *create_ip;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, strong) NSArray *comment;

@property (nonatomic, copy) NSString *content;

@end