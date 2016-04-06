//
//  MATicketModel.h
//  爱车
//
//  Created by mayingbing on 16/3/29.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MATicketModel : NSObject
    //spotName
@property (nonatomic ,copy) NSString *spotName;
    //spotID
@property (nonatomic ,copy) NSString *spotID;
    //spotID
@property (nonatomic ,copy) NSString *detailUrl;
//address
@property (nonatomic ,copy) NSString *address;
//imageUrl
@property (nonatomic ,strong) NSURL *imageUrl;


+ (instancetype)accountWithDict:(NSDictionary *)dict;


@end
