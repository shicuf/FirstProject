//
//  YR_EditorRecommendListModel.h
//  Artand
//
//  Created by Dendi on 8/29/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_EditorRecommendUserModel, YR_EditorRecommendAuthModel, YR_EditorRecommendPicModel, YR_EditorRecommendPicModel;

@interface YR_EditorRecommendListModel : YR_BaseModel

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *owner_id;

@property (nonatomic, strong) NSArray *tags;

@property (nonatomic, strong) NSNumber *vv;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, copy) NSString *category;

@property (nonatomic, strong) NSNumber *num_liked;

@property (nonatomic, strong) NSNumber *is_liked;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *goods_num;

@property (nonatomic, copy) NSString *row_type;

@property (nonatomic, strong) YR_EditorRecommendUserModel *user;

@property (nonatomic, strong) YR_EditorRecommendAuthModel *auth;

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *times;

@property (nonatomic, strong) YR_EditorRecommendPicModel *pic;

@property (nonatomic, copy) NSString *size_label;

@property (nonatomic, strong) NSArray<YR_EditorRecommendPicModel *> *pics;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *row_id;

@property (nonatomic, copy) NSString *mark;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *is_sale;

@end
