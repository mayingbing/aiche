//
//  MABaseTabBarController.m
//  爱车
//
//  Created by mayingbing on 16/3/25.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MABaseTabBarController.h"

@interface MABaseTabBarController ()

@end

@implementation MABaseTabBarController



+(void)initialize{
    
    NSMutableArray *classArr = [NSMutableArray array];
    [classArr addObject:[self class]];
    // 获取当前类下面的UIBarButtonItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:classArr];
    
    // 设置导航条按钮的文字颜色
    NSMutableDictionary *titleAttr = [NSMutableDictionary dictionary];
    titleAttr[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:titleAttr forState:UIControlStateSelected];

    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

@end
