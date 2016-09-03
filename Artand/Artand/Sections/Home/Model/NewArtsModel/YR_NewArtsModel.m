//
//  YR_NewArtsModel.m
//  Artand
//
//  Created by dllo on 16/08/30
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_NewArtsModel.h"
#import "YR_NewArtsListModel.h"

@implementation YR_NewArtsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_NewArtsListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_NewArtsListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_NewArtsListModel *list = [YR_NewArtsListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
