//
//  YR_SearchArticleModel.m
//  Artand
//
//  Created by dllo on 16/09/22
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_SearchArticleModel.h"
#import "YR_SearchArticleListModel.h"

@implementation YR_SearchArticleModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_SearchArticleListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_SearchArticleListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_SearchArticleListModel *list = [YR_SearchArticleListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
