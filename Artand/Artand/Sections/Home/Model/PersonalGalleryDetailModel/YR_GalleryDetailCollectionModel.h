//
//  YR_GalleryDetailCollectionModel.h
//  Artand
//
//  Created by Dendi on 16/09/13
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@interface YR_GalleryDetailCollectionModel : YR_BaseModel

@property (nonatomic, copy) NSString *is_secret;

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *collection_id;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *cover_id;

@end