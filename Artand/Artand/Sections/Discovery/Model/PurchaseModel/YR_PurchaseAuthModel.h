//
//  YR_PurchaseAuthModel.h
//  Artand
//
//  Created by Dendi on 16/09/04
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_PurchaseExtralModel;

@interface YR_PurchaseAuthModel : YR_BaseModel

@property (nonatomic, copy) NSString *type;

@property (nonatomic, strong) YR_PurchaseExtralModel *extral;

@end