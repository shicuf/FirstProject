//
//  YR_DailySelectionModel.m
//  Artand
//
//  Created by dllo on 16/09/03
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_DailySelectionModel.h"
#import "YR_DailySelectionListModel.h"

@implementation YR_DailySelectionModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_DailySelectionListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_DailySelectionListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_DailySelectionListModel *list = [YR_DailySelectionListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
