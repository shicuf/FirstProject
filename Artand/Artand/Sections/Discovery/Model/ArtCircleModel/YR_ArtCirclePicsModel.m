//
//  YR_ArtCirclePicsModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_ArtCirclePicsModel.h"

@implementation YR_ArtCirclePicsModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"w"]) {
        if ([value isKindOfClass:[NSString class]]) {
            _w = @([value integerValue]);
        }
    }
    if ([key isEqualToString:@"h"]) {
        if ([value isKindOfClass:[NSString class]]) {
            _h = @([value integerValue]);
        }
    }
}

@end
