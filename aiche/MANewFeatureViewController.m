//
//  MANewFeatureViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/24.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MANewFeatureViewController.h"
#import "MABaseTableViewController.h"
#import "MABaseNavigationController.h"
#import "DGAaimaView.h"

@interface MANewFeatureViewController ()

@end

@implementation MANewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    DGAaimaView *animaView = [[DGAaimaView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:animaView];
    
}


-(void)jumpToMainViewController{
    
    MABaseTableViewController *baseTableVc = [[MABaseTableViewController alloc]init];
    
    MABaseNavigationController *baseNavigationVc = [[MABaseNavigationController alloc]initWithRootViewController:baseTableVc];
    
}

@end
