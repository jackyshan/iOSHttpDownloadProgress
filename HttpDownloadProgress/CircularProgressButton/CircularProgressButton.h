//
//  CircularProgressButton.h
//  CircularProgressButton
//圆形进度条
//  Created by jackyshan on 15/3/11.
//  Copyright (c) 2015年 jackyshan. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol CircularProgressButtonDelegate <NSObject>

@optional

- (void)updateProgressViewWithProgress:(float)progress;

@end

@interface CircularProgressButton : UIButton
@property (nonatomic, assign) float progress;
@property (nonatomic, strong) UIColor *backColor;
@property (nonatomic, strong) UIColor *progressColor;
@property (assign, nonatomic) CGFloat lineWidth;
@property (weak, nonatomic) id <CircularProgressButtonDelegate> delegate;

- (id)initWithFrame:(CGRect)frame
          backGressColor:(UIColor *)backColor
      progressColor:(UIColor *)progressColor
          lineWidth:(CGFloat)lineWidth;

- (void)setProgress:(float)progress;
@end