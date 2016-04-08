//
//  MAHomeSelfCell.h
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAHomeSelfCell : UITableViewCell

@property(nonatomic ,strong)UIImageView *iconView;
@property(nonatomic ,strong)UILabel *nameLable;

+(instancetype)creatCellWithTableView:(UITableView *)tableView;
@end
