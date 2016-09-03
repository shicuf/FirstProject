//
//  YR_BaseViewController.m
//  Artand
//
//  Created by Dendi on 8/27/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_BaseViewController.h"

@interface YR_BaseViewController () <UITableViewDelegate>

@end

@implementation YR_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}



@end
