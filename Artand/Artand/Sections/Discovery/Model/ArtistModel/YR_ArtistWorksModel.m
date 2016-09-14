//
//  YR_ArtistWorksModel.m
//  __PRODUCTNAME__
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_ArtistWorksModel.h"
#import "YR_ArtistPicsModel.h"
#import "YR_ArtistInUserModel.h"
#import "YR_ArtistAuthModel.h"
#import "YR_ArtistPicModel.h"

@implementation YR_ArtistWorksModel

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [YR_ArtistPicsModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"user"]) {
        YR_ArtistInUserModel *user = [YR_ArtistInUserModel modelWithDict:value];
        _user = user;
    }
    if ([key isEqualToString:@"auth"]) {
        YR_ArtistAuthModel *auth = [YR_ArtistAuthModel modelWithDict:value];
        _auth = auth;
    }
    if ([key isEqualToString:@"pic"]) {
        YR_ArtistPicModel *pic = [YR_ArtistPicModel modelWithDict:value];
        _pic = pic;
    }
    if ([key isEqualToString:@"pics"]) {
        NSMutableArray<YR_ArtistPicsModel *> *picsArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ArtistPicsModel *pics = [YR_ArtistPicsModel modelWithDict:dic];
            [picsArr addObject:pics];
        }
        _pics = picsArr;
    }
}

@end
