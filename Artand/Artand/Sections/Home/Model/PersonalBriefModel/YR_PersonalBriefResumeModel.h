//
//  YR_PersonalBriefResumeModel.h
//  Artand
//
//  Created by Dendi on 16/09/11
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_PersonalBriefLikedModel;

@interface YR_PersonalBriefResumeModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *num_view;

@property (nonatomic, copy) NSString *resume;

@property (nonatomic, assign) BOOL is_liked;

@property (nonatomic, strong) NSArray<YR_PersonalBriefLikedModel *> *liked;

@property (nonatomic, copy) NSString *num_comment;

@property (nonatomic, copy) NSString *num_liked;

@end