//
//  YR_SearchWorkModel.m
//  Artand
//
//  Created by dllo on 16/09/22
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_SearchWorkModel.h"
#import "YR_SearchWorkListModel.h"

@implementation YR_SearchWorkModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_SearchWorkListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_SearchWorkListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_SearchWorkListModel *list = [YR_SearchWorkListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
