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
        
        [self setupMapModel];
    }
    return self;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    }
}

-(void)setupMapModel
{
    _mapView.showTraffic= YES;
//    _mapView.mapType = MAMapTypeSatellite;
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    [_mapView setZoomLevel:16.1 animated:YES];
    
    _mapView.pausesLocationUpdatesAutomatically = NO;
    
    _mapView.allowsBackgroundLocationUpdates = YES;
}

- (void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    MAAnnotationView *view = views[0];
    
    // 放到该方法中用以保证userlocation的annotationView已经添加到地图上了。
    if ([view.annotation isKindOfClass:[MAUserLocation class]])
    {
        MAUserLocationRepresentation *pre = [[MAUserLocationRepresentation alloc] init];
        pre.fillColor = [UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:0.3];
        pre.strokeColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.9 alpha:1.0];
        pre.image = [UIImage imageNamed:@"location.png"];
        pre.lineWidth = 3;
        pre.lineDashPattern = @[@6, @3];
        
        [self.mapView updateUserLocationRepresentation:pre];
        
        view.calloutOffset = CGPointMake(0, 0);
    } 
}

@end