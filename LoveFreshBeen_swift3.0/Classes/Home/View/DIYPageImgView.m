//
//  DIYPageImgView.m
//  DIYPageImg
//
//  Created by HOWIE-CH on 16/5/16.
//  Copyright © 2016年 XMG. All rights reserved.
//

#import "DIYPageImgView.h"
#import "UIImageView+WebCache.h"

@interface DIYPageImgView () <UIScrollViewDelegate>
/** scrollView 属性 */
@property (nonatomic, weak) UIScrollView *scrollView;
/** UIPageControll 属性 */
@property (nonatomic, weak) UIPageControl *pageControll;
/** 中间的imgView 属性 */
@property (nonatomic, weak) UIImageView *centerImgView;
/** 左边的imgView 属性 */
@property (nonatomic, weak) UIImageView *leftImgView;
/** 右边的imgView 属性 */
@property (nonatomic, weak) UIImageView *rightImgView;
/** 中间的索引 属性 */
@property (nonatomic, assign) NSInteger centerIndex;
/** NSTimer 属性 */
@property (nonatomic, weak) NSTimer *autoTimer;
/** 记录是否是自动 状态 属性 */
@property (nonatomic, assign, getter=isAutoScroll) BOOL autoScroll;
@end

@implementation DIYPageImgView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];

    }
    return self;
}
- (void)setup {
    // ----- scrollView -----
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
   
    // ----- 三个imgView -----
    UIImageView *leftImgView = [[UIImageView alloc]init];
    [self.scrollView addSubview:leftImgView];
    self.leftImgView = leftImgView;
    UIImageView *centerImgView = [[UIImageView alloc]init];
    [self.scrollView addSubview:centerImgView];
    self.centerImgView = centerImgView;
    UIImageView *rightImgView = [[UIImageView alloc]init];
    [self.scrollView addSubview:rightImgView];
    self.rightImgView = rightImgView;
    
    
    // ----- pageControll -----
    UIPageControl *pageControll = [[UIPageControl alloc]init];
    pageControll.currentPageIndicatorTintColor = [UIColor blueColor];
    pageControll.pageIndicatorTintColor = [UIColor redColor];
    pageControll.enabled = NO;
    
    [self addSubview:pageControll];
    self.pageControll = pageControll;
    [self bringSubviewToFront:pageControll];
    
    // ----- 定时器 -----
    self.autoScroll = YES;
    if (self.isAutoScroll) {
        NSTimer *autoTimer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:autoTimer forMode:NSRunLoopCommonModes];
        self.autoTimer = autoTimer;
    }
}
- (void)awakeFromNib {

    [self setup];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    self.pageControll.frame = CGRectMake(self.frame.size.width - 5 - 80, self.frame.size.height - 5 - 15, 80, 15);
    
    self.leftImgView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.centerImgView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    self.rightImgView.frame = CGRectMake(2 * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(3 * self.frame.size.width, self.frame.size.height);
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
}

- (void)setImgUrlArray:(NSArray *)imgUrlArray {
    _imgUrlArray = imgUrlArray;
    [self loadImg];
    self.pageControll.hidesForSinglePage = YES;
    self.pageControll.currentPage = self.centerIndex;
    self.pageControll.numberOfPages = self.imgUrlArray.count;
    
}


#pragma mark - **** scrollView 代理 ****
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    NSLog(@"%s", __func__);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%s", __func__);
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    NSLog(@"%s", __func__);
    if (!self.isAutoScroll) {
         [self.autoTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    }
    self.autoScroll = NO;
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"%s", __func__);
    if (!self.isAutoScroll) {
        [self.autoTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    }
    self.autoScroll = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"%s", __func__);

    if (self.scrollView.contentOffset.x >= self.frame.size.width + 0.5 * self.frame.size.width) {
        self.centerIndex = (self.centerIndex + 1) % self.imgUrlArray.count;
        self.pageControll.currentPage = self.centerIndex;
    } else if (self.scrollView.contentOffset.x <= self.frame.size.width -  0.5 * self.frame.size.width) {
        self.centerIndex = (self.centerIndex - 1 + self.imgUrlArray.count) % self.imgUrlArray.count;
        self.pageControll.currentPage = self.centerIndex;
    }
    [self loadImg];
    self.scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
    if (!self.isAutoScroll) {
        [self.autoTimer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    }
    self.autoScroll = NO;
}
#pragma mark - **** 加载图片 ****
- (void)loadImg {
    NSInteger leftIndex = (self.centerIndex - 1 + self.imgUrlArray.count) % self.imgUrlArray.count;
    NSInteger rightIndex = (self.centerIndex + 1) % self.imgUrlArray.count;
    [self.centerImgView sd_setImageWithURL:self.imgUrlArray[self.centerIndex]];
    [self.leftImgView sd_setImageWithURL:self.imgUrlArray[leftIndex]];
    [self.rightImgView sd_setImageWithURL:self.imgUrlArray[rightIndex]];
    
    
//    self.leftImgView.image = [UIImage imageNamed:self.imgUrlArray[leftIndex]];
//    self.centerImgView.image = [UIImage imageNamed:self.imgUrlArray[self.centerIndex]];
//    self.rightImgView.image = [UIImage imageNamed:self.imgUrlArray[rightIndex]];
//    
}
#pragma mark - **** 定时器调用方法 ****
- (void)autoScroll {

    [self.scrollView setContentOffset:CGPointMake(2 * self.frame.size.width, 0)animated:YES];
    self.autoScroll = YES;
    [self performSelector:@selector(scrollViewDidEndDecelerating:) withObject:nil afterDelay:0.5];
    
}
@end
