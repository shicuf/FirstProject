//
//  YR_BaseModel.m
//  Artand
//
//  Created by Dendi on 8/27/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@implementation YR_BaseModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (YR_BaseModel *)modelWithDict:(NSDictionary *)dict {
    
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    
    return nil;
}

- (void)setNilValueForKey:(NSString *)key {
    
}

@end
