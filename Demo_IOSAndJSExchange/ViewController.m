//
//  ViewController.m
//  Demo_IOSAndJSExchange
//
//  Created by liudukun on 14/12/3.
//  Copyright (c) 2014年 liudukun. All rights reserved.
//

#import "WebViewJavascriptBridge.h"
#import "ViewController.h"

@interface ViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
       CGRect screen = [UIScreen mainScreen].bounds;
    self.webView.frame = screen;
    NSURLRequest * req = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/adf/hello.php"]];
    [self.webView loadRequest:req];
    
    WebViewJavascriptBridge* bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"Received message from javascript: %@", data);
        responseCallback(@"Right back atcha");
    }];
    [bridge send:@"Well hello there"];
    [bridge send:[NSDictionary dictionaryWithObject:@"Foo" forKey:@"Bar"]];
    [bridge send:@"Give me a response, will you?" responseCallback:^(id responseData) {
        NSLog(@"ObjC got its response! %@", responseData);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    NSString * descruption =  [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];;
    self.titleLabel.text = descruption;
}

@end
