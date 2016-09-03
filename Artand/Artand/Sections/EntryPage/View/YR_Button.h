//
//  YR_Button.h
//  Artand
//
//  Created by Dendi on 8/28/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface YR_Button : UIButton

@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;

@end
