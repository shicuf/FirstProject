//
//  YR_LoginUserModel.m
//  PinkGirl
//
//  Created by dllo on 16/09/14
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_LoginUserModel.h"
#import "YR_LoginImModel.h"

@implementation YR_LoginUserModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"im"]) {
        YR_LoginImModel *im = [YR_LoginImModel modelWithDict:value];
        _im = im;
    }
}

@end
