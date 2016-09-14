//
//  YR_PersonalBriefModel.m
//  Artand
//
//  Created by Dendi on 16/09/11
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_PersonalBriefModel.h"
#import "YR_PersonalBriefResumeModel.h"
#import "YR_PersonalBriefRewardModel.h"
#import "YR_PersonalBriefOwnerModel.h"

@implementation YR_PersonalBriefModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"resume"]) {
        YR_PersonalBriefResumeModel *resume = [YR_PersonalBriefResumeModel modelWithDict:value];
        _resume = resume;
    }
    if ([key isEqualToString:@"reward"]) {
        YR_PersonalBriefRewardModel *reward = [YR_PersonalBriefRewardModel modelWithDict:value];
        _reward = reward;
    }
    if ([key isEqualToString:@"owner"]) {
        YR_PersonalBriefOwnerModel *owner = [YR_PersonalBriefOwnerModel modelWithDict:value];
        _owner = owner;
    }
}

@end
