//
//  YR_PersonalPageModel.h
//  __PRODUCTNAME__
//
//  Created by Dendi on 16/09/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_PersonalPageOwnerModel,YR_PersonalPageListModel,YR_PersonalPageCateModel,YR_PersonalPagePicsModel;

@interface YR_PersonalPageModel : YR_BaseModel

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) YR_PersonalPageOwnerModel *owner;

@property (nonatomic, strong) NSArray<YR_PersonalPageListModel *> *list;

@property (nonatomic, assign) NSInteger last_id;

@end