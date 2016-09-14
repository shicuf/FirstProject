//
//  YR_PurchaseModel.h
//  Artand
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_PurchaseListModel,YR_PurchasePicModel,YR_PurchaseSizeModel,YR_PurchaseAuthModel,YR_PurchaseExtralModel,YR_PurchasePicsModel;

@interface YR_PurchaseModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSArray<YR_PurchaseListModel *> *list;

@property (nonatomic, assign) BOOL isCache;

@property (nonatomic, strong) NSNumber *last_id;

@property (nonatomic, copy) NSString *time;

@end