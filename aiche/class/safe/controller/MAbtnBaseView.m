//
//  MAbtnBaseView.m
//  爱车
//
//  Created by mayingbing on 16/4/1.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAbtnBaseView.h"
#define screenSize [UIScreen mainScreen].bounds.size
@implementation MAbtnBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupChildViews];
    }
    
    return self;
}

-(void)setupChildViews{
    
    
    UIImageView *btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake((screenSize.width/3-70)/2, 0, 70, 70)];
    [self addSubview:btnImageView];
    _btnImageView = btnImageView;
   
    UILabel *btnLable = [[UILabel alloc]initWithFrame:CGRectMake((screenSize.width/3-70)/2, 72, 70, 23)];
    [self addSubview:btnLable];
    btnLable.textColor = [UIColor orangeColor];
    btnLable.font = [UIFont systemFontOfSize:15];
    _btnLable = btnLable;
    btnLable.textAlignment = NSTextAlignmentCenter ;
    
    
    
}

@end
