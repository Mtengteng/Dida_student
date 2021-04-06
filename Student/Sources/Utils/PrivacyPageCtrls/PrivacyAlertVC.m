//
//  PrivacyAlertVC.m
//  BWClassgoverment
//
//  Created by 马腾 on 2020/9/14.
//  Copyright © 2020 beiwaionline. All rights reserved.
//

#import "PrivacyAlertVC.h"
#import "PrivacyPageController.h"

@interface PrivacyAlertVC ()<UITextViewDelegate>
@property (nonatomic, strong) UIView *alertBGView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextView *desTextView;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *quitBtn;

@end

@implementation PrivacyAlertVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
}
- (void)createUI
{
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    
    [self.view addSubview:self.alertBGView];
    [self.alertBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(PAaptation_y(230));
        make.left.equalTo(self.view).offset(PAdaptation_x(20));
        make.right.equalTo(self.view.mas_right).offset(-PAdaptation_x(20));
        make.bottom.equalTo(self.view.mas_bottom).offset(-PAaptation_y(230));
    }];
    
    [self.alertBGView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.alertBGView).offset(PAaptation_y(10));
        make.left.equalTo(self.alertBGView);
        make.width.equalTo(self.alertBGView);
        make.height.mas_equalTo(PAaptation_y(20));
    }];
    
    [self.alertBGView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(PAaptation_y(10));
        make.left.equalTo(self.alertBGView).offset(PAdaptation_x(10));
        make.right.equalTo(self.alertBGView.mas_right).offset(-PAdaptation_x(10));
        make.bottom.equalTo(self.alertBGView.mas_bottom).offset(-PAaptation_y(100));
    }];
    
    [self.alertBGView addSubview:self.desTextView];
    [self.desTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(PAaptation_y(10));
        make.left.equalTo(self.textView);
        make.right.equalTo(self.textView.mas_right);
    }];
    
    [self.alertBGView addSubview:self.quitBtn];
    
    [self.alertBGView addSubview:self.sureBtn];

    NSArray *viewsArray = @[self.quitBtn,self.sureBtn];
    [viewsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [viewsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(PAaptation_y(40));
        make.bottom.equalTo(self.alertBGView.mas_bottom);
    }];
    
}
- (void)quitAction:(id)sender
{
    self.textView.text = @"您需要同意用户协议与隐私政策后才能使用北外在线。\n\n如您不同意，很遗憾我们无法为您提供服务。";
    [self.quitBtn setTitle:@"退出" forState:UIControlStateNormal];
    [self.quitBtn addTarget:self action:@selector(exitAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)agreeAction:(id)sender
{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:[NSNumber numberWithBool:YES] forKey:@"privacyAgree"];
    [user synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)exitAction:(id)sender
{
    exit(0);
}
#pragma mark - UITextViewDelegate -
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([[URL scheme] isEqualToString:@"userDelegate"]) {
        NSLog(@"用户协议---------------");
        
        PrivacyPageController *pageCtrl = [[PrivacyPageController alloc] init];
        [pageCtrl loadPrivacyHtmlWithAppName:@"用户协议" andHtml:UserProURL isHiddenBottomView:YES];
        [self.navigationController pushViewController:pageCtrl animated:YES];
        
        return NO;
    } else {
        NSLog(@"隐私政策---------------");
        PrivacyPageController *pageCtrl = [[PrivacyPageController alloc] init];
        [pageCtrl loadPrivacyHtmlWithAppName:@"隐私政策" andHtml:PrivacyURL isHiddenBottomView:YES];
        [self.navigationController pushViewController:pageCtrl animated:YES];

        return NO;
    }
    return YES;
}
#pragma mark - 懒加载 -
- (UIView *)alertBGView
{
    if (!_alertBGView) {
        _alertBGView = [[UIView alloc] init];
        _alertBGView.backgroundColor = [UIColor whiteColor];

    }
    return _alertBGView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _titleLabel.text = @"用户协议与隐私政策提示";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.text = @"\n感谢您信任并使用北外在线。\n\n我们将依据《北京外国语大学网络教育学院用户协议》及《个人信息及隐私保护政策》来帮助您了解我们在收集、使用、存储和共享您个人信息的情况以及您享有的相关权利。\n\n在您使用北外在线视频观看服务时，我们将收集您的设备信息、操作日志及浏览记录等信息。\n\n在您使用北外在线做测试练习等服务时，我们需要获取您设备的相机权限、相册权限、录音权限等信息。\n\n您可以在相关页面访问、修改、删除您的个人信息或管理您的授权。\n\n我们会采用行业内领先的安全技术来保护您的个人信息。";
        _textView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
        _textView.font = [UIFont systemFontOfSize:12.0];
    }
    return _textView;
}
- (UITextView *)desTextView
{
    if (!_desTextView) {
        
        _desTextView = [[UITextView alloc] init];
        _desTextView.delegate = self;
        _desTextView.editable = NO;        //必须禁止输入，否则点击将弹出输入键盘
        _desTextView.scrollEnabled = NO;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"您可通过阅读完整的《用户协议》和《隐私政策》来了解详细信息"];
        [attributedString addAttribute:NSLinkAttributeName
                                    value:@"userDelegate://"
                                    range:[[attributedString string] rangeOfString:@"《用户协议》"]];
        [attributedString addAttribute:NSLinkAttributeName
                                    value:@"privacyDelegate://"
                                    range:[[attributedString string] rangeOfString:@"《隐私政策》"]];
        
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, attributedString.length)];
        
        UIColor *blue = [UIColor colorWithRed:73.0/255.0 green:161.0/255.0 blue:232.0/255.0 alpha:1.0];
        
        _desTextView.attributedText = attributedString;
        _desTextView.linkTextAttributes = @{NSForegroundColorAttributeName: blue,
                                         NSUnderlineColorAttributeName: [UIColor lightGrayColor],
                                         NSUnderlineStyleAttributeName: @(NSUnderlinePatternSolid)};

    }
    return _desTextView;
}
- (UIButton *)quitBtn
{
    if (!_quitBtn) {
        _quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _quitBtn.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:231.0/255.0 blue:235.0/255.0 alpha:1.0];
        [_quitBtn setTitle:@"不同意" forState:UIControlStateNormal];
        [_quitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_quitBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_quitBtn addTarget:self action:@selector(quitAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitBtn;
}
- (UIButton *)sureBtn
{
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.backgroundColor = [UIColor colorWithRed:73.0/255.0 green:161.0/255.0 blue:232.0/255.0 alpha:1.0];
        [_sureBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_sureBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}
@end
