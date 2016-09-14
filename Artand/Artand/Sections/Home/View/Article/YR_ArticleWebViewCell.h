//
//  YR_ArticleWebViewCell.h
//  Artand
//
//  Created by dllo on 16/9/6.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YR_ArticleDetailModel;

@interface YR_ArticleWebViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIWebView *articleWebView;
@property (weak, nonatomic) IBOutlet UIButton *popBtn;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (nonatomic, strong) YR_ArticleDetailModel *articleDetailModel;

@property (nonatomic, strong) void (^popBlock)();
@property (nonatomic, strong) void (^shareBlock)();

@end
