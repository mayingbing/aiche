//
//  MAChooseRootViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/25.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAChooseRootViewController.h"

#import "MAJourneyTableViewController.h"
#import "MASafeViewController.h"
#import "MAHomeViewController.h"
#import "DSNavigationBar.h"

#import "MABaseTabBarController.h"

#import "MABaseNavigationController.h"



@implementation MAChooseRootViewController

+(MABaseTabBarController *)chooseRootVcWithWindow{
    
    MABaseTabBarController *baseVC = [[MABaseTabBarController alloc]init];
   
    

    //出行
    MAJourneyTableViewController *journeyVc = [[MAJourneyTableViewController alloc]init];
 
    journeyVc.view.backgroundColor = [UIColor clearColor];
    MABaseNavigationController *journeyNavVc = [[MABaseNavigationController alloc]initWithNavigationBarClass:[DSNavigationBar class] toolbarClass:nil];
    journeyNavVc.viewControllers = @[journeyVc];
    //安全
    
    MASafeViewController *safeVc = [[MASafeViewController alloc]init];
    safeVc.view.backgroundColor = [UIColor clearColor];
    MABaseNavigationController *safeNavVc = [[MABaseNavigationController alloc]initWithNavigationBarClass:[DSNavigationBar class] toolbarClass:nil];
    safeNavVc.viewControllers = @[safeVc];
    

    
    // 到家
    
    MAHomeViewController *homeVc = [[MAHomeViewController alloc]init];
    homeVc.view.backgroundColor = [UIColor clearColor];
    MABaseNavigationController *homeNavVc = [[MABaseNavigationController alloc]initWithNavigationBarClass:[DSNavigationBar class] toolbarClass:nil];
    homeNavVc.viewControllers = @[homeVc];
    
    
    baseVC.viewControllers = @[journeyNavVc,safeNavVc,homeNavVc];
    
    
    return baseVC;
}

@end
