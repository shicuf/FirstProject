//
//  YR_ArticleDetailModel.m
//  Artand
//
//  Created by Dendi on 16/09/05
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_ArticleDetailModel.h"
#import "YR_ArticleDetailArticleModel.h"
#import "YR_ArticleDetailRewardModel.h"

@implementation YR_ArticleDetailModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"article"]) {
        YR_ArticleDetailArticleModel *article = [YR_ArticleDetailArticleModel modelWithDict:value];
        _article = article;
    }
    if ([key isEqualToString:@"reward"]) {
        YR_ArticleDetailRewardModel *reward = [YR_ArticleDetailRewardModel modelWithDict:value];
        _reward = reward;
    }
}

@end
