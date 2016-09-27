//
//  YR_AccountModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_AccountModel.h"
#import "YR_AccountUserModel.h"

@implementation YR_AccountModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"user"]) {
        YR_AccountUserModel *user = [YR_AccountUserModel modelWithDict:value];
        _user = user;
    }
}

@end
