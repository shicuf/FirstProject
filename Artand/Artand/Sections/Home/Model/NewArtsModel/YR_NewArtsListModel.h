//
//  YR_NewArtsListModel.h
//  Artand
//
//  Created by dllo on 16/08/30
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_NewArtsPicModel,YR_NewArtsAuthModel,YR_NewArtsExtralModel,YR_NewArtsPicsModel;

@interface YR_NewArtsListModel : YR_BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *owner_id;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) NSNumber *vv;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *goods_num;

@property (nonatomic, copy) NSString *row_type;

@property (nonatomic, strong) YR_NewArtsAuthModel *auth;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *times;

@property (nonatomic, strong) YR_NewArtsPicModel *pic;

@property (nonatomic, copy) NSString *size_label;

@property (nonatomic, strong) NSArray<YR_NewArtsPicsModel *> *pics;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *row_id;

@property (nonatomic, copy) NSString *mark;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *is_sale;

@end