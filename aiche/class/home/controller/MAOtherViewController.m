//
//  MAOtherViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAOtherViewController.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
//按比例获取高度
#define  WGiveHeight(HEIGHT) HEIGHT * [UIScreen mainScreen].bounds.size.height/568.0

//按比例获取宽度
#define  WGiveWidth(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/320.0

#define IWStatusFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"status.sqlite"]

@interface MAOtherViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)NSArray * dataArr;
@property(nonatomic,assign)CGFloat fileSize;
@property(nonatomic,strong)UILabel * backLabel;

@end

@implementation MAOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArr = @[@[@"清空缓存"],
//                 @[@"新消息通知",@"隐私",@"通用"],
//                 @[@"帮助与反馈",@"关于微信"],
//                 @[@"退出登录"]
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
//    if (indexPath.section == _dataArr.count -1)
//    {
//        UILabel * backLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height)];
//        backLabel.text = _dataArr[indexPath.section][indexPath.row];
//        backLabel.font = [UIFont systemFontOfSize:17];
//        backLabel.textAlignment = NSTextAlignmentCenter;
//        [cell.contentView addSubview:backLabel];
//    }
//    else
//    {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    CGFloat fileSize = 0;
    if([fileManager fileExistsAtPath:IWStatusFile]){
        long long size=[fileManager attributesOfItemAtPath:IWStatusFile error:nil].fileSize;
        fileSize = size/1024.0/1024.0;
        _fileSize = fileSize;
    }

    cell.textLabel.text = _dataArr[indexPath.section][indexPath.row];
    
    if (self.backLabel==nil) {
        UILabel * backLabel = [[UILabel alloc]initWithFrame:CGRectMake(cell.contentView.frame.size.width-80, (cell.contentView.frame.size.height-13)/2, 60, 15)];
        _backLabel = backLabel;
    }
    
    _backLabel.text = @"";
    _backLabel.text = [NSString stringWithFormat:@"%.3gM",self.fileSize];
    _backLabel.font = [UIFont systemFontOfSize:13];
  
    [cell.contentView addSubview:_backLabel];
    //右侧小箭头
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//    }
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
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section==0) {
        
        [self clearCache];
        
        cell.selected = NO;
    }
}
-(void)clearCache{
   
//    CGFloat fileSize = 0;
//    if([fileManager fileExistsAtPath:IWStatusFile]){
//        long long size=[fileManager attributesOfItemAtPath:IWStatusFile error:nil].fileSize;
//        fileSize = size/1024.0;
//        _fileSize = fileSize;
//    }
    
//    if ([fileManager fileExistsAtPath:IWStatusFile]) {
//        NSArray *childerFiles=[fileManager subpathsAtPath:IWStatusFile];
//        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
//            if ([fileName containsString:@"account.data"]) {
//                continue;
//            }
//            NSString *absolutePath=[IWStatusFile stringByAppendingPathComponent:fileName];
//            [fileManager removeItemAtPath:absolutePath error:nil];
//        }
//    }
    [[SDImageCache sharedImageCache] cleanDisk];

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"本次清理垃圾" message:[NSString stringWithFormat:@"%gM",self.fileSize] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
         NSFileManager *fileManager=[NSFileManager defaultManager];
//        if ([fileManager fileExistsAtPath:IWStatusFile]) {
//            NSArray *childerFiles=[fileManager subpathsAtPath:IWStatusFile];
//            for (NSString *fileName in childerFiles) {
//
//                NSString *absolutePath=[IWStatusFile stringByAppendingPathComponent:fileName];
                [fileManager removeItemAtPath:IWStatusFile error:nil];
//            }
//        }

        [self.tableView reloadData];
        
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];

    
    

}

@end
