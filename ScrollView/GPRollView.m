//
//  GPRollView.m
//  ScrollView
//
//  Created by ggt on 2017/2/27.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "GPRollView.h"
#import "Masonry.h"

@interface GPRollView () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) NSUInteger count; /**< 图片个数 */
@property (nonatomic, assign) CGFloat gap; /**< 间距 */
@property (nonatomic, assign) CGFloat distance; /**< ScrollView 与 view 间距 */
@property (nonatomic, strong) NSTimer *timer; /**< 定时器 */
@property (nonatomic, assign) NSInteger index; /**< 索引 */
@property (nonatomic, assign) CGFloat time; /**< 定时器间隔时间 */
@property (nonatomic, assign, getter=isDragging) BOOL dragging; /**< 是否拖拽 */

@end

@implementation GPRollView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame imageCount:(NSUInteger)imageCount distance:(CGFloat)distance gap:(CGFloat)gap {
    
    if (self = [super initWithFrame:frame]) {
        
        self.gap = gap;
        self.distance = distance;
        self.count = imageCount;
        self.index = 2;
        self.time = 2.0f;
        self.dragging = NO;
        [self setupUI];
        [self timerStart];
    }
    
    return self;
}


#pragma mark - UI

- (void)setupUI {
    
    // 1.ScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(self.distance, 0, self.bounds.size.width - 2 * self.distance, self.bounds.size.height)];
    scrollView.pagingEnabled = YES;
    scrollView.clipsToBounds = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 2.创建界面    
    CGFloat itemWidth = scrollView.bounds.size.width - self.gap;
    CGFloat itemHeight = 200;
    CGFloat itemY = (scrollView.bounds.size.height - itemHeight) * 0.5;
    CGFloat itemX;
    for (int i = 0; i < self.count + 4; i++) {
        
        itemX = (2 * i + 1) * self.gap * 0.5 + i * itemWidth;
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor =  [UIColor colorWithRed:arc4random_uniform(256.0f)/255.0f green:arc4random_uniform(256.0f)/255.0f blue:arc4random_uniform(256.0f)/255.0f alpha:1.0f];
        imageView.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
        imageView.tag = 200 + i;
        [scrollView addSubview:imageView];
        if (i == self.count + 3) {
            scrollView.contentSize = CGSizeMake(CGRectGetMaxX(imageView.frame) + 0.5 * self.gap, 0);
        }
        UIImage *image;
        if (i == 0) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)self.count - 1]];
        } else if (i == 1) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", (long)self.count]];
        } else if (i == self.count + 2) {
            image = [UIImage imageNamed:@"1.jpg"];
        } else if (i == self.count + 3) {
            image = [UIImage imageNamed:@"2.jpg"];
        } else {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i - 1]];
        }
        imageView.image = image;
    }
    
    scrollView.contentOffset = CGPointMake((itemWidth + self.gap) * 2, 0);
}


#pragma mark - Constraints


#pragma mark - Custom Accessors


#pragma mark - IBActions


#pragma mark - Public

- (void)invalidateTimer {
    
    [self.timer invalidate];
}


#pragma mark - Private

/**
 定时器开始
 */
- (void)timerStart {
    
    self.timer = [NSTimer timerWithTimeInterval:self.time target:self selector:@selector(nexIndex) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/**
 定时器方法
 */
- (void)nexIndex {
    
    self.index++;
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * self.index, 0) animated:YES];
    if (self.index == self.count + 3) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * 2, 0);
        self.index = 3;
    }
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    self.scrollView.scrollEnabled = NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.scrollView.scrollEnabled = YES;
    // 实现无限循环滚动
    NSInteger curIndex = scrollView.contentOffset.x  / self.scrollView.frame.size.width;
    self.index = curIndex;
    if (curIndex == self.count + 2) {
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * 2, 0);
        self.index = 2;
    }else if (curIndex == 1){
        scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * (self.count + 1), 0);
        self.index = 4;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    // 结束定时器操作
    [self invalidateTimer];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    // 开启定时器
    [self timerStart];
}

@end
