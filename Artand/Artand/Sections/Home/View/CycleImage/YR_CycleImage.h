//
//  YR_CycleImage.h
//  Artand
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YR_CycleImageDataSource <NSObject>

- (void)handleDataWithObject:(id)objc cell:(__kindof UICollectionViewCell *)cell;

@end

@protocol YR_CycleImagesDelegate <NSObject>

- (void)cycleImagesActionWithIndexPath:(NSIndexPath *)indexPath;

@end

@interface YR_CycleImage : UIView

@property (nonatomic, strong, readonly) UICollectionView *cycleCollectionView;
@property (nonatomic, strong, readonly) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, weak) id<YR_CycleImagesDelegate> delegate;
@property (nonatomic, weak) id<YR_CycleImageDataSource> dataSource;

@end


@interface YRCycleImagesCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *cycleImageView;
@property (nonatomic, strong) UILabel *label;

@end