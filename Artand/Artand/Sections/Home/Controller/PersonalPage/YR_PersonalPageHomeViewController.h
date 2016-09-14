//
//  YR_PersonalPageHomeViewController.h
//  Artand
//
//  Created by dllo on 16/9/10.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YR_PersonalPageModel;

@interface YR_PersonalPageHomeViewController : UIViewController

@property (nonatomic, strong) YR_PersonalPageModel *personalPageModel;
@property (nonatomic, strong) UITableView *homeTableView;

@end
