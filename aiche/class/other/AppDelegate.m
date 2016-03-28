//
//  AppDelegate.m
//  aiche
//
//  Created by mayingbing on 16/3/23.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "AppDelegate.h"
#import "MANewFeatureViewController.h"
#import "DGAaimaView.h"
#import "MAChooseRootViewController.h"
#import "MABaseTabBarController.h"

#import "DSNavigationBar.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor lightGrayColor];
    
    //设置nav背景色
    UIColor * color = [UIColor colorWithRed:(190/255.0) green:(218/255.0) blue:(218/255) alpha:0];
    [[DSNavigationBar appearance] setNavigationBarWithColor:color];
    UIColor *topColor = [UIColor colorWithRed:(190/255.0) green:(218/255.0) blue:(218/255) alpha:0];
    UIColor *bottomColor = [UIColor colorWithRed:(190/255.0) green:(218/255.0) blue:(218/255) alpha:0];
    [[DSNavigationBar appearance] setNavigationBarWithColors:@[topColor,bottomColor]];
    
    
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSNumber *num = [defaults objectForKey:@"number"];
    
    
    if (num == nil) {
        MANewFeatureViewController *newFeature = [[MANewFeatureViewController alloc]init];
        
        self.window.rootViewController = newFeature;
    }else{
        MABaseTabBarController *baseTabBarVC = [MAChooseRootViewController chooseRootVcWithWindow];
        self.window.rootViewController = baseTabBarVC;
       
    }
    
    
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
