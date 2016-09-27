//
//  YR_MainViewController.m
//  Artand
//
//  Created by Dendi on 8/27/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_MainViewController.h"
#import "YR_HomeViewController.h"
#import "YR_DiscoveryViewController.h"
#import "YR_NotificationViewController.h"
#import "YR_MineViewController.h"
#import "YR_LoginViewController.h"
#import "YR_BaseNavigationController.h"
#import "YR_TabBar.h"
#import "YR_Macro.h"

@interface YR_MainViewController () <UITabBarControllerDelegate>

@end

@implementation YR_MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sharebar"]];
    
    [self setupChildVC:[[YR_HomeViewController alloc] init] image:[UIImage imageNamed:@"1005"] selectedImage:[UIImage imageNamed:@"1000"]];
    [self setupChildVC:[[YR_DiscoveryViewController alloc] init] image:[UIImage imageNamed:@"1006"] selectedImage:[UIImage imageNamed:@"1001"]];
    [self setupChildVC:[[YR_NotificationViewController alloc] init] image:[UIImage imageNamed:@"1007"] selectedImage:[UIImage imageNamed:@"1002"]];
    [self setupChildVC:[[YR_MineViewController alloc] init] image:[UIImage imageNamed:@"1008"] selectedImage:[UIImage imageNamed:@"1003"]];
    self.delegate = self;
    
    [self setValue:[[YR_TabBar alloc] init] forKeyPath:@"tabBar"];
    
}
#pragma mark - 创建每个控制器方法
- (void)setupChildVC:(UIViewController *)vc image:(UIImage *)image selectedImage:(UIImage *)selectedImage {
    
    vc.tabBarItem.image = image;
    vc.tabBarItem.selectedImage = selectedImage;
    YR_BaseNavigationController *nav = [[YR_BaseNavigationController alloc] initWithRootViewController:vc];
    nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0); // 设置tabbar图标在正中间位置
    [self addChildViewController:nav];
}
#pragma mark - 选择tabBarItem的代理方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    if ([viewController.childViewControllers[0] isKindOfClass:[YR_NotificationViewController class]] || [viewController.childViewControllers[0] isKindOfClass:[YR_MineViewController class]]) {
        
        if (SESSION_ID) {
            return YES;
        }
        
        YR_LoginViewController *logVC = [[YR_LoginViewController alloc] init];
        YR_BaseNavigationController *nav = [[YR_BaseNavigationController alloc] initWithRootViewController:logVC];
        [self presentViewController:nav animated:YES completion:nil];
        return NO;
    }
    return YES;
}



@end
