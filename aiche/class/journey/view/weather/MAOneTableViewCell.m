//
//  MAOneTableViewCell.m
//  爱车
//
//  Created by mayingbing on 16/3/27.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAOneTableViewCell.h"
#import <AFNetworking.h>
#import "MAWeatherView.h"
#import "MADataModel.h"
#import "MJExtension.h"
#import "CityListViewController.h"
#import "MACellMapView.h"


@interface MAOneTableViewCell ()<CityListVCDelegate,MACellMapViewDelegate>

@property(nonatomic ,strong)UILabel *resultText;
@property(nonatomic ,copy)NSString *urlStr;

@end

@implementation MAOneTableViewCell

static NSString *oneID = @"oneCell";

+(instancetype)creatCellWithTableView:(UITableView *)tableView{

    id cell = [tableView dequeueReusableCellWithIdentifier:oneID];
    
    if (cell == nil) {
        
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:oneID];

    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor grayColor];
        self.clipsToBounds = YES;
        
        [self setUpChildView];
    }
    return self;
}

-(void)setUpChildView{
    
    MAWeatherView *weatherView = [[MAWeatherView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 50)];
    _weatherView = weatherView;
    weatherView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:weatherView];
    
    //查看更多城市
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.weatherView addSubview:addBtn];
    addBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30, 5, 30, 40);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"hou"] forState:UIControlStateNormal];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"hou_press"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(jumpToCityList) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSString *urlStr = @"http://apis.baidu.com/apistore/weatherservice/weather?citypinyin=beijing";
    _urlStr = urlStr;
    
    [self doRequestWeatherData];
    
}
//
-(void)jumpToCityList{
    
        CityListViewController *cityListVC = [[CityListViewController alloc]init];
        cityListVC.delegate =  self;
    
    if ([self.delegate respondsToSelector:@selector(jumpToVCWithCityListViewController:)]) {
        [self.delegate jumpToVCWithCityListViewController:cityListVC];
    }

}

-(void)doRequestWeatherData{
    
    
     NSString *apikey = @"96c51e31f222b3b154a9ce707c9a32ea";
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];

    [session GET:_urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        NSDictionary *retDataContent = [content objectForKey:@"retData"];
         MADataModel *obj = [MADataModel mj_objectWithKeyValues:retDataContent];
        
       
        self.weatherView.weatherData = obj;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];


}
-(void)MACellMapViewWithLocationData:(NSString *)cityName{
    
    [self CityListVCGetNewCityweatherWithCityName:cityName];
    
}
    
-(void)CityListVCGetNewCityweatherWithCityName:(NSString *)cityName{
     NSString *baseStr = @"http://apis.baidu.com/apistore/weatherservice/weather?citypinyin=";
    NSString *hanziText = cityName;
    NSMutableString *ms ;
    if ([hanziText length]) {
        ms = [[NSMutableString alloc] initWithString:hanziText];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
           
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            
        }  
    }
    self.urlStr = [NSString stringWithFormat:@"%@%@",baseStr,ms];
    self.urlStr = [self.urlStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.urlStr = [self.urlStr stringByReplacingOccurrencesOfString:@"shi" withString:@""];
    [self doRequestWeatherData];
}




@end
