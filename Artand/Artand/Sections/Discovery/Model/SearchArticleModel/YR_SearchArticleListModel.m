//
//  YR_SearchArticleListModel.m
//  Artand
//
//  Created by dllo on 16/09/22
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_SearchArticleListModel.h"
#import "YR_SearchArticleUserModel.h"

@implementation YR_SearchArticleListModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"user"]) {
        YR_SearchArticleUserModel *user = [YR_SearchArticleUserModel modelWithDict:value];
        _user = user;
    }
}

@end
