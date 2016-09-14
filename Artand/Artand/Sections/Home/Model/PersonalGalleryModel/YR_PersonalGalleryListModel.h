//
//  YR_PersonalGalleryListModel.h
//  Artand
//
//  Created by dllo on 16/09/12
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@interface YR_PersonalGalleryListModel : YR_BaseModel

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *collection_id;

@property (nonatomic, copy) NSString *cover_type;

@property (nonatomic, copy) NSString *cover_id;

@property (nonatomic, copy) NSString *num_work;

@property (nonatomic, copy) NSString *cover_row;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *atime;

@end