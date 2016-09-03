//
//  YR_ArtDetailModel.m
//  cbsSegmentView
//
//  Created by dllo on 16/09/01
//  Copyright (c) cbs. All rights reserved.
//

#import "YR_ArtDetailModel.h"
#import "YR_ArtDetailLikesModel.h"
#import "YR_ArtDetailOwnerModel.h"
#import "YR_ArtDetailWorkModel.h"

@implementation YR_ArtDetailModel

+ (NSDictionary *)objectClassInArray{
    return @{@"likes" : [YR_ArtDetailLikesModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"owner"]) {
        YR_ArtDetailOwnerModel *owner = [YR_ArtDetailOwnerModel modelWithDict:value];
        _owner = owner;
    }
    if ([key isEqualToString:@"work"]) {
        YR_ArtDetailWorkModel *work = [YR_ArtDetailWorkModel modelWithDict:value];
        _work = work;
    }
    if ([key isEqualToString:@"likes"]) {
        NSMutableArray<YR_ArtDetailLikesModel *> *likesArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ArtDetailLikesModel *likes = [YR_ArtDetailLikesModel modelWithDict:dic];
            [likesArr addObject:likes];
        }
        _likes = likesArr;
    }
    
}

@end
