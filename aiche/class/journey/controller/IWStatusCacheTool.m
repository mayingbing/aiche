//
//  IWStatusCacheTool.m
//  ItcastWeibo
//
//  Created by yz on 14/11/19.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import "IWStatusCacheTool.h"
#import "FMDB.h"
#import "MATicketModel.h"

#import "MJExtension.h"

#define IWStatusFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"status.sqlite"]

static FMDatabase *_db;

@implementation IWStatusCacheTool

+ (void)initialize
{
    // 创建FMDatabase
    _db = [FMDatabase databaseWithPath:IWStatusFile];
    // 打开数据库
    if ([_db open]) {
       // NSLog(@"打开成功");
        // 创建表格
         BOOL success =[_db executeUpdate:@"create table if not exists t_status (id integer primary key autoincrement,spotID text not null,dict blob not null,spotName text not null);"];
        if (success) {
           // NSLog(@"创表成功");
        }else{
           // NSLog(@"创表失败");
        }
        
    }else{
      //  NSLog(@"打开失败");
    }
}
+ (void)saveWithStatuses:(NSDictionary *)dict
{
    if (dict) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        BOOL success =[_db executeUpdate:@"insert into t_status (spotID,dict,spotName) values(?,?,?)",dict[@"spotID"],data,dict[@"spotName"]];
        if (success) {
          //  NSLog(@"插入成功");
        }else{
          //  NSLog(@"插入失败");
        }
    }
}
+ (NSArray *)statusesWithParam:( MATicketModel *)param
{
    FMResultSet *set;
    
     set = [_db executeQuery:@"select * from t_status"];
    
    NSMutableArray *arrM = [NSMutableArray array];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"dict"];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
         MATicketModel *s = [MATicketModel mj_objectWithKeyValues:dict];
        [arrM addObject:s];
    }
    
    return arrM;
}

@end
