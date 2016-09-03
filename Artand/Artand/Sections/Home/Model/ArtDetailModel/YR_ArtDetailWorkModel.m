//
//  YR_ArtDetailWorkModel.m
//  cbsSegmentView
//
//  Created by dllo on 16/09/01
//  Copyright (c) cbs. All rights reserved.
//

#import "YR_ArtDetailWorkModel.h"
#import "YR_ArtDetailPicsModel.h"
#import "YR_ArtDetailPicModel.h"
#import "YR_ArtDetailSizeModel.h"

@implementation YR_ArtDetailWorkModel

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [YR_ArtDetailPicsModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"pics"]) {
        NSMutableArray<YR_ArtDetailPicsModel *> *picsArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ArtDetailPicsModel *pics = [YR_ArtDetailPicsModel modelWithDict:dic];
            [picsArr addObject:pics];
        }
        _pics = picsArr;
    }
    if ([key isEqualToString:@"pic"]) {
        YR_ArtDetailPicModel *pic = [YR_ArtDetailPicModel modelWithDict:value];
        _pic = pic;
    }
    if ([key isEqualToString:@"size"]) {
        YR_ArtDetailSizeModel *size = [YR_ArtDetailSizeModel modelWithDict:value];
        _size = size;
    }
}

@end
