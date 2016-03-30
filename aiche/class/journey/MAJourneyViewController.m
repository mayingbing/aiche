//
//  MAJourneyViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/28.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAJourneyViewController.h"
#import "UIImage+Image.h"
#import "SYScrollerView.h"
#import "MAOneTableViewCell.h"
#import "MATwoTableViewCell.h"
#import "MAWeatherView.h"
#import "CityListViewController.h"
#import "MAQuNaErViewController.h"
#import "UINavigationBar+Awesome.h"
#import "MACellMapView.h"
#import <MAMapKit/MAMapKit.h>
#define NEW_THEMECOLOR    [UIColor colorWithRed:0xff/255.0f green:0xff/255.0f blue:0xff/255.0f alpha:1]


@interface MAJourneyViewController ()<UITableViewDataSource,UITableViewDelegate,SYScrollerViewDeledage,MACellMapViewDelegate,MAOneTableViewCellDelegate,MAMapViewDelegate>

@property(nonatomic,strong) MAOneTableViewCell *weatherCell;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MAJourneyViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar lt_setBackgroundColor:[NEW_THEMECOLOR colorWithAlphaComponent:0]];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar lt_setBackgroundColor:[NEW_THEMECOLOR colorWithAlphaComponent:1]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //屏幕不自动移动
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.tabBarItem.image = [UIImage imageNamed:@"tab1"];
    
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tab1_press"];
    self.tabBarItem.title = @"出行";
    UITableView *tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:tableView];

    _tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    //滚动广告
    [self setContentViews];
    

    
}
//滚动广告
-(void)setContentViews{
    
    NSArray *temp = @[[UIImage imageNamed:@"head1.jpg"],[UIImage imageNamed:@"head2.jpg"],[UIImage imageNamed:@"head3.jpg"],[UIImage imageNamed:@"head4.jpg"]];
    
    [SYScrollerView initWithSourceArray:temp
                              addTarget:self
                               delegate:self
                               withSize:CGRectMake(0, 0, self.view.frame.size.width, 134)
                       withTimeInterval:2.f];
    for (UIView *subView in self.view.subviews) {
        if ([subView isKindOfClass:[SYScrollerView class]]) {
            self.tableView.tableHeaderView = subView;
        }
    }
    
}
//点击滚动图片
-(void)SYScrollerView:(UIView *)bannerPlayer didSelectedIndex:(NSInteger)index{
    
    MAQuNaErViewController *quNaErVC = [[MAQuNaErViewController alloc]init];
    [self.navigationController pushViewController:quNaErVC animated:YES];
    
    
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
        weatherCell.delegate = self;
        
        _weatherCell = weatherCell;
        return weatherCell;
    }else{
        
        MATwoTableViewCell *cell = [MATwoTableViewCell creatCellWithTableView:(UITableView *)tableView];
        cell.mapView.delegate = self.weatherCell;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        return 50;
    }else{
        return [UIScreen mainScreen].bounds.size.height -134-50-49;
    }
    
}

-(void)jumpToVCWithCityListViewController:(CityListViewController *)cityListVC{
    [self.navigationController pushViewController:cityListVC animated:YES];
}
@end