//
//  YR_PersonalGalleryModel.m
//  Artand
//
//  Created by dllo on 16/09/12
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_PersonalGalleryModel.h"
#import "YR_PersonalGalleryListModel.h"

@implementation YR_PersonalGalleryModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_PersonalGalleryListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_PersonalGalleryListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_PersonalGalleryListModel *list = [YR_PersonalGalleryListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
