//
//  YR_Ads.h
//  Artand
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@interface YR_Ads : YR_BaseModel

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *pic;

@property (nonatomic, copy) NSString *subhead;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, strong) NSNumber *type;

@property (nonatomic, copy) NSString *url;

@end
