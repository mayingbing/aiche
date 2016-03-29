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

#import "UINavigationBar+Awesome.h"

#define NEW_THEMECOLOR              [UIColor colorWithRed:0xff/255.0f green:0xff/255.0f blue:0xff/255.0f alpha:1]


@interface MAJourneyViewController ()<MAWeatherViewDelegate,UITableViewDataSource,UITableViewDelegate>

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
        return 50;
    }else{
        return [UIScreen mainScreen].bounds.size.height -134-50-49;
    }
    
}

-(void)maWeatherViewAddCityWithWeatherView:(MAWeatherView *)weatherView{
    
    CityListViewController *cityListVC = [[CityListViewController alloc]init];
    cityListVC.delegate = (id<CityListVCDelegate>) self.weatherCell;
    [self.navigationController pushViewController:cityListVC animated:YES];
    
}
@end
