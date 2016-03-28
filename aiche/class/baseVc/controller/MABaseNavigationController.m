//
//  MABaseNavigationController.m
//  爱车
//
//  Created by mayingbing on 16/3/24.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MABaseNavigationController.h"


@interface MABaseNavigationController ()

@end

@implementation MABaseNavigationController



+(void)initialize{
    //title颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

@end
