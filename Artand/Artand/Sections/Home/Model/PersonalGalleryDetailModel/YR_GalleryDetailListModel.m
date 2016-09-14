//
//  YR_GalleryDetailListModel.m
//  Artand
//
//  Created by Dendi on 16/09/13
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_GalleryDetailListModel.h"
#import "YR_GalleryDetailCateModel.h"

@implementation YR_GalleryDetailListModel

- (void)setValue:(id)value forKey:(NSString *)key {
    
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"cate"]) {
        YR_GalleryDetailCateModel *cate = [YR_GalleryDetailCateModel modelWithDict:value];
        _cate = cate;
    }
}

@end
