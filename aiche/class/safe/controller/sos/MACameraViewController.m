//
//  MACameraViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/4.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MACameraViewController.h"
#import <AssetsLibrary/ALAssetsLibrary.h>



@interface MACameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MACameraViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
        
   [self prefersStatusBarHidden];
    
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc] init];
    
    imagePicker.delegate=self;
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        
        //摄像功能
        NSArray *temp_MediaTypes = [UIImagePickerController availableMediaTypesForSourceType:imagePicker.sourceType];
        imagePicker.mediaTypes = temp_MediaTypes;
        
        
        imagePicker.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }

    [self presentViewController:imagePicker animated:YES completion:^{
        
    }];
}

/*
 - (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    if ([mediaType isEqualToString:@"public.image"]){
      
        //得到图片
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        

    }
    else if([mediaType isEqualToString:@"public.movie"]){
        NSURL *videoURL = [info objectForKey:UIImagePickerControllerMediaURL];
        NSLog(@"%@", videoURL);
        NSLog(@"found a video");
        NSData *videoData = [NSData dataWithContentsOfURL:videoURL];
        
 
        
        NSString *videoFile = [documentsDirectory stringByAppendingPathComponent:@"temp.mov"];
        NSLog(@"%@", videoFile);
        
        success = [fileManager fileExistsAtPath:videoFile];
        if(success) {
            success = [fileManager removeItemAtPath:videoFile error:&error];
        }
        [videoData writeToFile:videoFile atomically:YES];
        
        //视频存入相册
        UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoFile);

    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}
*/

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
   
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    // 判断获取类型：图片
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        UIImage *theImage = nil;
        
        // 判断，图片是否允许修改
        
        if ([picker allowsEditing]){
            
            //获取用户编辑之后的图像
            
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
            
        } else {
            
            // 照片的元数据参数
            
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
            
            
            
        }
        
        // 保存图片到相册中

        
        //图片存入相册
        UIImageWriteToSavedPhotosAlbum(theImage, nil, nil, nil);
        
    }else{
        
        // 判断获取类型：视频
        
        //获取视频文件的url
        
        NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
        
        //创建ALAssetsLibrary对象并将视频保存到媒体库
        
        // Assets Library 框架包是提供了在应用程序中操作图片和视频的相关功能。相当于一个桥梁，链接了应用程序和多媒体文件。
        
        ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
        
        // 将视频保存到相册中
        
        [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:mediaURL
         
                                          completionBlock:^(NSURL *assetURL,    NSError *error) {
                                              
                                              if (!error) {
                                                  
                                              }else{
                                                  
                                              }
                                              
                                          }];
        
    }

   [picker dismissViewControllerAnimated:YES completion:nil];
    
}



@end
