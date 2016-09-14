//
//  YR_PersonalSaleModel.h
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/13
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_PersonalSaleListModel,YR_PersonalSaleCateModel;

@interface YR_PersonalSaleModel : YR_BaseModel

@property (nonatomic, strong) NSArray<YR_PersonalSaleListModel *> *list;

@property (nonatomic, copy) NSString *last_id;

@property (nonatomic, assign) NSInteger code;

@end