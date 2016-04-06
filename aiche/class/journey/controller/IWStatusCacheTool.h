//
//  IWStatusCacheTool.h
//  ItcastWeibo
//
//  Created by yz on 14/11/19.
//  Copyright (c) 2014年 iThinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MATicketModel;
@interface IWStatusCacheTool : NSObject

+ (void)saveWithStatuses:(NSDictionary *)dict;

+ (NSArray *)statusesWithParam:(MATicketModel *)param;

@end
