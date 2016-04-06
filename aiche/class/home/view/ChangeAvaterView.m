//
//  ChangeAvaterView.m
//  WWeChat
//
//  Created by 王子轩 on 16/2/5.
//  Copyright © 2016年 wzx. All rights reserved.
//

#import "ChangeAvaterView.h"


#define  screenSize [UIScreen mainScreen].bounds.size

@interface ChangeAvaterView ()


@end


@implementation ChangeAvaterView

- (instancetype)initWithFrame:(CGRect)frame andBtnArr:(NSArray *)btnArr;
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [self addGestureRecognizer:tapView];
        
        [self createPopViewWithArr:btnArr];
    }
    return self;
}

- (void)createPopViewWithArr:(NSArray *)arr
{
    _thisTag=50000;
    UIView * popView = [[UIView alloc]initWithFrame:CGRectMake(0, screenSize.height, screenSize.width,200)];
    popView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:231/255.0 alpha:1];
    _popView = popView;
    
    [self addSubview:self.popView];
    
    for (int i = 0 ; i < arr.count; i++)
    {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, i * 50, self.frame.size.width, 48);
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = _thisTag + i;
        [_popView addSubview:btn];
    }
    
    //取消按钮
    UIButton * cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 150, self.frame.size.width, 48);
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor whiteColor];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    [_popView addSubview:cancelBtn];
}

- (void)show
{
    [UIView animateWithDuration:0.2 animations:^{
       
        self.popView.frame = CGRectMake(0, screenSize.height-200, screenSize.width, 200);
        
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.2 animations:^{
        
        _popView.frame = CGRectMake(0, screenSize.height, screenSize.width, 200);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
   
}


@end
