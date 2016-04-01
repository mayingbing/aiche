//
//  MABtnsView.h
//  爱车
//
//  Created by mayingbing on 16/4/1.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MABtnsView;

@protocol MABtnsViewDelegate <NSObject>

@optional

-(void)MABtnsViewJumpOutOrInWithMABtnsView:(MABtnsView *)maBtnView;

@end

@interface MABtnsView : UIView

@property(nonatomic ,weak)id<MABtnsViewDelegate> delegate;

@end
