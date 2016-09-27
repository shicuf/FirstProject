//
//  YR_SearchArtistModel.m
//  Artand
//
//  Created by dllo on 16/09/22
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_SearchArtistModel.h"
#import "YR_SearchArtistListModel.h"

@implementation YR_SearchArtistModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_SearchArtistListModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"list"]) {
        NSMutableArray<YR_SearchArtistListModel *> *listArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_SearchArtistListModel *list = [YR_SearchArtistListModel modelWithDict:dic];
            [listArr addObject:list];
        }
        _list = listArr;
    }
}

@end
