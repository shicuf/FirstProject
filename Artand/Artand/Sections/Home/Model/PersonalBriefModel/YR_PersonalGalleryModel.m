//
//  YR_PersonalGalleryModel.m
//  Artand
//
//  Created by dllo on 16/09/12
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_PersonalGalleryModel.h"
#import "YR_PersonalGalleryListModel.h"

@implementation YR_PersonalGalleryModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [YR_PersonalGalleryListModel class]};
}

@end
