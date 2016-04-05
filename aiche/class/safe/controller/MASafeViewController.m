//
//  MASafeViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/25.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MASafeViewController.h"
#import "UIImage+Image.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"

#import "MARepairViewController.h"
#import "MABuyViewController.h"
#import "MACameraViewController.h"
#import "MenuLabel.h"
#import "HyPopMenuView.h"
#import <POP.h>

#define Objs @[[MenuLabel CreatelabelIconName:@"tabbar_compose_idea" Title:@"紧急求救"],[MenuLabel CreatelabelIconName:@"tabbar_compose_lbs" Title:@"应急照明"],[MenuLabel CreatelabelIconName:@"tabbar_compose_camera" Title:@"录像取证"],[MenuLabel CreatelabelIconName:@"tabbar_compose_photo" Title:@"相册"],[MenuLabel CreatelabelIconName:@"tabbar_compose_review" Title:@"点评"],[MenuLabel CreatelabelIconName:@"tabbar_compose_more" Title:@"更多"],]

@interface MASafeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic ,strong)UIImageView *buyCarView;
@property(nonatomic ,strong)UIImageView *repairView;
@property(nonatomic ,strong)UIImageView *SOSCarView;
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSMutableArray *imgArr;
@property(nonatomic ,strong)MACameraViewController *cameraView;
@end

@implementation MASafeViewController

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    }
    
    return _tableView;
}

-(NSMutableArray *)imgArr{
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.cameraView) {
        MACameraViewController *cameraView = [[MACameraViewController alloc]init];
        cameraView.view.backgroundColor = [UIColor blackColor];
        _cameraView = cameraView;
    }
    
    
    self.tabBarItem.image = [UIImage imageNamed:@"tab2"];
    
    self.tabBarItem.selectedImage = [UIImage imageWithOriginalName:@"tab2_press"];
    
    self.title = @"平安";
    
    _imgArr = @[@"buycar",@"repair",@"sos",
                @"买车",@"保养",@"紧急处理"];
    
    [self.view addSubview:self.tableView];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.imageView.image = [UIImage imageNamed:self.imgArr[indexPath.section]];
    cell.textLabel.text = self.imgArr[indexPath.section+3];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        [self jumpToBuyView];
        
    }else if(indexPath.section == 1){
        [self jumpToRepairView];
    }else if(indexPath.section == 2){
        [self jumpToSosView];
    }else{
        return;
    }
    //注销cell单击事件
    cell.selected = NO;
}


-(void)jumpToBuyView{
    MABuyViewController *buyVC = [[MABuyViewController alloc]init];
    buyVC.view.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController pushViewController:buyVC animated:YES];
}
-(void)jumpToRepairView{
    MARepairViewController *repairVC = [[MARepairViewController alloc]init];
    repairVC.view.backgroundColor = [UIColor lightGrayColor];
    [self.navigationController pushViewController:repairVC animated:YES];
}
-(void)jumpToSosView{
    
    
    CGFloat x,y,w,h;
    x = CGRectGetWidth(self.view.bounds)/2 - 213/2;
    y = CGRectGetHeight([UIScreen mainScreen].bounds)/2 * 0.3f;
    w = 213;
    h = 57;
    //自定义的头部视图
    UIImageView *topView = [[ImageView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    topView.image = [UIImage imageNamed:@"compose_slogan"];
    topView.contentMode = UIViewContentModeScaleAspectFit;
    
    NSMutableDictionary *AudioDictionary = [NSMutableDictionary dictionary];
    
    //添加弹出菜单音效
    [AudioDictionary setObject:@"composer_open" forKey:kHyPopMenuViewOpenAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewOpenAudioTypeKey];
    //添加取消菜单音效
    [AudioDictionary setObject:@"composer_close" forKey:kHyPopMenuViewCloseAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewCloseAudioTypeKey];
    //添加选中按钮音效
    [AudioDictionary setObject:@"composer_select" forKey:kHyPopMenuViewSelectAudioNameKey];
    [AudioDictionary setObject:@"wav" forKey:kHyPopMenuViewSelectAudioTypeKey];
    
    [HyPopMenuView CreatingPopMenuObjectItmes:Objs TopView:topView /*nil*/OpenOrCloseAudioDictionary:AudioDictionary /*nil*/ SelectdCompletionBlock:^(MenuLabel *menuLabel, NSInteger index) {
        
        if (index == 2) {
           [self.navigationController pushViewController:self.cameraView animated:YES];
        }
        
        
        
        
    }];

    
    
}

@end
