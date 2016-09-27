//
//  YR_ArtCircleLikedModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_ArtCircleLikedModel.h"
#import "YR_ArtCircleInUserModel.h"

@implementation YR_ArtCircleLikedModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"user"]) {
        YR_ArtCircleInUserModel *user = [YR_ArtCircleInUserModel modelWithDict:value];
        _user = user;
    }
}

@end
