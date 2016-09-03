//
//  YR_NewArtsModel.h
//  Artand
//
//  Created by dllo on 16/08/30
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_NewArtsListModel,YR_NewArtsPicModel,YR_NewArtsAuthModel,YR_NewArtsExtralModel,YR_NewArtsPicsModel;

@interface YR_NewArtsModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSArray<YR_NewArtsListModel *> *list;

@property (nonatomic, copy) NSString *last_id;

@property (nonatomic, copy) NSString *time;

@end