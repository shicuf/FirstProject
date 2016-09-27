//
//  YR_AccountUserModel.m
//  __PRODUCTNAME__
//
//  Created by dllo on 16/09/19
//  Copyright (c) __ORGANIZATIONNAME__. All rights reserved.
//

#import "YR_AccountUserModel.h"
#import "YR_AccountBirthdayModel.h"
#import "YR_AccountSyncModel.h"

@implementation YR_AccountUserModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"birthday"]) {
        YR_AccountBirthdayModel *birthday = [YR_AccountBirthdayModel modelWithDict:value];
        _birthday = birthday;
    }
    if ([key isEqualToString:@"sync"]) {
        YR_AccountSyncModel *sync = [YR_AccountSyncModel modelWithDict:value];
        _sync = sync;
    }
}

@end
