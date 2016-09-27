//
//  UIButton+YR_TimeCountButton.m
//  Artand
//
//  Created by dllo on 2016/9/21.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "UIButton+YR_TimeCountButton.h"

@implementation UIButton (YR_TimeCountButton)

//计时器发送验证码
- (void)sentPhoneCodeTimeMethod {
    //倒计时时间 - 60秒
    __block NSInteger timeOut = 59;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -》dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{
        if (timeOut <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式-》
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:@"发送验证码" forState:UIControlStateNormal];
                [self setUserInteractionEnabled:YES];
            });
        }else{
            //开始计时
            //剩余秒数 seconds
            NSInteger seconds = timeOut % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.1ld",seconds];
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1.0];
                [self setTitle:[NSString stringWithFormat:@"%@S后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                //计时器件不允许点击
                [self setUserInteractionEnabled:NO];
            });
            timeOut--;
        }
    });
    dispatch_resume(timer);
}

@end
