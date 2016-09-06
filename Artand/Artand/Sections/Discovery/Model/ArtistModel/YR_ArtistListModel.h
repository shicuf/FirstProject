//
//  YR_ArtistListModel.h
//  __PRODUCTNAME__
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArtistOutUserModel,YR_ArtistWorksModel,YR_ArtistPicModel,YR_ArtistInUserModel,YR_ArtistAuthModel,YR_ArtistPicsModel;

@interface YR_ArtistListModel : YR_BaseModel

@property (nonatomic, strong) NSArray<YR_ArtistWorksModel *> *works;

@property (nonatomic, strong) YR_ArtistOutUserModel *user;

@end