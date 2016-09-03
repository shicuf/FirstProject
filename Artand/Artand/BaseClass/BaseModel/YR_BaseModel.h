//
//  YR_BaseModel.h
//  Artand
//
//  Created by Dendi on 8/27/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface YR_BaseModel : NSObject

/**
 *  基类初始化方法
 *
 *  @param dict model对应的字典
 *
 *  @return
 */
- (instancetype)initWithDict:(NSDictionary *)dict;
/**
 *  基类构造器方法
 *
 *  @param dict model对应的字典
 *
 *  @return
 */
+ (__kindof YR_BaseModel *)modelWithDict:(NSDictionary *)dict;

@end
NS_ASSUME_NONNULL_END