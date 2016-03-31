//
//  MAQuNaErViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/29.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAQuNaErViewController.h"
#import <AFNetworking.h>
#import "MATicketModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MATicketTableViewCell.h"
#import "MAWEBViewController.h"
#import "MBProgressHUD.h"

@interface MAQuNaErViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong) UITableView *tableView;
@property(nonatomic ,strong) NSMutableArray *ticketArr;
@property(nonatomic ,strong) NSMutableArray *ticket_listContentArr;

@end

@implementation MAQuNaErViewController

-(NSMutableArray *)ticket_listContent{
    if (_ticket_listContentArr == nil) {
        _ticket_listContentArr = [NSMutableArray array];
    }
    
    return _ticket_listContentArr;
}

-(NSMutableArray *)ticketArr{
    if (_ticketArr == nil) {
        _ticketArr = [NSMutableArray array];
    }
    
    return _ticketArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
    //屏幕不自动移动
    //self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"自驾由我";
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:tableView];
    
    _tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    
    //获取景点
    [self getSpotName];
    
    //刷新页面
    [self MJRefreshRun];
    
}

-(void)MJRefreshRun{
    
    //下拉刷新
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.ticketArr) {
                [tableView reloadData];
            }
            
           [tableView.mj_header endRefreshing];
        });
    }];
    
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    //上拉刷新
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [tableView reloadData];
            [tableView.mj_footer endRefreshing];
        });
    }];
    footer.hidden = YES;
    tableView.mj_footer = footer;
    
}

//获取多个景点名称
-(void)getSpotName{
    
    NSString *httpUrl = @"http://apis.baidu.com/apistore/qunaerticket/querylist?pageno=1&pagesize=50";
   
    NSString *apikey = @"96c51e31f222b3b154a9ce707c9a32ea";
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
    
    [session GET:httpUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        _ticket_listContentArr = [[content objectForKey:@"retData"] objectForKey:@"ticketList"];
        
        // 获取数据
        if (self.ticket_listContentArr==nil) {
            NSString *numStr = @"1361653183";
            [self getQuNaErDataWithNumStr:numStr];
        }else{
            for (NSMutableDictionary *ticket in self.ticket_listContentArr) {
                NSString *numStr = [ticket objectForKey:@"productId"];
                if (numStr) {
                    [self getQuNaErDataWithNumStr:numStr];
                }
            }
            [self.tableView.mj_header beginRefreshing];

        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
//获取景点详情
-(void)getQuNaErDataWithNumStr:(NSString *)numStr{
    
    NSString *httpUrl = @"http://apis.baidu.com/apistore/qunaerticket/querydetail";
    NSString *pre = @"id=";
   
    
    NSString *httpArg = [NSString stringWithFormat:@"%@%@",pre,numStr];
    
    NSString *urlStr = [NSString stringWithFormat: @"%@?%@", httpUrl, httpArg];
    
    
    NSString *apikey = @"96c51e31f222b3b154a9ce707c9a32ea";
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    [session.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
    
    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableDictionary *ticketContent = [[[[[content objectForKey:@"retData"] objectForKey:@"ticketDetail"] objectForKey:@"data"] objectForKey:@"display"] objectForKey:@"ticket"];
        
        MATicketModel *ticket = [MATicketModel mj_objectWithKeyValues:ticketContent];
        
        if (ticket) {
            [self.ticketArr addObject:ticket];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
    }];
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return 100;
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.ticketArr.count;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     
     MATicketTableViewCell *ticketCell = [MATicketTableViewCell creatCellWithTableView:(UITableView *)tableView];
     ticketCell.ticket = self.ticketArr[indexPath.row];

     return ticketCell;

 }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *webUrl = [self.ticketArr[indexPath.row] detailUrl];
    
    MAWEBViewController *webVC = [[MAWEBViewController alloc]init];
    [webVC loadWebViewWithWebUrl:webUrl];
    [self.navigationController pushViewController:webVC animated:YES];
    
}

@end
