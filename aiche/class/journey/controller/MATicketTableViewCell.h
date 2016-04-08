//
//  MATicketTableViewCell.h
//  爱车
//
//  Created by mayingbing on 16/3/30.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MATicketModel;

@interface MATicketTableViewCell : UITableViewCell

+(instancetype)creatCellWithTableView:(UITableView *)tableView;

@property (nonatomic ,strong) MATicketModel *ticket;

@end
