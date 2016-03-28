//
//  MASafeViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/25.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MASafeViewController.h"
#import "UIImage+Image.h"

@interface MASafeViewController ()

@end

@implementation MASafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.image = [UIImage imageNamed:@"tab2"];
    
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tab2_press"];
    
    
    
    self.title = @"平安";
}

@end
