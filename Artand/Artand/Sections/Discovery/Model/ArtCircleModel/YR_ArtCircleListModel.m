//
//  YR_ArtCircleListModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_ArtCircleListModel.h"
#import "YR_ArtCircleLikedModel.h"
#import "YR_ArtCirclePicsModel.h"
#import "YR_ArtCircleOutUserModel.h"

@implementation YR_ArtCircleListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"liked" : [YR_ArtCircleLikedModel class], @"pics" : [YR_ArtCirclePicsModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"liked"]) {
        NSMutableArray<YR_ArtCircleLikedModel *> *likedArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ArtCircleLikedModel *liked = [YR_ArtCircleLikedModel modelWithDict:dic];
            [likedArr addObject:liked];
        }
        _liked = likedArr;
    }
    if ([key isEqualToString:@"pics"]) {
        NSMutableArray<YR_ArtCirclePicsModel *> *picsArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ArtCirclePicsModel *pics = [YR_ArtCirclePicsModel modelWithDict:dic];
            [picsArr addObject:pics];
        }
        _pics = picsArr;
    }
    if ([key isEqualToString:@"user"]) {
        YR_ArtCircleOutUserModel *user = [YR_ArtCircleOutUserModel modelWithDict:value];
        _user = user;
    }
}

@end
