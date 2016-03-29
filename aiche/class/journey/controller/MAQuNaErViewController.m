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

@interface MAQuNaErViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)MATicketModel *ticket;

@end

@implementation MAQuNaErViewController

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
    
    //获取数据
   // [self getQuNaErData];
}

-(void)getQuNaErData{
    
//    NSString *httpUrl = @"http://apis.baidu.com/apistore/qunaerticket/querydetail";
//    NSString *ID = @"id=";
//    NSInteger num = 1361653183;
//    
//    NSString *httpArg = [NSString stringWithFormat:@"%@%ld",ID,(long)num];
//
//    NSString *urlStr = [[NSString alloc]initWithFormat: @"%@?%@", httpUrl, httpArg];
//
//  
//    NSString *apikey = @"96c51e31f222b3b154a9ce707c9a32ea";
//    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    
//    session.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [session.requestSerializer setValue:apikey forHTTPHeaderField:@"apikey"];
//    
//    [session GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
    //       //    NSDictionary *content = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    //
    //    NSDictionary *retDataContent = [[[[[content objectForKey:@"retData"] objectForKey:@"ticketDetail"] objectForKey:@"data"] objectForKey:@"display"] objectForKey:@"ticket"];
    //    MATicketModel *ticket = [MATicketModel mj_objectWithKeyValues:retDataContent];
    //
    //    _ticket = ticket;
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        
//        
//    }];
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    return 100;
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     static NSString *ID = @"cell";
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
     
     
     
     return cell;
 }



@end
