//
//  YR_ArticleDetailArticleModel.m
//  Artand
//
//  Created by Dendi on 16/09/05
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_ArticleDetailArticleModel.h"
#import "YR_ArticleDetailLikedModel.h"
#import "YR_ArticleDetailUserModel.h"

@implementation YR_ArticleDetailArticleModel

+ (NSDictionary *)objectClassInArray{
    return @{@"liked" : [YR_ArticleDetailLikedModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"user"]) {
        YR_ArticleDetailUserModel *user = [YR_ArticleDetailUserModel modelWithDict:value];
        _user = user;
    }
    if ([key isEqualToString:@"liked"]) {
        NSMutableArray<YR_ArticleDetailLikedModel *> *likedArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_ArticleDetailLikedModel *liked = [YR_ArticleDetailLikedModel modelWithDict:dic];
            [likedArr addObject:liked];
        }
        _liked = likedArr;
    }
}

@end
