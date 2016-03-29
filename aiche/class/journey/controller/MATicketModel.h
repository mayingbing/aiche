//
//  MATicketModel.h
//  爱车
//
//  Created by mayingbing on 16/3/29.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MATicketModel.h"

@interface MATicketModel : NSObject
    //spotName
@property (nonatomic ,copy) NSString *spotName;
    //spotID
@property (nonatomic ,copy) NSString *spotID;
    //spotID
@property (nonatomic ,copy) NSString *text;
//address
@property (nonatomic ,copy) NSString *address;
//imageUrl
@property (nonatomic ,strong) NSURL *imageUrl;
//priceList
@property (nonatomic ,copy) MATicketModel *priceList;




@end
