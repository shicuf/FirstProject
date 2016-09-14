//
//  YR_AlertViewTool.h
//  Artand
//
//  Created by dllo on 2016/9/14.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YR_AlertViewTool : NSObject

+ (void)toolWithAlertTitle:(NSString *)title message:(NSString *)message controller:(UIViewController *)vc;

@end
