//
//  MACameraViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/4.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MACameraViewController.h"

@interface MACameraViewController ()

@end

@implementation MACameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
//    [self ];
}



#pragma mark -保存图片

- (void)saveImage:(UIImage *)image
{
    NSData *data = nil;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    UIImage *img = [UIImage imageWithData:data];
    (void)img;
    [self saveImageData:data];
}

- (void)saveImageData:(NSData *)data
{
    NSString *TMP_UPLOAD_IMG_PATH = @"";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    TMP_UPLOAD_IMG_PATH = [NSString stringWithFormat:@"%@%@",DocumentsPath, @"/image.png"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:TMP_UPLOAD_IMG_PATH]) {
        NSError *error;
        BOOL success = [fileManager removeItemAtPath:TMP_UPLOAD_IMG_PATH error:&error];
        if (success) {
            
        } else {
            NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
        }
    }
    
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
}


@end
