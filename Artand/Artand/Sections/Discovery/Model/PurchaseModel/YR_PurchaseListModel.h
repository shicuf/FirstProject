//
//  YR_PurchaseListModel.h
//  Artand
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_PurchasePicModel,YR_PurchaseSizeModel,YR_PurchaseAuthModel,YR_PurchaseExtralModel,YR_PurchasePicsModel;

@interface YR_PurchaseListModel : YR_BaseModel

@property (nonatomic, copy) NSString *is_block;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *owner_id;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) NSNumber *vv;

@property (nonatomic, copy) NSString *is_secret;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, copy) NSString *work_type;

@property (nonatomic, strong) NSNumber *h;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *goods_num;

@property (nonatomic, strong) YR_PurchaseSizeModel *size;

@property (nonatomic, strong) NSNumber *w;

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *row_type;

@property (nonatomic, strong) YR_PurchaseAuthModel *auth;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *times;

@property (nonatomic, strong) YR_PurchasePicModel *pic;

@property (nonatomic, strong) NSArray<YR_PurchasePicsModel *> *pics;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *row_id;

@property (nonatomic, copy) NSString *mark;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *is_sale;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *bj;

@end