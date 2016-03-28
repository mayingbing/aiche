//
//  MAHomeViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/25.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAHomeViewController.h"
#import "UIImage+Image.h"

@interface MAHomeViewController ()

@end

@implementation MAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.image = [UIImage imageNamed:@"tab3"];
    
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tab3_press"];

    self.title = @"到家";
    
   
    
}

@end
