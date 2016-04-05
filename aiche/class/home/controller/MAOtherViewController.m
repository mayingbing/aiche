//
//  MAOtherViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAOtherViewController.h"
#import "MBProgressHUD.h"
//按比例获取高度
#define  WGiveHeight(HEIGHT) HEIGHT * [UIScreen mainScreen].bounds.size.height/568.0

//按比例获取宽度
#define  WGiveWidth(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/320.0

@interface MAOtherViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSArray * dataArr;
@end

@implementation MAOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = @[@[@"帐号与安全"],
                 @[@"新消息通知",@"隐私",@"通用"],
                 @[@"帮助与反馈",@"关于微信"],
                 @[@"退出登录"]
                 ];
    
    [self.tableView reloadData];
}

//组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}

//每组个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * rowArr = _dataArr[section];
    return rowArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"settingCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

//养成习惯在WillDisplayCell中处理数据
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == _dataArr.count -1)
    {
        UILabel * backLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
        backLabel.text = _dataArr[indexPath.section][indexPath.row];
        backLabel.font = [UIFont systemFontOfSize:17];
        backLabel.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:backLabel];
    }
    else
    {
        cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
        //右侧小箭头
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
}

//设置row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return WGiveHeight(43);
}

//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return WGiveHeight(15);
    }
    return WGiveHeight(10);
}

//设置脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return WGiveHeight(10);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == _dataArr.count -1)
    {
       // MBProgressHUD * hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    }
}

@end
