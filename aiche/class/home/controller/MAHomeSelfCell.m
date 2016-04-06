//
//  MAHomeSelfCell.m
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAHomeSelfCell.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "UIImageView+WebCache.h"

#define CZAccountFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"judge.data"]

@interface MAHomeSelfCell ()



@property(nonatomic ,strong)UILabel *countLable;

@property(nonatomic ,strong)UIImageView *markView;

@end

@implementation MAHomeSelfCell

static NSString *oneID = @"oneCell";

+(instancetype)creatCellWithTableView:(UITableView *)tableView{
    
    id cell = [tableView dequeueReusableCellWithIdentifier:oneID];
    
    if (cell == nil) {
        
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:oneID];
        
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        
        
        [self setUpChildView];
        [self setupViewData];
    }
    return self;
}

-(void)setUpChildView{
    
    UIImageView *iconView = [[UIImageView alloc]init];
    _iconView = iconView;
    
    [self addSubview:iconView];
    
    UILabel *nameLable = [[UILabel alloc]init];
    _nameLable = nameLable;
    [self addSubview:nameLable];
    
    UILabel *countLable = [[UILabel alloc]init];
    _countLable = countLable;
    [self addSubview:countLable];
    
    UIImageView *markView = [[UIImageView alloc]init];
    _markView = markView;
    [self addSubview:markView];
    
    
    @weakify(self)
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
       @strongify(self)
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).with.offset(30);
        make.left.equalTo(self.iconView.mas_right).with.offset(10);
        make.height.mas_equalTo(@15);
    }];

    [countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.nameLable.mas_bottom).with.offset(10);
        make.left.equalTo(self.iconView.mas_right).with.offset(10);
        make.height.mas_equalTo(@15);
    }];
    
    markView.image = [UIImage imageNamed:@"mark"];
    [markView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.mas_top).with.offset(35);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];

}
-(void)setupViewData{
    
   
//    self.countLable.text = @"账号名";
    
}

@end
