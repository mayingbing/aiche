//
//  MACellMapView.m
//  爱车
//
//  Created by mayingbing on 16/3/28.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MACellMapView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapCommonObj.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MANaviRoute.h"
#import "CommonUtility.h"

const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
const NSInteger RoutePlanningPaddingEdge                    = 50;

@interface MACellMapView ()<MAMapViewDelegate,AMapSearchDelegate,UISearchBarDelegate>

@property(nonatomic ,strong) MAMapView *mapView;
@property(nonatomic ,strong) AMapSearchAPI *search;
@property(nonatomic ,strong) MAUserLocation *userLocation;
@property(nonatomic ,copy) NSString *searchContent;
@property(nonatomic ,strong) NSTimer *timer;
@property(nonatomic ,assign) BOOL openTime;
/* 用于显示当前路线方案. */
@property (nonatomic)MANaviRoute *naviRoute;

/* 路径规划类型 */

@property (nonatomic, strong) AMapRoute *route;

@end

@implementation MACellMapView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.openTime = NO;
        //配置用户Key
        [MAMapServices sharedServices].apiKey = @"890210ecad379c78557ad10845ea319e";
        [AMapSearchServices sharedServices].apiKey = @"890210ecad379c78557ad10845ea319e";
        
        //创建地图层
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        _mapView.delegate = self;
       
        //创建search
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;

        
        [self addSubview:_mapView];
        
        [self setupMapModel];
        
    }
    return self;
}


-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    _userLocation = userLocation;
    if(updatingLocation)
    {
        
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude     longitude:userLocation.coordinate.longitude];
        regeo.radius = 100;
        regeo.requireExtension = YES;
        
        //发起逆地理编码
        [_search AMapReGoecodeSearch: regeo];
    }
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
        NSString *result = [NSString stringWithFormat:@"%@", response.regeocode.addressComponent.city];
        if ([result isEqual:@""]) {
            result = [NSString stringWithFormat:@"%@", response.regeocode.addressComponent.province];
            
        }
        
        if ([self.delegate respondsToSelector:@selector(MACellMapViewWithLocationData:)]) {
            [self.delegate MACellMapViewWithLocationData:result];
        }
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    //关闭定时器
    [self.timer setFireDate:[NSDate distantFuture]];
}

-(void)setupMapModel
{   //交通路况
    //_mapView.showTraffic= YES;
    
    //位置展示
    _mapView.showsUserLocation = YES;
    
    _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
    
    [_mapView setZoomLevel:16.1 animated:YES];
    
    _mapView.pausesLocationUpdatesAutomatically = NO;
    
    _mapView.allowsBackgroundLocationUpdates = YES;
    
    // 创建搜索框

    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(3, 30, [UIScreen mainScreen].bounds.size.width/2, 35)];
    searchBar.placeholder = @"目的地";
    searchBar.delegate = self;
    [self.mapView addSubview:searchBar];

}

/* 清空地图上已有的路线. */
- (void)clear
{
    [self.naviRoute removeFromMapView];
    [self setNeedsLayout];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;{
    [self clear];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
        _searchContent = searchBar.text;
        //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
        AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
        geo.address = searchBar.text;
    
        //发起正向地理编码
        [_search AMapGeocodeSearch: geo];
    searchBar.text = @"";
    
    [searchBar resignFirstResponder];
    
}
//实现正向地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    if(response.geocodes.count == 0)
    {
        return;
    }
    
    //通过AMapGeocodeSearchResponse对象处理搜索结果
   // NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
    NSString *strGeocodes = @"";
    for (AMapTip *p in response.geocodes) {
        strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: %@", strGeocodes, p.description];
         [self searchMapWithData:(AMapTip *)p];
    }
    //NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes];

}
-(void)searchMapWithData:(AMapTip *)p{
    
    //驾车路径规划
    AMapDrivingRouteSearchRequest *request = [[AMapDrivingRouteSearchRequest alloc] init];
    request.origin = [AMapGeoPoint locationWithLatitude:_userLocation.coordinate.latitude longitude:_userLocation.coordinate.longitude];
    request.destination = p.location;
    request.strategy = 2;//距离优先
    request.requireExtension = YES;
    //发起路径搜索
    [_search AMapDrivingRouteSearch: request];
    
}

//实现路径搜索的回调函数
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if(response.route == nil)
    {
        return;
    }
    
//    通过AMapNavigationSearchResponse对象处理搜索结果
    self.route = response.route;

    
    [self presentCurrentCourse];
}
/* 展示当前路线方案. */
- (void)presentCurrentCourse
{

        
       MANaviRoute *naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[0] withNaviType:MANaviAnnotationTypeDrive];
   
    
    [naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
}

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        
        polylineRenderer.lineWidth   = 3;
        polylineRenderer.strokeColor = [UIColor blueColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 4;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }
        else
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    
    return nil;
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
        
        MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                             reuseIdentifier:routePlanningCellIdentifier];
        }
        
        poiAnnotationView.canShowCallout = YES;
        
        if ([annotation isKindOfClass:[MANaviAnnotation class]])
        {
            switch (((MANaviAnnotation*)annotation).type)
            {
                case MANaviAnnotationTypeBus:
                    poiAnnotationView.image = [UIImage imageNamed:@"bus"];
                    break;
                    
                case MANaviAnnotationTypeDrive:
                    poiAnnotationView.image = [UIImage imageNamed:@"car"];
                    break;
                    
                case MANaviAnnotationTypeWalking:
                    poiAnnotationView.image = [UIImage imageNamed:@"man"];
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            /* 起点. */
            if ([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerStartTitle])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"startPoint"];
            }
            /* 终点. */
            else if([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerDestinationTitle])
            {
                poiAnnotationView.image = [UIImage imageNamed:@"endPoint"];
            }
            
        }
        
        return poiAnnotationView;
    }
    
    return nil;
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