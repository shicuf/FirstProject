//
//  YR_ShareOneModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/27
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_ShareOneModel.h"
#import "YR_ShareOneShareModel.h"

@implementation YR_ShareOneModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"share"]) {
        YR_ShareOneShareModel *share = [YR_ShareOneShareModel modelWithDict:value];
        _share = share;
    }
}

@end
