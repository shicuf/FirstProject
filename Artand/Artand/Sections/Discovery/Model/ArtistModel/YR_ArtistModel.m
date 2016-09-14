//
//  YR_ArtistModel.m
//  __PRODUCTNAME__
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_ArtistModel.h"
#import "YR_ArtistListModel.h"

@implementation YR_ArtistModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_ArtistListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_ArtistListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ArtistListModel *list = [YR_ArtistListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
