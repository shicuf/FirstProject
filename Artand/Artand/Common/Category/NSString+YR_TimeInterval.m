//
//  NSString+YR_TimeInterval.m
//  Artand
//
//  Created by dllo on 2016/9/14.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "NSString+YR_TimeInterval.h"

@implementation NSString (YR_TimeInterval)

/** 通过行数, 返回更新时间 */
- (NSString *)updateTimeForTimeIntervalString:(NSString *)timeIntervalString {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    // 创建歌曲时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [timeIntervalString integerValue];
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    // 秒转分钟
    NSInteger minute = time / 60;
    if (minute < 60) {
        return [NSString stringWithFormat:@"%ld分钟前", minute];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return [NSString stringWithFormat:@"%ld年前",years];
}

@end
