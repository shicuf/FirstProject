//
//  YR_EditorRecommendModel.m
//  Artand
//
//  Created by Dendi on 8/29/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_EditorRecommendModel.h"
#import "YR_EditorRecommendListModel.h"

@implementation YR_EditorRecommendModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_EditorRecommendListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_EditorRecommendListModel *list = [YR_EditorRecommendListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
