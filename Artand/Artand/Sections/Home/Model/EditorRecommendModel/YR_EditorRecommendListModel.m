//
//  YR_EditorRecommendListModel.m
//  Artand
//
//  Created by Dendi on 8/29/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_EditorRecommendListModel.h"
#import "YR_EditorRecommendUserModel.h"
#import "YR_EditorRecommendAuthModel.h"
#import "YR_EditorRecommendPicModel.h"
#import "YR_EditorRecommendPicsModel.h"

@implementation YR_EditorRecommendListModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"user"]) {
        YR_EditorRecommendUserModel *user = [YR_EditorRecommendUserModel modelWithDict:value];
        _user = user;
    }
    
    if ([key isEqualToString:@"auth"]) {
        YR_EditorRecommendAuthModel *auth = [YR_EditorRecommendAuthModel modelWithDict:value];
        _auth = auth;
    }
    
    if ([key isEqualToString:@"pic"]) {
        YR_EditorRecommendPicModel *pic = [YR_EditorRecommendPicModel modelWithDict:value];
        _pic = pic;
    }
    
    if ([key isEqualToString:@"pics"]) {
        NSMutableArray<YR_EditorRecommendPicsModel *> *picsArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_EditorRecommendPicsModel *pics = [YR_EditorRecommendPicsModel modelWithDict:dic];
            [picsArr addObject:pics];
        }
        _pics = [picsArr mutableCopy];
    }
}

@end
