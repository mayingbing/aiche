//
//  MAHeadTableViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAHeadTableViewController.h"
#import "UIImageView+WebCache.h"
#import "MAHomeCameraViewController.h"
#import "MAHomeWEBViewController.h"

//按比例获取高度
#define  WGiveHeight(HEIGHT) HEIGHT * [UIScreen mainScreen].bounds.size.height/568.0

//按比例获取宽度
#define  WGiveWidth(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/320.0


@interface MAHeadTableViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)NSArray * titleArr;
@property(nonatomic ,strong)NSString *webString;

@end

@implementation MAHeadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _titleArr = @[
                  @[
                      @"头像",
                      @"名字",
                      @"微信号",
                      @"我的二维码",
                      @"我的地址"
                      ]
                  ,
                  @[
                      @"性别",
                      @"地区",
                      @"个性签名"
                      ]
                  
                  ];

    
}
#pragma mark -- tableView --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = _titleArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"PersonCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    if (indexPath.section == 0 && indexPath.row == 2)
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(220), (cell.frame.size.height - WGiveHeight(64))/2.0, WGiveHeight(64), WGiveHeight(64))];
        
        imageView.image = [UIImage imageNamed:@"WWeChat"];
       
        
        imageView.layer.cornerRadius = 5;
        imageView.clipsToBounds = YES;
        
        [cell.contentView addSubview:imageView];
    }
    else if(indexPath.section == 0 && indexPath.row == 3)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(270), (cell.frame.size.height - WGiveHeight(18))/2.0, WGiveHeight(18), WGiveHeight(18))];
        
        imageView.image = [UIImage imageNamed:@"setting_myQR"];
        
        [cell.contentView addSubview:imageView];
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        UILabel * signLabel = [[UILabel alloc]initWithFrame:CGRectMake(WGiveWidth(148), 0, WGiveWidth(145), cell.frame.size.height)];
        signLabel.text = @"佛教中有一句话：初学者的心态；拥有初学者的心态是件了不起的事情。";
        signLabel.textAlignment = NSTextAlignmentRight;
        signLabel.textColor = [UIColor grayColor];
        signLabel.numberOfLines = 0;
        [cell.contentView addSubview:signLabel];
    }
    else
    {
        NSLog(@"font%@  color%@",cell.textLabel.font,cell.textLabel.textColor);
        cell.detailTextLabel.text = @" ";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return WGiveHeight(80);
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
        return 100;
    }
    else
    {
        return WGiveHeight(44);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return WGiveHeight(15);
    }
    else
    {
        return WGiveHeight(20);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //修改头像
        if (indexPath.row == 0)
        {
           
        }
        //修改用户名
        else if(indexPath.row == 1)
        {
            
        }
        //微信号（不能修改）
        else if(indexPath.row == 2)
        {
            
        }
        //二维码
        else if(indexPath.row == 3)
        {
        MAHomeCameraViewController *scanCodeViewController = [[MAHomeCameraViewController alloc]init];
            scanCodeViewController.sucessScanBlock = ^(NSString *result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _webString = result;
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"二维码扫描结果" message:result preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        [self loadWebViewWith:(NSString *)result];
                        
                    }];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                });
            };
            [self.navigationController pushViewController:scanCodeViewController animated:YES];

        }
        //地址
        else if(indexPath.row == 4)
        {
           
        }
    }
    else
    {
        //性别
        if (indexPath.row == 0)
        {
            
        }
        //地区
        else if(indexPath.row == 1)
        {
            
        }
        //个性签名
        else if(indexPath.row == 2)
        {
            
        }
    }
}

- (CGFloat)giveMeHeightWithStr:(NSString *)str
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(WGiveWidth(145), MAXFLOAT)
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize.height;
}

-(void)loadWebViewWith:(NSString *)result{
    
    MAHomeWEBViewController *webVc = [MAHomeWEBViewController initWebWithNSString:result];
    [self.navigationController pushViewController:webVc animated:YES];
    
}

@end
