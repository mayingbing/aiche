//
//  MAWeatherView.h
//  爱车
//
//  Created by mayingbing on 16/3/27.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MADataModel;
@class MAWeatherView;

@protocol MAWeatherViewDelegate <NSObject>

@optional

-(void)maWeatherViewAddCityWithWeatherView:(MAWeatherView *)weatherView;


@end

@interface MAWeatherView : UIView

@property(nonatomic ,strong)MADataModel *weatherData;

@property(nonatomic ,weak)id<MAWeatherViewDelegate> delegate;

@end
