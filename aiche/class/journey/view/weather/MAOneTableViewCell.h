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

@protocol MAOneTableViewCellDelegate <NSObject>

@optional

-(void)jumpToVCWithCityListViewController:(CityListViewController *)cityListVC;

@end

@interface MAOneTableViewCell : UITableViewCell

@property(nonatomic ,strong)MAWeatherView *weatherView;
@property(nonatomic ,weak)id<MAOneTableViewCellDelegate> delegate;

+(instancetype)creatCellWithTableView:(UITableView *)tableView;

@end
