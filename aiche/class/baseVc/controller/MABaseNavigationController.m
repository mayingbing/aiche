//
//  MABaseNavigationController.m
//  爱车
//
//  Created by mayingbing on 16/3/24.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MABaseNavigationController.h"
#import "UIBarButtonItem+MaBarButtonItem.h"


@interface MABaseNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) id popDelegate;

@end

@implementation MABaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
}

+(void)initialize{
    //title颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor greenColor]}];
    // 获取当前类下面的UIBarButtonItem
    UIBarButtonItem *item = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor redColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateNormal];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count) { // 不是根控制器
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *left = [UIBarButtonItem barButtonItemWithImage:nil highImage:nil target:self action:@selector(popToPre) title:@"返回" forControlEvents:UIControlEventTouchUpInside];
        // 设置导航条的按钮
        viewController.navigationItem.leftBarButtonItem = left;
        
        UIBarButtonItem *right = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationbar_more"] highImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] target:self action:@selector(popToRoot)title:nil forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = right;
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)popToRoot
{
    [self popToRootViewControllerAnimated:YES];
}
- (void)popToPre
{
    [self popViewControllerAnimated:YES];
}
/*
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    // 删除系统自带的tabBarButton
    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
      //  if (![tabBarButton isKindOfClass:[CZTabBar class]]) {
            [tabBarButton removeFromSuperview];
        }
    }
*/


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) { // 是根控制器
        
        self.interactivePopGestureRecognizer.delegate = nil;
        
    }else{ // 非根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
        
    }
}
@end
