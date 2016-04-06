//
//  MAHomeTableViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAHomeTableViewController.h"
#import "MAHomeSelfCell.h"
#import "UIImage+Image.h"
#import "MAHeadTableViewController.h"
#import "MAOtherViewController.h"

#define screenSize [UIScreen mainScreen].bounds.size

#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"judge.data"]

#define CZImageFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"image.data"]

@interface MAHomeTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) MAHomeSelfCell *homeSelfCell;

@end

@implementation MAHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"到家";
    self.tableView.dataSource = self;
    self.tabBarItem.image = [UIImage imageNamed:@"tab3"];
    
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tab3_press"];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:CZAccountFileName]) {
        
        self.homeSelfCell.nameLable.text = [NSKeyedUnarchiver unarchiveObjectWithFile:CZAccountFileName];
        
        self.homeSelfCell.iconView.image = [NSKeyedUnarchiver unarchiveObjectWithFile:CZImageFileName];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section ==0) {
        return 100;
    }else{
        return 40;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section == 0) {
//        return 1;
//    }else if (section == 1){
//        return 4;
//    }else{
        return 1;
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        
        MAHomeSelfCell *homeSelfCell = [MAHomeSelfCell creatCellWithTableView:(UITableView *)tableView];
        _homeSelfCell = homeSelfCell;
        return homeSelfCell;
    }else{
        
//         NSArray *imgArr = @[@"MoreMyAlbum",@"MoreMyFavorites",@"MoreMyBankCard",@"MyCardPackageIcon",@"相册",@"收藏",@"钱包",@"优惠券"];
        
        static NSString *defaultCell = @"defaultCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:defaultCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:defaultCell];
        }
//        if (indexPath.section == 1) {
//            cell.imageView.image = [UIImage imageNamed:imgArr[indexPath.row]];
//            cell.textLabel.text = imgArr[indexPath.row+4];
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }else if (indexPath.section == 2){
//            cell.imageView.image = [UIImage imageNamed:@"MoreExpressionShops"];
//            cell.textLabel.text = @"表情";
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }else{
            cell.imageView.image = [UIImage imageNamed:@"MoreSetting"];
            cell.textLabel.text = @"设置";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        MAHeadTableViewController *headVC = [[MAHeadTableViewController alloc]init];
        [self.navigationController pushViewController:headVC animated:YES];
        
    }else{
        MAOtherViewController *otherVC = [[MAOtherViewController alloc]init];
        [self.navigationController pushViewController:otherVC animated:YES];
        
    }
   cell.selected = NO; 
}

@end
