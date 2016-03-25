//
//  DGEarthView.m
//  animaByIdage
//
//  Created by chuangye on 15-3-11.
//  Copyright (c) 2015年 chuangye. All rights reserved.
//

#import "DGEarthView.h"

@implementation DGEarthView

{
    double angleEarth;
    double angle;
    UIImageView *imageView;
    UIImageView *imageViewEarth;
    NSMutableArray *imageArray;
    NSInteger value;
    NSInteger num;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        value=1;
        num = 1;
        self.backgroundColor=[UIColor clearColor];
        imageArray = [[NSMutableArray alloc]init];
        CGSize screenSize = [UIScreen mainScreen].bounds.size ;
        
        CGFloat earthY = (screenSize.height -screenSize.width)-20;
        
        imageViewEarth = [[UIImageView alloc]initWithFrame:CGRectMake(0, earthY, screenSize.width, screenSize.width)];
        imageViewEarth.image=[UIImage imageNamed:@"earth@3x"];
        
        [self addSubview:imageViewEarth];
        
        
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, earthY, 30, 60)];
        imageView.center = imageViewEarth.center;
        [self addSubview:imageView];
        imageView.image=[UIImage imageNamed:@"fire2@3X(1)"];
        
        [self startAnimation];
        [self startAnimationEarth];
        
    }
    return self;
}


-(void) startAnimation
{
    NSString *imageName;
    if (value>=3) {
        
        value=1;
    }
    imageName = [NSString stringWithFormat:@"fire%ld@3X(1)",value];
    
    imageView.image = [UIImage imageNamed:imageName];
    value++;
    num++;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    
    imageView.transform = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    
    CGFloat sss= [UIScreen mainScreen].bounds.size.width/55;
    
    imageView.layer.anchorPoint=CGPointMake(sss-num*0.02, 0.5);
    [UIView commitAnimations];
    
    
    
}
-(void)endAnimation
{
    CGFloat huojiansepped=1.0;
    angle += 5*huojiansepped;
    [self startAnimation];
    
    //换图片
    
    
}

-(void) startAnimationEarth
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimationEarth)];
    imageViewEarth.transform = CGAffineTransformMakeRotation(angleEarth * (M_PI / -180.0f));
    // imageViewEarth.layer.anchorPoint=CGPointMake(2.2, 2.2);
    [UIView commitAnimations];
}
-(void)endAnimationEarth
{
    CGFloat EarthSepped=1.0;
    angleEarth += 5*EarthSepped;
    [self startAnimationEarth];
}



@end
