//
//  YR_Macro.h
//  Artand
//
//  Created by Dendi on 8/27/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#ifndef YR_Macro_h
#define YR_Macro_h



// 调试打印
#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NSLog(...)
#endif

#define IS_IPHONE           (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define IS_IPHONE_5         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_5         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_5_OR_HIGHER         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height >= 568.0f)
#define IS_IPHONE_6         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS         (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)

#define SCREEN_RECT         [UIScreen mainScreen].bounds
#define SCREEN_SIZE         [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH        SCREEN_SIZE.width
#define SCREEN_HEIGHT       SCREEN_SIZE.height




#endif /* YR_Macro_h */
