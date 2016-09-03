//
//  YR_TextView.m
//  Artand
//
//  Created by Dendi on 8/28/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_TextView.h"

@implementation YR_TextView

- (void)drawRect:(CGRect)rect {
    
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.clipsToBounds = YES;
}

@end
