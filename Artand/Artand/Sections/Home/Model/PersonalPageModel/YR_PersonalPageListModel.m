//
//  YR_PersonalPageListModel.m
//  __PRODUCTNAME__
//
//  Created by Dendi on 16/09/09
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_PersonalPageListModel.h"
#import "YR_PersonalPagePicsModel.h"
#import "YR_PersonalPageCateModel.h"

@implementation YR_PersonalPageListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"pics" : [YR_PersonalPagePicsModel class]};
}

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"cate"]) {
        YR_PersonalPageCateModel *cate = [YR_PersonalPageCateModel modelWithDict:value];
        _cate = cate;
    }
    if ([key isEqualToString:@"pics"]) {
        NSMutableArray<YR_PersonalPagePicsModel *> *picsArr = [NSMutableArray array];
        for (NSDictionary *dic in value) {
            YR_PersonalPagePicsModel *pics = [YR_PersonalPagePicsModel modelWithDict:dic];
            [picsArr addObject:pics];
        }
        _pics = picsArr;
    }
}

@end
