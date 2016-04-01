//
//  MASosViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/1.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MASosViewController.h"
#import "MABtnsView.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "MAbtnBaseView.h"

#define screenSize [UIScreen mainScreen].bounds.size

@interface MASosViewController ()<MABtnsViewDelegate>

@property(nonatomic ,assign) BOOL isShowTelView;
@property(nonatomic ,strong) MABtnsView *btnsView;

@end

@implementation MASosViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpChildView];
    
}

-(void)setUpChildView{
    
    UIView *telShowView = [[UIView alloc]initWithFrame:CGRectMake(0, screenSize.height-98, screenSize.width/3, 200)];
    telShowView.layer.cornerRadius = 3;
    telShowView.layer.masksToBounds = YES;
    [self.view addSubview:telShowView];
    telShowView.backgroundColor = [UIColor lightGrayColor];
    _telShowView = telShowView;
    [self setShowTelView];
    
    
    
    UIView *movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, screenSize.width, screenSize.height-65-100)];
    [self.view addSubview:movieView];
    movieView.backgroundColor = [UIColor whiteColor];
    
    
    
    MABtnsView *btnsView = [[MABtnsView alloc]initWithFrame:CGRectMake(0, screenSize.height-98, screenSize.width, 98)];
    btnsView.delegate = self;
    [self.view addSubview:btnsView];
    
    _btnsView = btnsView;
    btnsView.backgroundColor = [UIColor whiteColor];
    
}

#pragma ma
-(void)MABtnsViewJumpOutOrInWithMABtnsView:(MABtnsView *)maBtnView{
    
    if (!_isShowTelView) {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.telShowView.frame = CGRectMake(0, screenSize.height-98-200, screenSize.width/3, 200);
            maBtnView.telView.btnLable.text = @"点击关闭";
           
        } completion:^(BOOL finished) {
             [self.view bringSubviewToFront:self.telShowView];
            _isShowTelView = YES;
        }];
    }else{
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.telShowView.frame = CGRectMake(0, screenSize.height-98, screenSize.width/3, 200);
            [self.view bringSubviewToFront:self.btnsView];
            maBtnView.telView.btnLable.text = @"紧急呼叫";
        } completion:^(BOOL finished) {
            
            _isShowTelView = NO;
        }];
        
    }

}

-(void)setShowTelView{
    //交警：122
    UILabel *jiaojingTel = [[UILabel alloc]initWithFrame:CGRectMake(5, 20, screenSize.width/3-5, 20)];
    [self.telShowView addSubview:jiaojingTel];
    jiaojingTel.font =  [UIFont systemFontOfSize:20];
    jiaojingTel.text = @"交警:122\n";
    jiaojingTel.userInteractionEnabled = YES;
    jiaojingTel.textColor = [UIColor greenColor];
    [self.telShowView addSubview:jiaojingTel];
    
    UITapGestureRecognizer *tapjiaojingTelGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpTojiaojingTel)];
    [jiaojingTel addGestureRecognizer:tapjiaojingTelGesture];
    
    
    //急救：120
    UILabel *jijiuTel = [[UILabel alloc]initWithFrame:CGRectMake(5, 65, screenSize.width/3-5, 20)];
    [self.telShowView addSubview:jijiuTel];
    jijiuTel.font =  [UIFont systemFontOfSize:20];
    jijiuTel.textColor = [UIColor greenColor];
    jijiuTel.text = @"急救:120\n";
    jijiuTel.userInteractionEnabled = YES;
    [self.telShowView addSubview:jijiuTel];
    
    UITapGestureRecognizer *jijiuTelGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpTojijiuTel)];
    [jijiuTel addGestureRecognizer:jijiuTelGesture];
    
    
    //公安：110
    UILabel *gonganTel = [[UILabel alloc]initWithFrame:CGRectMake(5, 110, screenSize.width/3-5, 20)];
    [self.telShowView addSubview:gonganTel];
    gonganTel.font =  [UIFont systemFontOfSize:20];
    gonganTel.textColor = [UIColor greenColor];
    gonganTel.text = @"公安:110\n";
    gonganTel.userInteractionEnabled = YES;
    [self.telShowView addSubview:gonganTel];
    
    UITapGestureRecognizer *gonganTelGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpTogonganTel)];
    [gonganTel addGestureRecognizer:gonganTelGesture];
    
    
    //消防：119
    UILabel *xiaofangTel = [[UILabel alloc]initWithFrame:CGRectMake(5, 155, screenSize.width/3-5, 20)];
    [self.telShowView addSubview:xiaofangTel];
    xiaofangTel.font =  [UIFont systemFontOfSize:20];
    xiaofangTel.textColor = [UIColor greenColor];
    xiaofangTel.text = @"消防:119\n";
    xiaofangTel.userInteractionEnabled = YES;
    [self.telShowView addSubview:xiaofangTel];
    
    UITapGestureRecognizer *xiaofangTelGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpToxiaofangTel)];
    [xiaofangTel addGestureRecognizer:xiaofangTelGesture];
    
    
}
 //交警：122
-(void)jumpTojiaojingTel{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://122"]];
    
}
//急救：120
-(void)jumpTojijiuTel{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://120"]];
    
}
//公安：110
-(void)jumpTogonganTel{
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://110"]];
}
//消防：119
-(void)jumpToxiaofangTel{
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"tel://119"]];
}
@end
