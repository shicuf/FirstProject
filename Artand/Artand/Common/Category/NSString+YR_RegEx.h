//
//  NSString+YR_RegEx.h
//  Artand
//
//  Created by dllo on 2016/9/20.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YR_RegEx)

- (BOOL)isPhoneNumType;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
