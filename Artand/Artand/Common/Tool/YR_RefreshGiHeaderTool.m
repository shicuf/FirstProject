//
//  YR_RefreshGiHeaderTool.m
//  Artand
//
//  Created by Dendi on 9/16/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_RefreshGiHeaderTool.h"
#import "MJRefresh.h"
#import "AFNetworking.h"

@interface YR_RefreshGiHeaderTool ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation YR_RefreshGiHeaderTool


- (instancetype)initWithScrollView:(__kindof UIScrollView *)scrollView requestBlock:(void (^)())requestBlock {
    
    if (self = [super init]) {
        [self createGifHeaderWithTableView:scrollView requestBlock:requestBlock];
    }
    return self;
}

- (void)createGifHeaderWithTableView:(__kindof UIScrollView *)scrollView requestBlock:(void (^)())requestBlock {
    
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        requestBlock();
    }];
    gifHeader.stateLabel.hidden = YES;
    gifHeader.lastUpdatedTimeLabel.hidden = YES;
    
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 0; i < 14; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", i]];
        [imageArr addObject:image];
    }
    
    [gifHeader setImages:imageArr duration:1 forState:MJRefreshStatePulling];
    [gifHeader setImages:imageArr duration:1 forState:MJRefreshStateIdle];
    [gifHeader setImages:imageArr duration:1 forState:MJRefreshStateRefreshing];
    scrollView.mj_header = gifHeader;
}

@end
