//
//  YR_PurchaseModel.m
//  Artand
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_PurchaseModel.h"
#import "YR_PurchaseListModel.h"

@implementation YR_PurchaseModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_PurchaseListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_PurchaseListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_PurchaseListModel *list = [YR_PurchaseListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
