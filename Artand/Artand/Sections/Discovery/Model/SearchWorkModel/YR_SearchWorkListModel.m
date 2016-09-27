//
//  YR_SearchWorkListModel.m
//  Artand
//
//  Created by dllo on 16/09/22
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_SearchWorkListModel.h"
#import "YR_SearchWorkPicsModel.h"
#import "YR_SearchWorkCateModel.h"
#import "YR_SearchWorkSizeModel.h"
#import "YR_SearchWorkUserModel.h"

@implementation YR_SearchWorkListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [YR_SearchWorkPicsModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"pics"]) {
        NSMutableArray<YR_SearchWorkPicsModel *> *picsArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_SearchWorkPicsModel *pics = [YR_SearchWorkPicsModel modelWithDict:dic];
            [picsArr addObject:pics];
        }
        _pics = picsArr;
    }
    if ([key isEqualToString:@"cate"]) {
        YR_SearchWorkCateModel *cate = [YR_SearchWorkCateModel modelWithDict:value];
        _cate = cate;
    }
    if ([key isEqualToString:@"size"]) {
        YR_SearchWorkSizeModel *size = [YR_SearchWorkSizeModel modelWithDict:value];
        _size = size;
    }
    if ([key isEqualToString:@"user"]) {
        YR_SearchWorkUserModel *user = [YR_SearchWorkUserModel modelWithDict:value];
        _user = user;
    }
}

@end
