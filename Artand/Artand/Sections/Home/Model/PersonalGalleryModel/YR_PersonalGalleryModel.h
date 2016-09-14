//
//  YR_PersonalGalleryModel.h
//  Artand
//
//  Created by dllo on 16/09/12
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_PersonalGalleryListModel;

@interface YR_PersonalGalleryModel : YR_BaseModel

@property (nonatomic, strong) NSArray<YR_PersonalGalleryListModel *> *list;

@property (nonatomic, strong) NSNumber *code;

@end