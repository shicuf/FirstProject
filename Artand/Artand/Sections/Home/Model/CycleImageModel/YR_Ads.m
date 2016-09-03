//
//  YR_Ads.m
//  Artand
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_Ads.h"

@implementation YR_Ads

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    [super setValue:value forUndefinedKey:key];
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}


@end
