//
//  MASafeViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/25.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MASafeViewController.h"
#import "UIImage+Image.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "MASOSTableViewController.h"
#import "MARepairViewController.h"
#import "MABuyViewController.h"

@interface MASafeViewController ()

@property(nonatomic ,strong)UIImageView *buyCarView;
@property(nonatomic ,strong)UIImageView *repairView;
@property(nonatomic ,strong)UIImageView *SOSCarView;

@end

@implementation MASafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem.image = [UIImage imageNamed:@"tab2"];
    
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tab2_press"];
    
    self.title = @"平安";
    
    [self setupChildView];
}
-(void)setupChildView{
    //buycar
  
        [self setBuycar];
    //repair
    
       [self setRepair];
    //sos
    
       [self setSos];
}

-(void)setBuycar{
    UIImageView *buyCarView = [[UIImageView alloc]init];
    [self.view addSubview:buyCarView];
    _buyCarView = buyCarView;
    buyCarView.userInteractionEnabled = YES;
    buyCarView.image = [UIImage imageNamed:@"buycar"];
    buyCarView.layer.cornerRadius = 5;
    buyCarView.layer.masksToBounds = YES;
    
    @weakify(self);
    [buyCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.view.mas_top).with.offset(74);
        make.left.equalTo(self.view.mas_left).with.offset(-5);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(@((self.view.bounds.size.height-153)/3));
    }];
    // 单击的 Recognizer
    UITapGestureRecognizer* jumpToSosVCGesture;
    jumpToSosVCGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToBuyView)];
    jumpToSosVCGesture.numberOfTapsRequired = 1; // 单击
    [self.buyCarView addGestureRecognizer:jumpToSosVCGesture];
}

-(void)setRepair{
    UIImageView *repairView = [[UIImageView alloc]init];
    [self.view addSubview:repairView];
    repairView.image = [UIImage imageNamed:@"repair"];
    _repairView = repairView;
    repairView.userInteractionEnabled = YES;
    repairView.layer.cornerRadius = 5;
    repairView.layer.masksToBounds = YES;
    @weakify(self);
    [repairView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.buyCarView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(-5);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(@((self.view.bounds.size.height-153)/3));
    }];
    // 单击的 Recognizer
    UITapGestureRecognizer* jumpToSosVCGesture;
    jumpToSosVCGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToRepairView)];
    jumpToSosVCGesture.numberOfTapsRequired = 1; // 单击
    [self.repairView addGestureRecognizer:jumpToSosVCGesture];

}
-(void)setSos{
    UIImageView *SOSCarView = [[UIImageView alloc]init];
    [self.view addSubview:SOSCarView];
    SOSCarView.image = [UIImage imageNamed:@"sos"];
    _SOSCarView = SOSCarView;
    SOSCarView.userInteractionEnabled = YES;
    SOSCarView.layer.cornerRadius = 5;
    SOSCarView.layer.masksToBounds = YES;
    @weakify(self);
    [SOSCarView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.repairView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(-5);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.equalTo(@((self.view.bounds.size.height-153)/3));
    }];
    
    // 单击的 Recognizer
    UITapGestureRecognizer* jumpToSosVCGesture;
    jumpToSosVCGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpToSosView)];
    jumpToSosVCGesture.numberOfTapsRequired = 1; // 单击
    [self.SOSCarView addGestureRecognizer:jumpToSosVCGesture];
  
}
-(void)jumpToSosView{
    
    MASOSTableViewController *SosVC = [[MASOSTableViewController alloc]init];
    [self.navigationController pushViewController:SosVC animated:YES];
    
}
-(void)jumpToBuyView{
    MABuyViewController *SosVC = [[MABuyViewController alloc]init];
    [self.navigationController pushViewController:SosVC animated:YES];
}
-(void)jumpToRepairView{
    MARepairViewController *SosVC = [[MARepairViewController alloc]init];
    [self.navigationController pushViewController:SosVC animated:YES];
}
@end
