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

@interface MANewFeatureViewController ()<DGAaimaViewDelegate>
@property(nonatomic ,strong) UIImageView *imgView;

@end

@implementation MANewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    DGAaimaView *animaView = [[DGAaimaView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:animaView];
    
    animaView.delegate = self;
    
}


-(void)stopAnimateViewWith:(DGAaimaView *)animateView{
    if (self.imgView==nil) {
        self.imgView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:self.imgView];
    }
    [self.imgView setImage:[UIImage imageNamed:@"newFeature"]];
    
    self.imgView.alpha=0;
    

    
    [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState  animations:^{
        animateView.alpha = 0.2;
        
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            self.imgView.alpha=1;
        } completion:^(BOOL finished) {
            
            
        }];
        
    } completion:^(BOOL finished) {
        
        if (finished) {
            [animateView removeFromSuperview];
        }
        
    }];
    
}


-(void)jumpToMainViewController{
    
    MABaseTableViewController *baseTableVc = [[MABaseTableViewController alloc]init];
    
    MABaseNavigationController *baseNavigationVc = [[MABaseNavigationController alloc]initWithRootViewController:baseTableVc];
    
}

@end
