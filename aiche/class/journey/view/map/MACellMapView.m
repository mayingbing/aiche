//
//  MACellMapView.m
//  爱车
//
//  Created by mayingbing on 16/3/28.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MACellMapView.h"
#import <MAMapKit/MAMapKit.h>
//#import <AMap2DMap/MAMapKit/MAMapView.h>

@interface MACellMapView ()<MAMapViewDelegate>

@property(nonatomic ,strong) MAMapView *mapView;


@end

@implementation MACellMapView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        //配置用户Key
        [MAMapServices sharedServices].apiKey = @"890210ecad379c78557ad10845ea319e";
        
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        _mapView.delegate = self;

        
        [self addSubview:_mapView];
        
        
    }
    return self;
}

@end