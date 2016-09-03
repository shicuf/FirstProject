//
//  YR_Button.m
//  Artand
//
//  Created by Dendi on 8/28/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_Button.h"

@implementation YR_Button

- (void)drawRect:(CGRect)rect {
    
    self.layer.borderColor = self.borderColor.CGColor;
    self.layer.borderWidth = self.borderWidth;
    self.clipsToBounds = YES;
}

@end
