//
//  YR_LoginModel.m
//  PinkGirl
//
//  Created by dllo on 16/09/14
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_LoginModel.h"
#import "YR_LoginUserModel.h"

@implementation YR_LoginModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"user"]) {
        YR_LoginUserModel *user = [YR_LoginUserModel modelWithDict:value];
        _user = user;
    }
}

@end
