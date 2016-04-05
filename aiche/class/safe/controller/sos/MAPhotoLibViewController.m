//
//  MAPhotoLibViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAPhotoLibViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>



@interface MAPhotoLibViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@end

@implementation MAPhotoLibViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
//    
//    
//    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
//    
//    imagePicker.delegate=self;
//    
//    //设置选择后的图片可被编辑
//    imagePicker.allowsEditing = YES;
//    
//    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    
//    [self presentViewController:imagePicker animated:YES completion:nil];
    
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        
        
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        
        picker.delegate = self;
        
        picker.allowsEditing = YES;  //是否可编辑
        
        //摄像头
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:nil];
    
 
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:YES];
//    //根据图片路径载入图片
//    NSString *photoPath = [[NSBundle mainBundle] pathForResource:@"camera" ofType:@"png"];
//    
//    UIImage *image=[UIImage imageWithContentsOfFile:photoPath];
//    if (image == nil) {
//        //显示默认
//        [changeImg setBackgroundImage:[UIImage imageNamed:@"user_photo@2x.png"] forState:UIControlStateNormal];
//    }else {
//        //显示保存过的
//        [changeImg setBackgroundImage:image forState:UIControlStateNormal];
//    }
//}

}
@end

