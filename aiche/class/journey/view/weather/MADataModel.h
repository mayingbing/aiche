//
//  MADataModel.h
//  爱车
//
//  Created by mayingbing on 16/3/27.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MADataModel : NSObject

//城市
@property (nonatomic ,copy)NSString *city;
//时间
@property (nonatomic ,assign)NSString *date;
@property (nonatomic ,assign)NSString *time;
 //海拔
@property (nonatomic ,assign)NSString *altitude;
//天气情况
@property (nonatomic ,copy)NSString *weather;
//最低气温
@property (nonatomic ,assign)NSString *l_tmp;
//最高气温
@property (nonatomic ,assign)NSString *h_tmp;
//风向
@property (nonatomic ,copy)NSString *WD;
//风力
@property (nonatomic ,assign)NSString *WS;
//日出时间
@property (nonatomic ,copy)NSString *sunrise;
//日落时间
@property (nonatomic ,copy)NSString *sunset;



@end
