//
//  HJNavigationView.h
//  HJBim
//
//  Created by Teonardo on 2019/10/16.
//  Copyright © 2019 huajie. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef HJNavigationView_H
#define HJNavigationView_H

/* 屏幕的宽度, 也即视图控制器的 view 的宽度 */
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

/* 屏幕的高度, 也即视图控制器的 view 的高度 */
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/* 是否是 iPhoneX */
#define IS_IPHONE_X (\
UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && \
MAX(SCREEN_WIDTH, SCREEN_HEIGHT) == 812.0f \
|| MAX(SCREEN_WIDTH, SCREEN_HEIGHT) == 896.0f)

/* 状态栏高度. 在 iPhone X 机型上由于齐刘海的设计, 状态栏的高度比一般机型的要多24PT, 为44 PT */
#define STATUS_BAR_SAFE_HEIGHT (IS_IPHONE_X ? 44.f : 20.f)

/* 导航栏的高度 */
#define NAVIGATION_BAR_HEIGHT (44.f)

/* 导航栏底部到屏幕顶部的距离 */
#define NAVIGATION_BAR_MAX_Y (STATUS_BAR_SAFE_HEIGHT + NAVIGATION_BAR_HEIGHT)

#endif



NS_ASSUME_NONNULL_BEGIN

@interface HJNavigationView : UIView

/**
 用法同 navigationItem.leftBarButtonItem 类似
 */
@property (nonatomic, strong, nullable) UIButton *leftItem;

/**
 用法同 navigationItem.rightBarButtonItem 类似
 */
@property (nonatomic, strong, nullable) UIButton *rightItem;

/**
 用法同 navigationItem.leftBarButtonItems 类似
 */
@property (nonatomic, copy, nullable) NSArray <UIButton *>*leftItems;

/**
 用法同 navigationItem.rightBarButtonItems 类似
 */
@property (nonatomic, copy, nullable) NSArray <UIButton *>*rightItems;

/**
 自定义titleView, 目前仅支持 UILabel 类型, 待后期扩展.
 */
@property(nonatomic, strong, nullable) UIView *titleView;

/**
 设置标题
 */
@property(nonatomic, copy, nullable) NSString *title;

/**
 返回按钮图片
 */
@property(nonatomic, strong, nullable) UIImage *backIndicatorImage;

/**
 通过设置 backIndicatorImage 设置返回按钮时, 返回按钮的点击事件
 */
@property (nonatomic, copy) void(^backButtonAction)(UIButton *button);

/**
 通过设置 backIndicatorImage 设置返回按钮时, 控制返回按钮的隐藏
 */
@property (nonatomic, assign) BOOL hidesBackButton;

/**
 背景图片
 */
@property (nonatomic, strong, nullable) UIImage *backgroundImage;

@end

NS_ASSUME_NONNULL_END
