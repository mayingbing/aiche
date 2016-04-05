//
//  MAHomeCameraViewController.h
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MABaseViewController.h"

@interface MAHomeCameraViewController : MABaseViewController
@property (copy, nonatomic) void(^sucessScanBlock)(NSString *result);
@end
