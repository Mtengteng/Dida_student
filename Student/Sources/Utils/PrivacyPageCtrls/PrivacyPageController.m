//
//  SAWKViewController.m
//  SAPro
//
//  Created by 马腾 on 2019/8/28.
//  Copyright © 2019 beiwaionline. All rights reserved.
//

#import "PrivacyPageController.h"
#import <WebKit/WebKit.h>

#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏高度

#define NavBarHeight 44.0

#define TopHeight (StatusBarHeight + NavBarHeight) //整个导航栏高度

#define TabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49) //底部tabbar高度

#define P_ADAPTATION_X(x) (((x)*[[UIScreen mainScreen] bounds].size.width)/640)

#define P_ADAPTATION_Y(y) (((y)*[[UIScreen mainScreen] bounds].size.height)/1134)

#define IPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


@interface PrivacyPageController ()<WKUIDelegate,WKNavigationDelegate>
{
    BOOL isHide;
    BOOL backHide;
}
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIView *bottomView;



@end

@implementation PrivacyPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
}
- (void)loadPrivacyHtmlWithAppName:(NSString *)appName andHtml:(NSString *)html isHiddenBottomView:(BOOL)isHidden
{
    self.title = appName;
    
    isHide = isHidden;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:html]]];
   
}
- (void)createLeftBackBtnWithImageName:(NSString *)imageName{
    if (imageName.length >0) {
        backHide = NO;
    }else{
        backHide = YES;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 10);
    UIView *leftView = [[UIView alloc]initWithFrame:leftBtn.bounds];
    [leftBtn setImage:image forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:leftBtn];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftView];
    self.navigationItem.leftBarButtonItem = leftBar;
   
   
}
- (void)back:(id)sender
{
    if (backHide) {
        return;
    }
    [self.navigationController popViewControllerAnimated:YES];
}
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

- (void)disagreeAction:(id)sender
{
    if (_disagree) {
        _disagree();
    }
}
- (void)agreeAction:(id)sender
{
    if (_agress) {
        _agress();
    }
}
#pragma mark - LazyLoad
- (UIProgressView *)progressView
{
    if(!_progressView)
    {
        _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 1, self.view.bounds.size.width, 1)];
        self.progressView.tintColor = [UIColor greenColor];
        self.progressView.trackTintColor = [UIColor whiteColor];
        [self.view addSubview:_progressView];

    }
    return _progressView;
}
- (WKWebView *)webView
{
    if (!_webView) {
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        
        CGRect rect = CGRectMake(P_ADAPTATION_X(20), 0, self.view.bounds.size.width - P_ADAPTATION_X(40), isHide ? (self.view.bounds.size.height - TopHeight):(self.view.bounds.size.height-TabBarHeight-TopHeight));
        
        _webView = [[WKWebView alloc] initWithFrame:rect configuration:configuration];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [self.view addSubview:_webView];
        
        if (!isHide) {
            [self.view addSubview:self.bottomView];
        }
    }
    return _webView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - TabBarHeight - TopHeight, self.view.bounds.size.width, TabBarHeight)];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_bottomView];
        
        UIButton *_disagreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _disagreeBtn.backgroundColor = [UIColor clearColor];
        [_disagreeBtn setFrame:CGRectMake(P_ADAPTATION_X(15), P_ADAPTATION_Y(15),P_ADAPTATION_X(80), P_ADAPTATION_Y(40))];
        [_disagreeBtn setTitle:@"不同意" forState:UIControlStateNormal];
        [_disagreeBtn.titleLabel setFont:[UIFont systemFontOfSize:IPhone5 ?12: 14.0]];
        [_disagreeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_disagreeBtn addTarget:self action:@selector(disagreeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_disagreeBtn];
        
        UIButton *_agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _agreeBtn.backgroundColor = [UIColor clearColor];
        [_agreeBtn setFrame:CGRectMake(_bottomView.frame.size.width - P_ADAPTATION_X(95), P_ADAPTATION_Y(15), P_ADAPTATION_X(80), P_ADAPTATION_Y(40))];
        [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_agreeBtn.titleLabel setFont:[UIFont systemFontOfSize:IPhone5 ?12:14.0]];
        [_agreeBtn setTitleColor:[UIColor colorWithRed:73.0/255.0 green:161.0/255.0 blue:232.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:_agreeBtn];

    }
    return _bottomView;
}
-(void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
