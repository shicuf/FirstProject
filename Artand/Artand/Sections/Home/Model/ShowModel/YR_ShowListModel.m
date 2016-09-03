//
//  YR_ShowListModel.m
//  Artand
//
//  Created by Dendi on 16/08/30
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_ShowListModel.h"
#import "YR_ShowUserModel.h"

@implementation YR_ShowListModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"user"]) {
        YR_ShowUserModel *user = [YR_ShowUserModel modelWithDict:value];
        _user = user;
    }
}

@end
