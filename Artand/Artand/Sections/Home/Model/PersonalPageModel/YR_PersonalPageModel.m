//
//  YR_PersonalPageModel.m
//  __PRODUCTNAME__
//
//  Created by Dendi on 16/09/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_PersonalPageModel.h"
#import "YR_PersonalPageListModel.h"
#import "YR_PersonalPageOwnerModel.h"

@implementation YR_PersonalPageModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_PersonalPageListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"owner"]) {
        YR_PersonalPageOwnerModel *owner = [YR_PersonalPageOwnerModel modelWithDict:value];
        _owner = owner;
    }
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_PersonalPageListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_PersonalPageListModel *list = [YR_PersonalPageListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
