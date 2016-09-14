//
//  YR_PersonalBriefResumeModel.m
//  Artand
//
//  Created by Dendi on 16/09/11
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_PersonalBriefResumeModel.h"
#import "YR_PersonalBriefLikedModel.h"

@implementation YR_PersonalBriefResumeModel

+ (NSDictionary *)objectClassInArray{
    return @{@"liked" : [YR_PersonalBriefLikedModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"liked"]) {
        NSMutableArray<YR_PersonalBriefLikedModel *> *likedArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_PersonalBriefLikedModel *liked = [YR_PersonalBriefLikedModel modelWithDict:dic];
            [likedArr addObject:liked];
        }
        _liked = likedArr;
    }
}

@end
