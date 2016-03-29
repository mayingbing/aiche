//
//  MAWeatherView.m
//  爱车
//
//  Created by mayingbing on 16/3/27.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAWeatherView.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "MADataModel.h"

@interface MAWeatherView ()

@property(nonatomic ,strong)UILabel *cityNameLable;
@property(nonatomic ,strong)UILabel *weatherLable;
@property(nonatomic ,strong)UILabel *tmpLable;
@property(nonatomic ,strong)UILabel *WDLable;
@property(nonatomic ,strong)UILabel *WSLable;
@property(nonatomic ,strong)UILabel *dateLable;
@end

@implementation MAWeatherView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        [self setupWeatherView];
    }

    return self;
}

-(void)setupWeatherView{
    
    UIImageView *imgview = [[UIImageView alloc]initWithFrame:self.bounds];
    imgview.image = [UIImage imageNamed:@"cellBackground.jpg"];
    [self addSubview:imgview];
    
    //城市
    UILabel *cityNameLable = [[UILabel alloc]init];
    [self addSubview:cityNameLable];
    cityNameLable.font = [UIFont systemFontOfSize:15];
    _cityNameLable = cityNameLable;
    //时间
    UILabel *dateLable = [[UILabel alloc]init];
    [self addSubview:dateLable];
    dateLable.font = [UIFont systemFontOfSize:15];
    _dateLable = dateLable;
    //天气情况
    UILabel *weatherLable = [[UILabel alloc]init];
    [self addSubview:weatherLable];
    weatherLable.font = [UIFont systemFontOfSize:15];
    _weatherLable = weatherLable;
    //气温
    UILabel *tmpLable = [[UILabel alloc]init];
    [self addSubview:tmpLable];
    tmpLable.font = [UIFont systemFontOfSize:15];
    _tmpLable = tmpLable;
    //风向
    UILabel *WDLable = [[UILabel alloc]init];
    [self addSubview:WDLable];
    WDLable.font = [UIFont systemFontOfSize:15];
    _WDLable = WDLable;
    //风力
    UILabel *WSLable = [[UILabel alloc]init];
    [self addSubview:WSLable];
    WSLable.font = [UIFont systemFontOfSize:15];
    _WSLable = WSLable;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:addBtn];
    addBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-30, 5, 30, 40);
    [addBtn setBackgroundImage:[UIImage imageNamed:@"hou"] forState:UIControlStateNormal];
    [addBtn setBackgroundImage:[UIImage imageNamed:@"hou_press"] forState:UIControlStateHighlighted];
    [addBtn addTarget:self action:@selector(jumpToCityList) forControlEvents:UIControlEventTouchUpInside];
}

-(void)jumpToCityList{
    
    if ([self.delegate respondsToSelector:@selector(maWeatherViewAddCityWithWeatherView:)]) {
        
        [self.delegate maWeatherViewAddCityWithWeatherView:self];
        
    }
    
}

-(void)setWeatherData:(MADataModel *)weatherData{
    
    _weatherData = weatherData;
    
    
    @weakify(self)
    //城市
    self.cityNameLable.text = weatherData.city;
    [self.cityNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.height.equalTo(@15);
    }];
    
    //时间
    self.dateLable.text = [NSString stringWithFormat:@"20%@",weatherData.date];
    [self.dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.cityNameLable.mas_right).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.height.equalTo(@15);
    }];
    
    //天气情况
    self.weatherLable.text = weatherData.weather;
    [self.weatherLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.dateLable.mas_right).with.offset(20);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.height.equalTo(@15);
    }];
    
    //气温
    self.tmpLable.text = [NSString stringWithFormat:@"%@℃~%@℃",weatherData.l_tmp,weatherData.h_tmp];
    [self.tmpLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).with.offset(20);
        make.top.equalTo(self.cityNameLable.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
    }];
    
   
    
    //风向
    self.WDLable.text = weatherData.WD;
    [self.WDLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.tmpLable.mas_right).with.offset(20);
        make.top.equalTo(self.cityNameLable.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
    }];
    
     //风力
    self.WSLable.text = weatherData.WS;
    [self.WSLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.WDLable.mas_right).with.offset(10);
        make.top.equalTo(self.cityNameLable.mas_bottom).with.offset(10);
        make.height.equalTo(@15);
    }];
    
    
    
}

@end
