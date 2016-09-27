//
//  SelfSizeTool.h
//  10-CellSelfSize
//
//  Created by Dendi on 7/27/16.
//  Copyright © 2016 Kaleidoscope. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@interface SelfSizeTool : NSObject

+ (CGFloat)selfSizeHeightWithString:(NSString *)string
                              width:(CGFloat)width
                               font:(UIFont *)font;

@end
