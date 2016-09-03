//
//  YR_CycleImage.m
//  Artand
//
//  Created by dllo on 16/8/29.
//  Copyright © 2016年 kaleidoscope. All rights reserved.
//

#import "YR_CycleImage.h"

@interface YR_CycleImage () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YR_CycleImage

static NSString * const ID = @"cell";

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    
    [self createCollectionView];
    [self createPageControl];
//    [self createLabel];
    [self createTimer];
}

- (void)createCollectionView {
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _cycleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
    _cycleCollectionView.delegate = self;
    _cycleCollectionView.dataSource = self;
    _cycleCollectionView.pagingEnabled = YES;
    _cycleCollectionView.showsHorizontalScrollIndicator = NO;
    _cycleCollectionView.bounces = NO;
    _cycleCollectionView.backgroundColor = [UIColor whiteColor];
    [_cycleCollectionView registerClass:[YRCycleImagesCell class] forCellWithReuseIdentifier:ID];
    [self addSubview:_cycleCollectionView];
}

- (void)createPageControl {
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
    _pageControl.currentPage = 0;
    _pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    [_pageControl addTarget:self action:@selector(imagePageChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
}

- (void)createLabel {
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor redColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
}

- (void)imagePageChange:(UIPageControl *)pageControl {
    
    [_cycleCollectionView setContentOffset:CGPointMake((pageControl.currentPage + 1) * self.bounds.size.width, 0) animated:YES];
}

- (void)createTimer {
    
    // 仅仅是创建 并没有加在loop中
    //    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
    //    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(changeView) userInfo:nil repeats:YES];
    // NSRunLoopCommonModes  多种状态 包含默认和滚动 和 scheduledTimerWithTimerInterval 添加默认状态
    // 取消timer时候 调用invalidate _timer置空
}

- (void)changeView {
    
    CGFloat totaloffset = _cycleCollectionView.contentOffset.x + self.bounds.size.width;
    [_cycleCollectionView setContentOffset:CGPointMake(totaloffset, 0) animated:YES];
    if (totaloffset == (_array.count - 1) * self.bounds.size.width) {
        _cycleCollectionView.contentOffset = CGPointZero;
    }
    _pageControl.currentPage = (_cycleCollectionView.contentOffset.x + self.bounds.size.width) / self.bounds.size.width - 1;
    _titleLabel.text = [NSString stringWithFormat:@"第%ld页", _pageControl.currentPage + 1];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    _cycleCollectionView.frame = self.bounds;
    _flowLayout.itemSize =  self.bounds.size;
    [_cycleCollectionView setContentOffset:CGPointMake(self.bounds.size.width, 0)];
    _pageControl.frame = CGRectMake(0, 0, self.frame.size.width / 3, 20);
    _pageControl.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 10);
    _titleLabel.frame = CGRectMake(0, 0, self.frame.size.width, 30);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YRCycleImagesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
    //    cell.cycleImageView.image = [UIImage imageNamed:_array[indexPath.row]];
//    cell.label.text = @"hahahhahahah";
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(handleDataWithObject:cell:)]) {
        [self.dataSource handleDataWithObject:_array[indexPath.row] cell:cell];
    }// 把_array[indePath.row] 和 cell 传出去进行赋值
    return cell;
}

- (void)setArray:(NSArray *)array {
    
    _array = array;
    [_cycleCollectionView reloadData];
    _pageControl.numberOfPages = array.count - 2;
    _titleLabel.text = [NSString stringWithFormat:@"第%ld页", _pageControl.currentPage + 1];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    NSInteger page = scrollView.contentOffset.x / self.cycleCollectionView.bounds.size.width;
    _pageControl.currentPage = page - 1;
    // 直接判断与0相等有问题
    if (scrollView.contentOffset.x == 0) {
        //        [_cycleCollectionView setContentOffset:CGPointMake(_cycleCollectionView.bounds.size.width * (_array.count - 2), 0)];
        [_cycleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_array.count - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        _pageControl.currentPage = _array.count - 2;
    } else if (scrollView.contentOffset.x == (_array.count - 1) * _cycleCollectionView.bounds.size.width) {
        //        [_cycleCollectionView setContentOffset:CGPointMake(self.cycleCollectionView.bounds.size.width, 0)];
        [_cycleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        _pageControl.currentPage = 0;
    }
    _titleLabel.text = [NSString stringWithFormat:@"第%ld页", _pageControl.currentPage + 1];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self createTimer];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(cycleImagesActionWithIndexPath:)]) {
        [self.delegate cycleImagesActionWithIndexPath:indexPath];
    }
}

@end

@implementation YRCycleImagesCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        _cycleImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_cycleImageView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
        //        [self.contentView addSubview:_label];
    }
    return self;
}


@end
