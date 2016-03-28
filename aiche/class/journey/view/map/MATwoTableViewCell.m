//
//  MATwoTableViewCell.m
//  爱车
//
//  Created by mayingbing on 16/3/27.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MATwoTableViewCell.h"
#import "MACellMapView.h"

@interface MATwoTableViewCell ()

@property(nonatomic ,strong)UIView *mapView;

@end

@implementation MATwoTableViewCell

static NSString *twoID = @"twoCell";

+(instancetype)creatCellWithTableView:(UITableView *)tableView{
    
    id cell = [tableView dequeueReusableCellWithIdentifier:twoID];
    
    if (cell == nil) {
        
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:twoID];
        
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor grayColor];
        self.clipsToBounds = YES;
        
        [self setUpChildView];
    }
    return self;
}

-(void)setUpChildView{
    
    MACellMapView *mapView = [[MACellMapView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 158 - 100)];
    _mapView = mapView;
   mapView.backgroundColor = [UIColor greenColor];
    [self addSubview:mapView];
    
    [self setUpMapView];
    
}
-(void)setUpMapView{
    
    
    
}
@end
