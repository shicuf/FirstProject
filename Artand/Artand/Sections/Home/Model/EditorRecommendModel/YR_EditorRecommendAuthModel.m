//
//  YR_EditorRecommendAuthModel.m
//  Artand
//
//  Created by Dendi on 8/29/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_EditorRecommendAuthModel.h"
#import "YR_EditorRecommendExtraModel.h"

@implementation YR_EditorRecommendAuthModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"extra"]) {
        if (value) {
            YR_EditorRecommendExtraModel *extra = [YR_EditorRecommendExtraModel modelWithDict:value];
            _extra = extra;
        }
    }
}

@end
