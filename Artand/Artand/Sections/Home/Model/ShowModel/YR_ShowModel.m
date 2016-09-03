//
//  YR_ShowModel.m
//  Artand
//
//  Created by Dendi on 16/08/30
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_ShowModel.h"
#import "YR_ShowListModel.h"

@implementation YR_ShowModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_ShowListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_ShowListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ShowListModel *list = [YR_ShowListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
