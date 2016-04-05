//
//  MAHomeWEBViewController.m
//  爱车
//
//  Created by mayingbing on 16/4/5.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAHomeWEBViewController.h"
#import "MBProgressHUD.h"

@interface MAHomeWEBViewController ()<UIWebViewDelegate>
@property(nonatomic ,strong)NSString *webString;
@end

@implementation MAHomeWEBViewController


+(instancetype)initWebWithNSString:(NSString *)webString{
    
    MAHomeWEBViewController *webView = [[MAHomeWEBViewController alloc]init];
    
    webView.webString = webString;
    
    return webView;
}

-(instancetype)init{
    
    if (self = [super init]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview: web];
    
    NSString *urlStr = self.webString;
    
    
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [web loadRequest:request];
    
    web.delegate = self;
    
}
#pragma mark -UIWebView代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 提示用户正在加载...
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //[MBProgressHUD showMessage:@"正在加载..."];
}

// webview加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

//  webview加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end
