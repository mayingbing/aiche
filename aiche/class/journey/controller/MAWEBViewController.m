//
//  MAWEBViewController.m
//  爱车
//
//  Created by mayingbing on 16/3/30.
//  Copyright © 2016年 aiche. All rights reserved.
//

#import "MAWEBViewController.h"
#import "MBProgressHUD.h"
//#import "MBProgressHUD"
@interface MAWEBViewController ()<UIWebViewDelegate>

@end

@implementation MAWEBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

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

-(void)loadWebViewWithWebUrl:(NSString *)webUrl{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSURL *url = [[NSURL alloc]initWithString:webUrl];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    [webView loadRequest:request];
    
    webView.delegate = self;
}
@end
