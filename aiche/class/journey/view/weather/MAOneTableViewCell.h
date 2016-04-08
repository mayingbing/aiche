//
//  MAOneTableViewCell.h
//  爱车
//
//  Created by mayingbing on 16/3/27.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAWeatherView;
@class CityListViewController;


@interface MAOneTableViewCell : UITableViewCell

@property(nonatomic ,strong) CityListViewController *cityListVC;
@property(nonatomic ,strong)MAWeatherView *weatherView;

-(void)CityListVCGetNewCityweatherWithCityName:(NSString *)cityName;
+(instancetype)creatCellWithTableView:(UITableView *)tableView;

@end


