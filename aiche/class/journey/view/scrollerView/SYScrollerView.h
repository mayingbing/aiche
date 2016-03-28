//
//  SYScrollerView.h
//  108tian.001
//
//  Created by 马颖兵 on 15/10/19.
//  Copyright (c) 2015年 108tian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJBannnerPlayerDeledage <NSObject>

-(void)SYScrollerView:(UIView *)bannerPlayer didSelectedIndex:(NSInteger)index;

@end

@interface SYScrollerView : UIView

@property (nonatomic) CGFloat timeInterval;
@property (strong, nonatomic) NSArray *sourceArray;
@property (strong, nonatomic) NSArray *urlArray;
@property (strong, nonatomic) id<MJBannnerPlayerDeledage> delegate;

//初始化一个本地图片播放器
+ (void)initWithSourceArray:(NSArray *)picArray
                  addTarget:(id)controller
                   delegate:(id)delegate
                   withSize:(CGRect)frame
           withTimeInterval:(CGFloat)interval;


//初始化一个网络图片播放器
+ (void)initWithUrlArray:(NSArray *)urlArray
               addTarget:(UIViewController *)controller
                delegate:(id)delegate
                withSize:(CGRect)frame
        withTimeInterval:(CGFloat)interval;

//设置图片
-(void)setImage:(NSArray *)sourceList;

@end