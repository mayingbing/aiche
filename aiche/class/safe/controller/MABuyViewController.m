//
//  MABuyViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/31.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MABuyViewController.h"
#import "MBProgressHUD.h"

@interface MABuyViewController ()<UIWebViewDelegate>

@end

@implementation MABuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    NSString *webUrl = @"http://m.yiche.com";
    NSURL *url = [[NSURL alloc]initWithString:webUrl];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    [webView loadRequest:request];
    
    self.navigationItem.title = @"无数据接口";
    
    webView.delegate = self;
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
