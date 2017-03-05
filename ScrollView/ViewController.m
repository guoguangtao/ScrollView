//
//  ViewController.m
//  ScrollView
//
//  Created by ggt on 2017/2/27.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "GPRollView.h"

#define kScrollViewWidth 250
#define kScrollViewHeight 200
#define kGap 10
#define kCount 8

@interface ViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView; /**< ScrollView */
@property (nonatomic, weak) GPRollView *gpRollView;

@end

@implementation ViewController


#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

#pragma mark - UI

- (void)setupUI {
    
    
    
    GPRollView *rollView = [[GPRollView alloc] initWithFrame:self.view.bounds imageCount:3 distance:30 gap:10];
    rollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:rollView];
    self.gpRollView = rollView;
}


#pragma mark - Constraints


#pragma mark - Custom Accessors


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - UIScrollViewDelegate


@end
