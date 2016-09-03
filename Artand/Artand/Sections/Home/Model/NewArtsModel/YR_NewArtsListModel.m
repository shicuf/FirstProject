//
//  YR_NewArtsListModel.m
//  Artand
//
//  Created by dllo on 16/08/30
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_NewArtsListModel.h"
#import "YR_NewArtsPicsModel.h"
#import "YR_NewArtsAuthModel.h"
#import "YR_NewArtsPicModel.h"

@implementation YR_NewArtsListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [YR_NewArtsPicsModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"auth"]) {
        YR_NewArtsAuthModel *auth = [YR_NewArtsAuthModel modelWithDict:value];
        _auth = auth;
    }
    if ([key isEqualToString:@"pic"]) {
        YR_NewArtsPicModel *pic = [YR_NewArtsPicModel modelWithDict:value];
        _pic = pic;
    }
    if ([key isEqualToString:@"pics"]) {
        NSMutableArray<YR_NewArtsPicsModel *> *picsArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_NewArtsPicsModel *pics = [YR_NewArtsPicsModel modelWithDict:dic];
            [picsArr addObject:pics];
        }
        _pics = picsArr;
    }
    
}

@end
