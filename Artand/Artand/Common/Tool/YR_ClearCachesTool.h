//
//  YR_ClearCachesTool.h
//  Artand
//
//  Created by Dendi on 9/21/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^cleanCacheBlock)();


@interface YR_ClearCachesTool : NSObject

/**
 *  清理缓存
 */
+(void)cleanCache:(cleanCacheBlock)block;
/**
 *  整个缓存目录的大小
 */
+(float)folderSizeAtPath;


@end
