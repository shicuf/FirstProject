//
//  SelfSizeTool.m
//  10-CellSelfSize
//
//  Created by Dendi on 7/27/16.
//  Copyright © 2016 Kaleidoscope. All rights reserved.
//

#import "SelfSizeTool.h"

@implementation SelfSizeTool

+ (CGFloat)selfSizeHeightWithString:(NSString *)string
                              width:(CGFloat)width
                               font:(UIFont *)font {
    CGRect newRect = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    
    return newRect.size.height;
}

@end
