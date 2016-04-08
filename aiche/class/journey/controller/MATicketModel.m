//
//  MATicketModel.m
//  爱车
//
//  Created by mayingbing on 16/3/29.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MATicketModel.h"

@implementation MATicketModel
+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    MATicketModel *account = [[self alloc] init];
    
    [account setValuesForKeysWithDictionary:dict];
    
    return account;
}
@end
