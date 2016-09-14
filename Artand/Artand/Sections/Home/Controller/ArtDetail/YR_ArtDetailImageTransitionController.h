//
//  YR_ArtDetailImageTransitionController.h
//  Artand
//
//  Created by Dendi on 9/11/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YR_ArtDetailImageTransitionController : UIViewController

@property (nonatomic, strong) UIImageView *toImageView;
@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) CGFloat imageWidth;
@property (nonatomic, assign) CGFloat imageHeight;

@end
