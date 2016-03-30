//
//  MATicketTableViewCell.m
//  爱车
//
//  Created by mayingbing on 16/3/30.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MATicketTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "MATicketModel.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"

@interface MATicketTableViewCell ()
@property(nonatomic ,strong) UIImageView *iconView;
@property(nonatomic ,strong) UILabel *spotName;
@property(nonatomic ,strong) UILabel *address;

@end

@implementation MATicketTableViewCell

static NSString *ticketID = @"oneCell";

+(instancetype)creatCellWithTableView:(UITableView *)tableView{
    
    id cell = [tableView dequeueReusableCellWithIdentifier:ticketID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ticketID];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setTicket:(MATicketModel *)ticket{
    
    _ticket = ticket;
    
    for (UIView *contentView in self.subviews) {
        [contentView removeFromSuperview];
    }

    [self setUpChildView];
}

-(void)setUpChildView{
    
//iconView
    UIImageView *iconView = [[UIImageView alloc]init];
    [self addSubview:iconView];
    _iconView = iconView;
    [iconView sd_setImageWithURL:self.ticket.imageUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    @weakify(self)
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.mas_left).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
//spotName
    UILabel *spotName = [[UILabel alloc]init];
    [self addSubview:spotName];
    _spotName = spotName;
    spotName.font = [UIFont systemFontOfSize:18];
    spotName.text = self.ticket.spotName;
    spotName.textColor = [UIColor orangeColor];
   
    [spotName mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.iconView.mas_right).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(15);
        make.height.equalTo(@18);
    }];
    
//    address
    UILabel *address = [[UILabel alloc]init];
    [self addSubview:address];
    _address = address;
    address.numberOfLines =0;
    address.font = [UIFont systemFontOfSize:15];
    address.text = self.ticket.address;
    [address mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.left.equalTo(self.iconView.mas_right).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.spotName.mas_bottom).with.offset(15);
        
    }];
    
}

@end
