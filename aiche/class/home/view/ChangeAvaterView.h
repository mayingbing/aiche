//
//  ChangeAvaterView.h

//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeAvaterView : UIView

/**
 *  弹出的view
 */
@property(nonatomic,strong)UIView * popView;

/**
 *  thisTag 50000
 */
@property(nonatomic,assign)NSInteger  thisTag;

- (instancetype)initWithFrame:(CGRect)frame andBtnArr:(NSArray *)btnArr;

- (void)show;

- (void)hide;

@end
