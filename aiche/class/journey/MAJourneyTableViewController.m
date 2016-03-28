//
//  MAJourneyTableViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/27.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAJourneyTableViewController.h"
#import "UIImage+Image.h"
#import "SYScrollerView.h"
#import "MAOneTableViewCell.h"
#import "MATwoTableViewCell.h"
#import "MAWeatherView.h"
#import "CityListViewController.h"


@interface MAJourneyTableViewController ()<MAWeatherViewDelegate>

@property(nonatomic,strong) MAOneTableViewCell *weatherCell;

@end

@implementation MAJourneyTableViewController
-(void)viewDidAppear:(BOOL)animated

{
    [super viewDidAppear:animated];
//    // 高德地图
//    //配置用户Key
//    [MAMapServices sharedServices].apiKey = @"用户Key";
//    
//    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
//    _mapView.delegate = self;
    
//    [self.view addSubview:_mapView];
    //设置tableview的frame
    
    self.tableView.frame=CGRectMake(0, -64, self.tableView.frame.size.width, self.tableView.frame.size.height+64);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarItem.image = [UIImage imageNamed:@"tab1"];
    
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tab1_press"];
    self.tabBarItem.title = @"出行";
    
    //滚动广告
    [self setContentViews];

}
//滚动广告
-(void)setContentViews{
    
    NSArray *temp = @[[UIImage imageNamed:@"head1.jpg"],[UIImage imageNamed:@"head2.jpg"],[UIImage imageNamed:@"head3.jpg"],[UIImage imageNamed:@"head4.jpg"]];
    
    [SYScrollerView initWithSourceArray:temp
                              addTarget:self
                               delegate:self
                               withSize:CGRectMake(0, 0, self.view.frame.size.width, 114)
                       withTimeInterval:2.f];
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[SYScrollerView class]]) {
            self.tableView.tableHeaderView = subView;
        }
    }
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     if (indexPath.section==0) {
         
         MAOneTableViewCell *weatherCell = [MAOneTableViewCell creatCellWithTableView:(UITableView *)tableView];
         weatherCell.weatherView.delegate = self;
         _weatherCell = weatherCell;
         return weatherCell;
     }else{
         
          MATwoTableViewCell *cell = [MATwoTableViewCell creatCellWithTableView:(UITableView *)tableView];
         
         return cell;
     }
 }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        return 100;
    }else{
        return [UIScreen mainScreen].bounds.size.height -214-44;
    }
    
}

-(void)maWeatherViewAddCityWithWeatherView:(MAWeatherView *)weatherView{
    
    CityListViewController *cityListVC = [[CityListViewController alloc]init];
    cityListVC.delegate = (id<CityListVCDelegate>) self.weatherCell;
    [self.navigationController pushViewController:cityListVC animated:YES];
    
}


@end
