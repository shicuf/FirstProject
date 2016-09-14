//
//  YR_GalleryDetailModel.m
//  Artand
//
//  Created by Dendi on 16/09/13
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_GalleryDetailModel.h"
#import "YR_GalleryDetailListModel.h"
#import "YR_GalleryDetailCollectionModel.h"

@implementation YR_GalleryDetailModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_GalleryDetailListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"collection"]) {
        YR_GalleryDetailCollectionModel *collection = [YR_GalleryDetailCollectionModel modelWithDict:value];
        _collection = collection;
    }
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_GalleryDetailListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_GalleryDetailListModel *list = [YR_GalleryDetailListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
