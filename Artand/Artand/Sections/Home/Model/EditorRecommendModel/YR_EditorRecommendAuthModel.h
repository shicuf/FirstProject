//
//  YR_EditorRecommendAuthModel.h
//  Artand
//
//  Created by Dendi on 8/29/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_EditorRecommendExtraModel;

@interface YR_EditorRecommendAuthModel : YR_BaseModel

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) YR_EditorRecommendExtraModel *extra;

@end
