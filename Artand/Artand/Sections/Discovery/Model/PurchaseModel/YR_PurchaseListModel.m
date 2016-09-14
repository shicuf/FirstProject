//
//  YR_PurchaseListModel.m
//  Artand
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_PurchaseListModel.h"
#import "YR_PurchasePicsModel.h"
#import "YR_PurchaseSizeModel.h"
#import "YR_PurchasePicModel.h"
#import "YR_PurchaseAuthModel.h"

@implementation YR_PurchaseListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [YR_PurchasePicsModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"size"]) {
        YR_PurchaseSizeModel *size = [YR_PurchaseListModel modelWithDict:value];
        _size = size;
    }
    if ([key isEqualToString:@"pic"]) {
        YR_PurchasePicModel *pic = [YR_PurchasePicModel modelWithDict:value];
        _pic = pic;
    }
    if ([key isEqualToString:@"pics"]) {
        NSMutableArray<YR_PurchasePicsModel *> *picsArr = [NSMutableArray array];
        for (NSDictionary *dic in picsArr) {
            YR_PurchasePicsModel *pics = [YR_PurchasePicsModel modelWithDict:dic];
            [picsArr addObject:pics];
        }
        _pics = picsArr;
    }
    if ([key isEqualToString:@"auth"]) {
        YR_PurchaseAuthModel *auth = [YR_PurchaseAuthModel modelWithDict:value];
        _auth = auth;
    }
}

@end
