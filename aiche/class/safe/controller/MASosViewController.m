//
//  MASosViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/1.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MASosViewController.h"
#import "MABtnsView.h"

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
    [self.view addSubview:telShowView];
    telShowView.backgroundColor = [UIColor redColor];
    _telShowView = telShowView;
    [self setShowTelView];
    
    
    
    UIView *movieView = [[UIView alloc]initWithFrame:CGRectMake(0, 65, screenSize.width, screenSize.height-65-100)];
    [self.view addSubview:movieView];
    movieView.backgroundColor = [UIColor whiteColor];
    
    
    
    MABtnsView *btnsView = [[MABtnsView alloc]initWithFrame:CGRectMake(0, screenSize.height-98, screenSize.width, 95)];
    btnsView.delegate = self;
    [self.view addSubview:btnsView];
    _btnsView = btnsView;
    btnsView.backgroundColor = [UIColor whiteColor];
    
}

-(void)MABtnsViewJumpOutOrInWithMABtnsView:(MABtnsView *)maBtnView{
    
    if (!_isShowTelView) {
        [UIView animateWithDuration:0.25 animations:^{
            
            self.telShowView.frame = CGRectMake(0, screenSize.height-98-200, screenSize.width/3, 200);
           
        } completion:^(BOOL finished) {
             [self.view bringSubviewToFront:self.telShowView];
            _isShowTelView = YES;
        }];
    }else{
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.telShowView.frame = CGRectMake(0, screenSize.height-98, screenSize.width/3, 200);
            [self.view bringSubviewToFront:self.btnsView];
            
        } completion:^(BOOL finished) {
            
            _isShowTelView = NO;
        }];
        
    }

}

-(void)setShowTelView{
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.telShowView.bounds];
    textView.font = [UIFont systemFontOfSize:18];
    textView.dataDetectorTypes = UIDataDetectorTypePhoneNumber;
    textView.backgroundColor = [UIColor lightGrayColor];
    textView.editable = NO;
    textView.text = @"交警：122 \r\n\r\n"
                        "急救：120 \r\n\r\n"
                        "公安：110 \r\n\r\n";
    [self.telShowView addSubview:textView];
    
}

@end
