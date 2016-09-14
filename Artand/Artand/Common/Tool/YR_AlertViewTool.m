//
//  YR_AlertViewTool.m
//  Artand
//
//  Created by dllo on 2016/9/14.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_AlertViewTool.h"

@implementation YR_AlertViewTool

+ (void)toolWithAlertTitle:(NSString *)title message:(NSString *)message controller:(UIViewController *)vc {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alertVC addAction:action];
    [vc presentViewController:alertVC animated:YES completion:nil];
}

@end
