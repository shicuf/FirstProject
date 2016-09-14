//
//  YR_PurchaseAuthModel.m
//  Artand
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_PurchaseAuthModel.h"
#import "YR_PurchaseExtralModel.h"

@implementation YR_PurchaseAuthModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"extral"]) {
        if (value) {
            YR_PurchaseExtralModel *extral = [YR_PurchaseExtralModel modelWithDict:value];
            _extral = extral;
        }
    }
}

@end
