//
//  HJNavigationView.m
//  HJBim
//
//  Created by Teonardo on 2019/10/16.
//  Copyright © 2019 huajie. All rights reserved.
//

#import "HJNavigationView.h"
#import "Masonry/Masonry.h"

@interface HJNavigationView ()
/** 显示背景图片*/
@property (nonatomic, strong) UIImageView *backgroundImageView;
/** 左侧所有 Button 的容器视图*/
@property (nonatomic, strong) UIView *leftItemsContainerView;
/** 右侧所有 Button 的容器视图*/
@property (nonatomic, strong) UIView *rightItemsContainerView;

@end

/*
 * 布局尺寸:
 * 两测item 最里面 的两个 之间的距离 至少为 12.
 */

static CGFloat const kTitleViewMargin = 6.f;  // titleView 与 相邻 item 的最小间隙 为 6
static CGFloat const kItemSpacing = 8.f;      // item 之间的水平间隙为 8.
static CGFloat const kItemInset = 12.f;       // 两边 item 距离屏幕的距离为12.
static CGFloat const kItemContentSize = 20.f; // item 为图片时, 其内容的的推荐大小为 20*20.
static CGFloat const kFontSize = 17.f;        // 标题和item的文字大小相同, 标题加粗.


@implementation HJNavigationView
@synthesize titleView = _titleView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(NAVIGATION_BAR_MAX_Y).priority(999);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    // 背景
    _backgroundImageView.frame = self.bounds;
    
    // titleView
    [_titleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        make.top.equalTo(self).offset(STATUS_BAR_SAFE_HEIGHT);
        
        if ([self->_titleView isKindOfClass:[UILabel class]]) { // TODO: 支持其他类型视图
            CGFloat titleWidth = [self->_titleView sizeThatFits:CGSizeMake(CGFLOAT_MAX, kItemContentSize)].width;
            CGFloat leftWidth = CGRectGetWidth(self->_leftItemsContainerView.frame);
            CGFloat rightWidth = CGRectGetWidth(self->_rightItemsContainerView.frame);
            CGFloat theBiggerWidth = MAX(leftWidth, rightWidth);
            if (theBiggerWidth + titleWidth / 2.0 > SCREEN_WIDTH / 2.0) { // titleView 居中显示不下
                // 左侧距离大于右侧
                if (leftWidth > rightWidth) {
                    make.left.equalTo(self->_leftItemsContainerView.mas_right).offset(kTitleViewMargin);
                    
                    if (self->_rightItemsContainerView) {
                        make.right.lessThanOrEqualTo(self->_rightItemsContainerView.mas_left).offset(-kTitleViewMargin);
                    } else {
                        make.right.lessThanOrEqualTo(self).offset(-kTitleViewMargin);
                    }
                }
                // 右侧距离大于左侧
                else if (leftWidth < rightWidth) {
                    if (self->_leftItemsContainerView) {
                        make.left.greaterThanOrEqualTo(self->_leftItemsContainerView.mas_right).offset(kTitleViewMargin);
                    } else {
                        make.left.greaterThanOrEqualTo(self).offset(kTitleViewMargin);
                    }
                    make.right.equalTo(self->_rightItemsContainerView.mas_left).offset(-kTitleViewMargin);
                }
                // 两侧距离相等
                else {
                    if (self->_leftItemsContainerView) {
                        make.left.greaterThanOrEqualTo(self->_leftItemsContainerView.mas_right).offset(kTitleViewMargin);
                    } else {
                        make.left.greaterThanOrEqualTo(self).offset(kTitleViewMargin);
                    }
                    
                    if (self->_rightItemsContainerView) {
                        make.right.lessThanOrEqualTo(self->_rightItemsContainerView.mas_left).offset(-kTitleViewMargin);
                    } else {
                        make.right.lessThanOrEqualTo(self).offset(-kTitleViewMargin);
                    }
                }
                
            } else { // titleView 可以居中完整显示
                make.centerX.equalTo(self);
            }
        }
    }];
}

#pragma mark - Action
- (void)clickedBackButton:(UIButton *)buttton {
    !self.backButtonAction ? : self.backButtonAction(buttton);
}

#pragma mark - Private Method
- (UILabel *)createTitleLabel {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont boldSystemFontOfSize:kFontSize];
    label.textAlignment = NSTextAlignmentCenter;
    //label.backgroundColor = [UIColor brownColor];
    return label;
}

- (void)addItems:(NSArray<UIButton *>*)items  toLeft:(BOOL)isLeft {
    
    UIView *containerView = isLeft ? self.leftItemsContainerView : self.rightItemsContainerView;
    
    __block UIButton *lastButton = nil;
    NSInteger count = items.count;
    [items enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.titleLabel.font = [UIFont systemFontOfSize:kFontSize]; // 强制字体大小
        obj.titleLabel.numberOfLines = 1; // 强制单行显示
        obj.backgroundColor = [UIColor blueColor];
        [containerView addSubview:obj];
        
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            if (idx == 0) {
                make.left.equalTo(containerView).offset(isLeft ? kItemInset : 0);
            } else {
                make.left.equalTo(lastButton.mas_right).offset(kItemSpacing);
            }
            make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
            if ([obj imageForState:UIControlStateNormal]) {
                make.width.mas_greaterThanOrEqualTo(30); // 限制最小响应范围
            }
            make.centerY.equalTo(containerView);
            if (idx == count - 1) {
                make.right.equalTo(containerView).offset(isLeft ? 0 : -kItemInset);;
            }
        }];
        
        lastButton = obj;
    }];
}

#pragma mark - Setter
- (void)setLeftItems:(NSArray<UIButton *> *)leftItems {
    _leftItems = [leftItems copy];
    [_leftItemsContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (leftItems.count > 0) {
        [self addItems:leftItems toLeft:YES];
    }

    [self setNeedsLayout];
}

- (void)setRightItems:(NSArray<UIButton *> *)rightItems {
    _rightItems = [rightItems copy];
    
    [_rightItemsContainerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    if (rightItems.count > 0) {
        NSArray *reverseArr = [[rightItems reverseObjectEnumerator] allObjects];
        [self addItems:reverseArr toLeft:NO];
    }
    
    [self setNeedsLayout];
}

- (void)setLeftItem:(UIButton *)leftItem {
    _leftItem = leftItem;
    if (leftItem) {
        self.leftItems = @[leftItem];
    } else {
        self.leftItems = @[];
    }
}

- (void)setRightItem:(UIButton *)rightItem {
    _rightItem = rightItem;
    if (rightItem) {
        self.rightItems = @[rightItem];
    } else {
        self.rightItems = @[];
    }
}

- (void)setTitle:(NSString *)title {
    if (![_title isEqualToString:title]) {
        _title = [title copy];
        
        if ([self.titleView isKindOfClass:[UILabel class]]) {
            [(UILabel *)self.titleView setText:title];
        } else { // 设置 title 会覆盖 titleView 的配置
            self.titleView = [self createTitleLabel];
            [(UILabel *)self.titleView setText:title];
        }
    }
}

- (void)setTitleView:(UIView *)titleView {
    if (_titleView != titleView) {
        [_titleView removeFromSuperview];
        [self addSubview:titleView];
        _titleView = titleView;
        
        [titleView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    }
}

- (void)setBackIndicatorImage:(UIImage *)backIndicatorImage {
    if (_backIndicatorImage != backIndicatorImage) {
        _backIndicatorImage = backIndicatorImage;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:backIndicatorImage forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickedBackButton:) forControlEvents:UIControlEventTouchUpInside];
        self.leftItem = button;
    }
}

- (void)setHidesBackButton:(BOOL)hidesBackButton {
    [_leftItem setHidden:hidesBackButton];
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if (_backgroundImage != backgroundImage) {
        _backgroundImage = backgroundImage;
        
        self.backgroundImageView.image = backgroundImage;
    }
}

#pragma mark - Getter

- (UIImageView *)backgroundImageView {
    if (!_backgroundImageView) {
        _backgroundImageView = [UIImageView new];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self insertSubview:_backgroundImageView atIndex:0];
    }
    return _backgroundImageView;
}

- (UIView *)leftItemsContainerView {
    if (!_leftItemsContainerView) {
        _leftItemsContainerView = [UIView new];
        //_leftItemsContainerView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_leftItemsContainerView];
        [_leftItemsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.top.equalTo(self).offset(STATUS_BAR_SAFE_HEIGHT);
            make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        }];
    }
    return _leftItemsContainerView;
}

- (UIView *)rightItemsContainerView {
    if (!_rightItemsContainerView) {
        _rightItemsContainerView = [UIView new];
        //_rightItemsContainerView.backgroundColor = [UIColor yellowColor];
        [self addSubview:_rightItemsContainerView];
        [_rightItemsContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.top.equalTo(self).offset(STATUS_BAR_SAFE_HEIGHT);
            make.height.mas_equalTo(NAVIGATION_BAR_HEIGHT);
        }];
    }
    return _rightItemsContainerView;
}

- (UIView *)titleView {
    if (!_titleView) {
        self.titleView = [self createTitleLabel];
    }
    return _titleView;
}

@end
