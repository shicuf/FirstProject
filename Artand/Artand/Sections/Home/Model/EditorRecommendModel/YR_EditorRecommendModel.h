//
//  YR_EditorRecommendModel.h
//  Artand
//
//  Created by Dendi on 8/29/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_EditorRecommendListModel;

@interface YR_EditorRecommendModel : YR_BaseModel

@property (nonatomic, strong) NSNumber *code;

@property (nonatomic, strong) NSArray<YR_EditorRecommendListModel *> *list;

@property (nonatomic, strong) NSNumber *last_id;

@property (nonatomic, copy) NSString *time;

@end
