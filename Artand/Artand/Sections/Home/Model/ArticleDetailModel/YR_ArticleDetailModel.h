//
//  YR_ArticleDetailModel.h
//  Artand
//
//  Created by Dendi on 16/09/05
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_ArticleDetailArticleModel,YR_ArticleDetailUserModel,YR_ArticleDetailLikedModel,YR_ArticleDetailRewardModel;

@interface YR_ArticleDetailModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSNumber *is_reward;

@property (nonatomic, strong) YR_ArticleDetailArticleModel *article;

@property (nonatomic, strong) YR_ArticleDetailRewardModel *reward;

@end