//
//  YR_ScrollView.m
//  Artand
//
//  Created by dllo on 16/9/7.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_ScrollView.h"

@interface YR_ScrollView () <UIScrollViewDelegate>

@end

@implementation YR_ScrollView

/**
 *  解决自定义返回手势与scrollview右滑手势冲突的问题
 *
 *  @param gestureRecognizer      scrollView的手势
 *  @param otherGestureRecognizer 其他手势
 *
 *  @return 是否识别手势
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    // 首先判断otherGestureRecognizer是不是系统pop手势
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"UILayoutContainerView")]) {
        // 再判断系统手势的state是began还是fail，同时判断scrollView的位置是不是正好在最左边
        if (otherGestureRecognizer.state == UIGestureRecognizerStateBegan && self.contentOffset.x == 0) {
            return YES;
        }
    }
    
    return NO;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
    }
    return self;
}

- (instancetype)init {
    
    if (self = [super init]) {
        self.delegate = self;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.x < 0) {
        scrollView.bounces = NO;
    }
}

@end
