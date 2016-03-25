//
//  DGAaimaView.h
//  animaByIdage
//
//  Created by chuangye on 15-3-11.
//  Copyright (c) 2015年 chuangye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DGAaimaView;

@protocol DGAaimaViewDelegate <NSObject>

@optional

-(void)stopAnimateViewWith:(DGAaimaView *)animateView;

@end

@interface DGAaimaView : UIView

@property(nonatomic ,weak)id<DGAaimaViewDelegate> delegate;


@end
