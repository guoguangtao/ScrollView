//
//  GPRollView.h
//  ScrollView
//
//  Created by ggt on 2017/2/27.
//  Copyright © 2017年 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GPRollView : UIView



/**
 自定义构造方法

 @param frame Frame
 @param imageCount 个数
 @param distance  ScrollView 与 view 水平方向的间距
 @param gap 每个图片之间的间距
 */
- (instancetype)initWithFrame:(CGRect)frame imageCount:(NSUInteger)imageCount distance:(CGFloat)distance gap:(CGFloat)gap;

/**
 关闭定时器
 */
- (void)invalidateTimer;

@end
