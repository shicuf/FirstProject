//
//  YR_ArtistListModel.m
//  __PRODUCTNAME__
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_ArtistListModel.h"
#import "YR_ArtistWorksModel.h"
#import "YR_ArtistOutUserModel.h"

@implementation YR_ArtistListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"works" : [YR_ArtistWorksModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"works"]) {
        NSMutableArray<YR_ArtistWorksModel *> *worksArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ArtistWorksModel *works = [YR_ArtistWorksModel modelWithDict:dic];
            [worksArr addObject:works];
        }
        _works = worksArr;
    }
    if ([key isEqualToString:@"user"]) {
        YR_ArtistOutUserModel *user = [YR_ArtistOutUserModel modelWithDict:value];
        _user = user;
    }
}

@end
