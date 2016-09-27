//
//  YR_ShareOneShareModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/27
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_ShareOneShareModel.h"
#import "YR_ShareOneMomentsModel.h"
#import "YR_ShareOneWechatModel.h"
#import "YR_ShareOneSinaModel.h"
#import "YR_ShareOneNormalModel.h"

@implementation YR_ShareOneShareModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"moments"]) {
        YR_ShareOneMomentsModel *moments = [YR_ShareOneMomentsModel modelWithDict:value];
        _moments = moments;
    }
    if ([key isEqualToString:@"wechat"]) {
        YR_ShareOneWechatModel *wechat = [YR_ShareOneWechatModel modelWithDict:value];
        _wechat = wechat;
    }
    if ([key isEqualToString:@"sina"]) {
        YR_ShareOneSinaModel *sina = [YR_ShareOneSinaModel modelWithDict:value];
        _sina = sina;
    }
    if ([key isEqualToString:@"normal"]) {
        YR_ShareOneNormalModel *normal = [YR_ShareOneNormalModel modelWithDict:value];
        _normal = normal;
    }
}

@end
