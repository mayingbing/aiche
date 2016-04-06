//
//  MAHeadTableViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAHeadTableViewController.h"
#import "UIImageView+WebCache.h"
#import "MAHomeCameraViewController.h"
#import "MAHomeWEBViewController.h"
#import "MANameViewController.h"
#import "ChangeAvaterView.h"
#import "MBProgressHUD.h"

//按比例获取高度
#define  WGiveHeight(HEIGHT) HEIGHT * [UIScreen mainScreen].bounds.size.height/568.0

//按比例获取宽度
#define  WGiveWidth(WIDTH) WIDTH * [UIScreen mainScreen].bounds.size.width/320.0
#define CZImageFileName [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"image.data"]

@interface MAHeadTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,copy)NSArray * titleArr;
@property(nonatomic ,strong)NSString *webString;
@property(nonatomic,strong)ChangeAvaterView * changeView;
@property(nonatomic,strong)UIImageView * imageView ;

@end

@implementation MAHeadTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _titleArr = @[
                  @[
                      @"头像",
                      @"名字",
//                      @"微信号",
                      @"扫一扫",
//                      @"我的地址"
                      ]
                  ,
                  @[
//                      @"性别",
//                      @"地区",
//                      @"个性签名"
                      ]
                  
                  ];
    

    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self setCellData];
}

-(void)setCellData{
    
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:CZImageFileName]) {
        
        self.imageView.image = [NSKeyedUnarchiver unarchiveObjectWithFile:CZImageFileName];
    }else{
        self.imageView.image = [UIImage imageNamed:@"WWeChat"];
    }
    

    
}

#pragma mark -- tableView --
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _titleArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = _titleArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"PersonCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = _titleArr[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        if (_imageView ==nil) {
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(220), (cell.frame.size.height - WGiveHeight(64))/2.0, WGiveHeight(64), WGiveHeight(64))];
            _imageView = imageView;
            [self setCellData];
        }
        
       
        
        _imageView.layer.cornerRadius = 5;
        _imageView.clipsToBounds = YES;
        
        [cell.contentView addSubview:_imageView];
    }
    else if(indexPath.section == 0 && indexPath.row == 2)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(WGiveWidth(270), (cell.frame.size.height - WGiveHeight(18))/2.0, WGiveHeight(18), WGiveHeight(18))];
        
        imageView.image = [UIImage imageNamed:@"setting_myQR"];
        
        [cell.contentView addSubview:imageView];
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        UILabel * signLabel = [[UILabel alloc]initWithFrame:CGRectMake(WGiveWidth(148), 0, WGiveWidth(145), cell.frame.size.height)];
        signLabel.text = @"佛教中有一句话：初学者的心态；拥有初学者的心态是件了不起的事情。";
        signLabel.textAlignment = NSTextAlignmentRight;
        signLabel.textColor = [UIColor grayColor];
        signLabel.numberOfLines = 0;
        [cell.contentView addSubview:signLabel];
    }
    else
    {
//        NSLog(@"font%@  color%@",cell.textLabel.font,cell.textLabel.textColor);
        cell.detailTextLabel.text = @" ";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        return WGiveHeight(80);
    }
    else if(indexPath.section == 1 && indexPath.row == 2)
    {
        return 100;
    }
    else
    {
        return WGiveHeight(44);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return WGiveHeight(15);
    }
    else
    {
        return WGiveHeight(20);
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        //修改头像
        if (indexPath.row == 0)
        {
            
            if (!_changeView)
            {
                _changeView = [[ChangeAvaterView alloc]initWithFrame:self.view.bounds andBtnArr:@[
                                                                                                  @"拍照",
                                                                                                  @"从手机相册选择",
                                                                                                  @"保存图片"
                                                                                                  ]];
                UIButton * cameraBtn = (UIButton *)[_changeView viewWithTag:_changeView.thisTag + 0];
                UIButton * photoBtn = (UIButton *)[_changeView viewWithTag:_changeView.thisTag + 1];
                UIButton * saveBtn = (UIButton *)[_changeView viewWithTag:_changeView.thisTag + 2];
                [cameraBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                [photoBtn addTarget:self action:@selector(photoClick:) forControlEvents:UIControlEventTouchUpInside];
                [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
            }
            [[UIApplication sharedApplication].keyWindow addSubview:_changeView];
            [_changeView show];
 

        }
        //修改用户名
        else if(indexPath.row == 1)
        {
            MANameViewController *nameVC = [[MANameViewController alloc]init];
            nameVC.view.backgroundColor = [UIColor whiteColor];
            [self.navigationController pushViewController:nameVC animated:YES];
            
            
        }

        else if(indexPath.row == 2)
        {
        MAHomeCameraViewController *scanCodeViewController = [[MAHomeCameraViewController alloc]init];
            scanCodeViewController.sucessScanBlock = ^(NSString *result) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _webString = result;
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"二维码扫描结果" message:result preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                        [self loadWebViewWith:(NSString *)result];
                        
                    }];
                    [alertController addAction:okAction];
                    [self presentViewController:alertController animated:YES completion:nil];
                });
            };
            [self.navigationController pushViewController:scanCodeViewController animated:YES];

        }
        //地址
        else if(indexPath.row == 4)
        {
           
        }
    }
    else
    {
        //性别
        if (indexPath.row == 0)
        {
            
        }
        //地区
        else if(indexPath.row == 1)
        {
            
        }
        //个性签名
        else if(indexPath.row == 2)
        {
            
        }
    }
    UITableViewCell *cell = (UITableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    cell.selected = NO;
    
}

- (CGFloat)giveMeHeightWithStr:(NSString *)str
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:17]};
    
    CGSize retSize = [str boundingRectWithSize:CGSizeMake(WGiveWidth(145), MAXFLOAT)
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    
    return retSize.height;
}

-(void)loadWebViewWith:(NSString *)result{
    
    MAHomeWEBViewController *webVc = [MAHomeWEBViewController initWebWithNSString:result];
    [self.navigationController pushViewController:webVc animated:YES];
    
}

- (void)cameraBtnClick:(UIButton *)sender
{
    [_changeView hide];
//    NSLog(@"拍照");
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
    }else
    {
//        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

- (void)photoClick:(UIButton *)sender
{
    [_changeView hide];
//    NSLog(@"相册");
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:^{
        
    }];
}

- (void)saveClick:(UIButton *)sender
{
    [_changeView hide];
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"";
    if (!error) {
        message = @"成功保存到相册";

    }else
    {
        message = [error description];
    }
//    NSLog(@"message is %@",message);
}

//当选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        UIImage * smallImage = [self imageWithImageSimple:image scaledToSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.width)];
        
        
        [NSKeyedArchiver archiveRootObject:smallImage toFile:CZImageFileName];
        
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        

        
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


//压缩图片方法
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

@end
