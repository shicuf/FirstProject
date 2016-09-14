//
//  YR_GalleryDetailListModel.h
//  Artand
//
//  Created by Dendi on 16/09/13
//  Copyright (c) kaleidoscope. All rights reserved.
//

#import "YR_BaseModel.h"

@class YR_GalleryDetailCateModel;

@interface YR_GalleryDetailListModel : YR_BaseModel

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *is_framed;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *quality;

@property (nonatomic, copy) NSString *pics;

@property (nonatomic, copy) NSString *is_del;

@property (nonatomic, copy) NSString *h;

@property (nonatomic, copy) NSString *unit;

@property (nonatomic, copy) NSString *sort;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, strong) YR_GalleryDetailCateModel *cate;

@property (nonatomic, copy) NSString *is_sale;

@property (nonatomic, copy) NSString *times;

@property (nonatomic, copy) NSString *row_type;

@property (nonatomic, copy) NSString *mark;

@property (nonatomic, copy) NSString *work_type;

@property (nonatomic, copy) NSString *num_liked;

@property (nonatomic, copy) NSString *num_view;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *is_show_home;

@property (nonatomic, copy) NSString *is_secret;

@property (nonatomic, copy) NSString *height;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *goods_num;

@property (nonatomic, copy) NSString *tags;

@property (nonatomic, copy) NSString *is_show_feed;

@property (nonatomic, copy) NSString *is_available;

@property (nonatomic, copy) NSString *size;

@property (nonatomic, copy) NSString *is_certificates;

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *row_id;

@property (nonatomic, copy) NSString *is_water_mark;

@property (nonatomic, copy) NSString *bj;

@property (nonatomic, copy) NSString *owner_id;

@property (nonatomic, copy) NSString *mail_fee;

@property (nonatomic, copy) NSString *mtime;

@property (nonatomic, copy) NSString *w;

@property (nonatomic, copy) NSString *is_block;

@property (nonatomic, copy) NSString *collection_id;

@property (nonatomic, copy) NSString *pid;

@property (nonatomic, copy) NSString *width;

@end