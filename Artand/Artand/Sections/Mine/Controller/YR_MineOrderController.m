//
//  YR_MineOrderController.m
//  Artand
//
//  Created by Dendi on 9/16/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_MineOrderController.h"
#import "YR_Macro.h"
#import "UIView+Frame.h"

@interface YR_MineOrderController ()

@end

@implementation YR_MineOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1.0];
    
    UIButton *purchaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat margin = 10;
    purchaseBtn.backgroundColor = [UIColor whiteColor];
    purchaseBtn.frame = CGRectMake(margin, margin + NAVI_HEIGHT, SCREEN_WIDTH - 2 * margin, 180);
    [self.view addSubview:purchaseBtn];
    
    UIImageView *purchaseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dingdan"]];
    purchaseImageView.frame = CGRectMake(0, 0, 75, 75);
    purchaseImageView.centerX = purchaseBtn.width / 2;
    purchaseImageView.centerY = purchaseBtn.height / 3;
    [purchaseBtn addSubview:purchaseImageView];
    
    UILabel *purchaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(purchaseImageView.frame) + 20, 64, 18.5)];
    purchaseLabel.text = @"我购买的";
    purchaseLabel.centerX = purchaseBtn.width / 2;
    purchaseLabel.font = [UIFont systemFontOfSize:16];
    purchaseLabel.textAlignment = NSTextAlignmentCenter;
    [purchaseBtn addSubview:purchaseLabel];
    
    
    UIButton *saleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saleBtn.frame = CGRectMake(margin, CGRectGetMaxY(purchaseBtn.frame) + margin, purchaseBtn.width, purchaseBtn.height);
    saleBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:saleBtn];
    
    UIImageView *saleImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chushou"]];
    saleImageView.frame = CGRectMake(0, 0, 75, 75);
    saleImageView.centerX = saleBtn.width / 2;
    saleImageView.centerY = saleBtn.height / 3;
    [saleBtn addSubview:saleImageView];
    
    UILabel *saleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(saleImageView.frame) + 20, 64, 18.5)];
    saleLabel.text = @"我出售的";
    saleLabel.centerX = purchaseBtn.width / 2;
    saleLabel.font = [UIFont systemFontOfSize:16];
    saleLabel.textAlignment = NSTextAlignmentCenter;
    [saleBtn addSubview:saleLabel];
}



@end
