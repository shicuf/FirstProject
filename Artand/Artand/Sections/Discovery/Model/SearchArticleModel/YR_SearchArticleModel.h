//
//  YR_SearchArticleModel.h
//  Artand
//
//  Created by dllo on 16/09/22
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_SearchArticleListModel,YR_SearchArticleUserModel;

@interface YR_SearchArticleModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSArray<YR_SearchArticleListModel *> *list;

@property (nonatomic, strong) NSNumber *last_id;

@property (nonatomic, copy) NSString *q;

@end