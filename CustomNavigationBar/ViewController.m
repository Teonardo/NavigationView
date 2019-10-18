//
//  ViewController.m
//  CustomNavigationBar
//
//  Created by Teonardo on 2019/10/16.
//  Copyright © 2019 Teonardo. All rights reserved.
//

#import "ViewController.h"
#import "Macro.h"
#import "HJNavigationView.h"
#import "Masonry/Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) HJNavigationView *navigationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"1" style:UIBarButtonItemStylePlain target:self action:@selector(clickedItem:)];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"item2" style:UIBarButtonItemStylePlain target:self action:@selector(clickedItem:)];
    
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"山尽3" style:UIBarButtonItemStylePlain target:self action:@selector(clickedItem:)];
    
    //
    UIBarButtonItem *item4 = [[UIBarButtonItem alloc] initWithTitle:@"item4" style:UIBarButtonItemStylePlain target:self action:@selector(clickedItem:)];
    
    UIBarButtonItem *item5 = [[UIBarButtonItem alloc] initWithTitle:@"item5" style:UIBarButtonItemStylePlain target:self action:@selector(clickedItem:)];
    
    UIBarButtonItem *item6 = [[UIBarButtonItem alloc] initWithTitle:@"item6" style:UIBarButtonItemStylePlain target:self action:@selector(clickedItem:)];
    
    UIBarButtonItem *item7 = [[UIBarButtonItem alloc] initWithTitle:@"item7" style:UIBarButtonItemStylePlain target:self action:@selector(clickedItem:)];
    
    UIBarButtonItem *item8 = [[UIBarButtonItem alloc] initWithTitle:@"item8" style:UIBarButtonItemStylePlain target:self action:@selector(clickedItem:)];
    
    UIBarButtonItem *item9 = [[UIBarButtonItem alloc] initWithTitle:@"item9" style:UIBarButtonItemStylePlain target:self action:@selector(clickedItem:)];
    

    self.navigationItem.rightBarButtonItems = @[item1, item2, item3];
    self.navigationItem.leftBarButtonItems = @[item4, item5, item6];
//     self.navigationItem.leftBarButtonItems = @[item4];
    self.navigationItem.title = @"白日依山尽";
//    self.navigationController.navigationBar
    
    [self addNavigationView];
}

- (void)addNavigationView {
    [self.view addSubview:self.navigationView];
    self.navigationView.backgroundColor = [UIColor redColor];
    
    [self.navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NAVIGATION_BAR_MAX_Y);
        make.left.right.equalTo(self.view);
    }];;
}

- (void)clickedItem:(UIBarButtonItem *)item {
    
}


#pragma mark - Getter
- (HJNavigationView *)navigationView {
    if (!_navigationView) {
        _navigationView = [HJNavigationView new];
        
        UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button1 setTitle:@"item1" forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        
        UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button2 setTitle:@"item22" forState:UIControlStateNormal];
        
        UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button3 setTitle:@"item333" forState:UIControlStateNormal];
        
        UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button4 setTitle:@"item4444" forState:UIControlStateNormal];
        
        UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
        [button5 setTitle:@"item55555" forState:UIControlStateNormal];
        
//        _navigationView.rightItems = @[button1, button2];
//        _navigationView.leftItems = @[button3, button4, button5];
        _navigationView.rightItem = button1;
//        _navigationView.leftItem = button2;
        
        // 设置返回按钮图片
        _navigationView.backIndicatorImage = [UIImage imageNamed:@"back"];
        _navigationView.backButtonAction = ^(UIButton * _Nonnull button) {
            
        };
        
        // 设置标题
        _navigationView.title = @"白日依山尽,黄河入海流"; // 白日依山尽,黄河入海流
        
        // 设置背景图片
        _navigationView.backgroundImage = [UIImage imageNamed:@"background"];
        
        // 隐藏返回按钮
//        _navigationView.hidesBackButton = YES;
    }
    return _navigationView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.navigationView.title = @"呵呵";
    
    // 隐藏返回按钮
    _navigationView.hidesBackButton = YES;
    
    _navigationView.rightItem = nil;
}

@end
