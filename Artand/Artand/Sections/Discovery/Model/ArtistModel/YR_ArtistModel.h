//
//  YR_ArtistModel.h
//  __PRODUCTNAME__
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArtistListModel,YR_ArtistOutUserModel,YR_ArtistWorksModel,YR_ArtistPicModel,YR_ArtistInUserModel,YR_ArtistAuthModel,YR_ArtistPicsModel;

@interface YR_ArtistModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSArray<YR_ArtistListModel *> *list;

@property (nonatomic, strong) NSNumber *last_id;

@property (nonatomic, copy) NSString *time;

@end