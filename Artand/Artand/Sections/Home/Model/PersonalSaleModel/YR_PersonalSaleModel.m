//
//  YR_PersonalSaleModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/13
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_PersonalSaleModel.h"
#import "YR_PersonalSaleListModel.h"

@implementation YR_PersonalSaleModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_PersonalSaleListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_PersonalSaleListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_PersonalSaleListModel *list = [YR_PersonalSaleListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
