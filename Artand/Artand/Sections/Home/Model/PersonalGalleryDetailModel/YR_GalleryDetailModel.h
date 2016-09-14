//
//  YR_GalleryDetailModel.h
//  Artand
//
//  Created by Dendi on 16/09/13
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_GalleryDetailCollectionModel,YR_GalleryDetailListModel,YR_GalleryDetailCateModel;

@interface YR_GalleryDetailModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) YR_GalleryDetailCollectionModel *collection;

@property (nonatomic, strong) NSArray<YR_GalleryDetailListModel *> *list;

@property (nonatomic, strong) NSNumber *last_id;

@property (nonatomic, copy) NSString *time;

@end