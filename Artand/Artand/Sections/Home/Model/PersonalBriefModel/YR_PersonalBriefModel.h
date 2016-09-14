//
//  YR_PersonalBriefModel.h
//  Artand
//
//  Created by Dendi on 16/09/11
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_PersonalBriefOwnerModel,YR_PersonalBriefResumeModel,YR_PersonalBriefLikedModel,YR_PersonalBriefRewardModel;

@interface YR_PersonalBriefModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) YR_PersonalBriefResumeModel *resume;

@property (nonatomic, strong) NSNumber *is_reward;

@property (nonatomic, strong) YR_PersonalBriefRewardModel *reward;

@property (nonatomic, strong) YR_PersonalBriefOwnerModel *owner;

@end