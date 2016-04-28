//
//  LYWebViewController.m
//  LYBestSister
//
//  Created by lieyanmomo on 16/4/20.
//  Copyright © 2016年 lieyanmomo. All rights reserved.
//

#import "LYWebViewController.h"

@interface LYWebViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation LYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 加载网页
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    // 设置webView的代理
    self.webView.delegate = self;
    
}


- (IBAction)back {
    [self.webView goBack];
}

- (IBAction)forward {
    [self.webView goForward];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}

@end
