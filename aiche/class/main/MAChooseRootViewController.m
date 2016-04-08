//
//  MAChooseRootViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/25.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAChooseRootViewController.h"

#import "MAJourneyViewController.h"

#import "MAHomeTableViewController.h"
#import "MASafeViewController.h"
#import "MABaseTabBarController.h"

#import "MABaseNavigationController.h"



@implementation MAChooseRootViewController

+(MABaseTabBarController *)chooseRootVcWithWindow{
    
    MABaseTabBarController *baseVC = [[MABaseTabBarController alloc]init];
   
    
    //出行
    MAJourneyViewController *journeyVc = [[MAJourneyViewController alloc]init];
    journeyVc.view.backgroundColor = [UIColor clearColor];
    MABaseNavigationController *journeyNavVc = [[MABaseNavigationController alloc]initWithRootViewController:journeyVc];
    
    //安全
    
    MASafeViewController *safeVc = [[MASafeViewController alloc]init];
    safeVc.view.backgroundColor = [UIColor lightGrayColor];
    MABaseNavigationController *safeNavVc = [[MABaseNavigationController alloc]initWithRootViewController:safeVc];

    
    
    
    // 到家
    
    MAHomeTableViewController *homeVc = [[MAHomeTableViewController alloc]init];
    homeVc.view.backgroundColor = [UIColor whiteColor];
    MABaseNavigationController *homeNavVc = [[MABaseNavigationController alloc]initWithRootViewController:homeVc];
    


    
    
    journeyNavVc.viewControllers = @[journeyVc];
    
    
    
    baseVC.viewControllers = @[journeyNavVc,safeNavVc,homeNavVc];
    
    
    return baseVC;
}

@end
