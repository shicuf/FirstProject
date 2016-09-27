//
//  YR_ArtCircleModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_ArtCircleModel.h"
#import "YR_ArtCircleListModel.h"

@implementation YR_ArtCircleModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_ArtCircleListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_ArtCircleListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ArtCircleListModel *list = [YR_ArtCircleListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
