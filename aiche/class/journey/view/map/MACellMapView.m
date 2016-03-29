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


@interface MACellMapView ()<MAMapViewDelegate,AMapSearchDelegate,UISearchBarDelegate>

@property(nonatomic ,strong) MAMapView *mapView;
@property(nonatomic ,strong) AMapSearchAPI *search;
@property(nonatomic ,strong) MAUserLocation *userLocation;
@property(nonatomic ,copy) NSString *searchContent;

@end

@implementation MACellMapView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
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
        //取出当前位置的坐标
        //  NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
        //构造AMapReGeocodeSearchRequest对象
        AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
        regeo.location = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude     longitude:userLocation.coordinate.longitude];
        regeo.radius = 10000;
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
        NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode.addressComponent.city];
        if (!result) {
            result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode.addressComponent.province];
            
        }
        
        if ([self.delegate respondsToSelector:@selector(MACellMapViewWithLocationData:)]) {
            [self.delegate MACellMapViewWithLocationData:result];
        }
    }
}



-(void)setupMapModel
{   //交通路况
    _mapView.showTraffic= YES;
    
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
    
    //通过AMapNavigationSearchResponse对象处理搜索结果
   // NSString *route = [NSString stringWithFormat:@"Navi: %@", response.route];
   // NSLog(@"%@", route);
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