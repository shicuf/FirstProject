//
//  YR_RefreshGiHeaderTool.h
//  Artand
//
//  Created by Dendi on 9/16/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YR_RefreshGiHeaderTool : NSObject

- (instancetype)initWithScrollView:(__kindof UIScrollView *)scrollView requestBlock:(void (^)())requestBlock;

@end
