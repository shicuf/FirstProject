//
//  YR_CycleModel.m
//  Artand
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_CycleModel.h"
#import "YR_Ads.h"

@implementation YR_CycleModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"ads"]) {
        NSMutableArray<YR_Ads *> *adsArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_Ads *ads = [YR_Ads modelWithDict:dic];
            [adsArr addObject:ads];
        }
        _ads = adsArr;
    }
}

@end
