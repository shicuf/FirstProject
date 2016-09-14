//
//  YR_PersonalSaleListModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/13
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_PersonalSaleListModel.h"
#import "YR_PersonalSaleCateModel.h"

@implementation YR_PersonalSaleListModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"cate"]) {
        YR_PersonalSaleCateModel *cate = [YR_PersonalSaleListModel modelWithDict:value];
        _cate = cate;
    }
}

@end
