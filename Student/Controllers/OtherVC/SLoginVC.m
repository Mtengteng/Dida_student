//
//  SLoginVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "SLoginVC.h"
#import "SRootVC.h"
#import "CustomPrivacyView.h"
#import "PrivacyPageController.h"
#import "PrivacyAlertVC.h"
#import "TPKeyboardAvoidingScrollView.h"

#import "BWLoginReq.h"
#import "BWLoginResp.h"

@interface SLoginVC ()
@property (nonatomic, strong) UIView *loginBgView;
@property (nonatomic, strong) UIView *passwordBgView;
@property (nonatomic, strong) UIImageView *loginImageView;
@property (nonatomic, strong) UIImageView *passwordImageView;
@property (nonatomic, strong) UITextField *loginNameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *loginInBtn;
@property (nonatomic, strong) UIButton *forgetBtn;
@property (nonatomic, strong) TPKeyboardAvoidingScrollView *myScrollView;
@property (nonatomic, strong) CustomPrivacyView *customView;//隐私政策条目View
@property (nonatomic, strong) PrivacyPageController *privacyPageCtrl;//隐私详情Controller
@end

@implementation SLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginNameField.text = @"a001";
    self.passwordField.text = @"a001";
    
    [self createUI];
    
    [self loginClick:nil];
}

- (void)createUI{
    
    self.title = @"登录";
    
    [self.view addSubview:self.myScrollView];
    [self.myScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.myScrollView addSubview:self.loginBgView];
    [self.loginBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(PAaptation_y(64));
        make.left.equalTo(self.view).offset(PAdaptation_x(25));
        make.right.equalTo(self.view.mas_right).offset(-PAdaptation_x(25));
        make.height.mas_equalTo(PAaptation_y(55));
    }];
    
    UIImage *userImg = [UIImage imageNamed:@"user-header.png"];
    [self.loginImageView setImage:userImg];
    [self.loginBgView addSubview:self.loginImageView];
    [self.loginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loginBgView);
        make.left.equalTo(self.loginBgView).offset(PAdaptation_x(10));
        make.width.mas_equalTo(userImg.size.width);
        make.height.mas_equalTo(userImg.size.height);
    }];
    
    [self.loginBgView addSubview:self.loginNameField];
    [self.loginNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.loginBgView);
        make.left.equalTo(self.loginImageView.mas_right).offset(PAdaptation_x(10));
        make.right.equalTo(self.loginBgView.mas_right).offset(-PAdaptation_x(10));
    }];
    
    [self.myScrollView addSubview:self.passwordBgView];
    [self.passwordBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBgView.mas_bottom).offset(-PAaptation_y(1));
        make.left.equalTo(self.view).offset(PAdaptation_x(25));
        make.right.equalTo(self.view.mas_right).offset(-PAdaptation_x(25));
        make.height.mas_equalTo(PAaptation_y(55));
    }];
    
    UIImage *pwImage = [UIImage imageNamed:@"password.png"];
    [self.passwordImageView setImage:pwImage];
    [self.passwordBgView addSubview:self.passwordImageView];
    [self.passwordImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.passwordBgView);
        make.left.equalTo(self.passwordBgView).offset(PAdaptation_x(10));
        make.width.mas_equalTo(pwImage.size.width);
        make.height.mas_equalTo(pwImage.size.height);
    }];
    
    [self.passwordBgView addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.passwordBgView);
        make.left.equalTo(self.passwordImageView.mas_right).offset(PAdaptation_x(10));
        make.right.equalTo(self.passwordBgView.mas_right).offset(-PAdaptation_x(10));
    }];
    
    [self.myScrollView addSubview:self.loginInBtn];
    [self.loginInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordBgView.mas_bottom).offset(PAaptation_y(15));
        make.left.equalTo(self.passwordBgView);
        make.width.equalTo(self.passwordBgView);
        make.height.mas_equalTo(PAaptation_y(44));
    }];
    
   
//    [self.myScrollView addSubview:self.forgetBtn];
//    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.loginInBtn.mas_bottom).offset(PAaptation_y(10));
//        make.right.equalTo(self.loginInBtn.mas_right);
//        make.height.mas_equalTo(PAaptation_y(40));
//    }];
    
    [self.myScrollView addSubview:self.customView];
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginInBtn.mas_bottom).offset(PAaptation_y(5));
        make.left.equalTo(self.loginInBtn);
        make.right.equalTo(self.loginInBtn.mas_right);
        make.height.mas_equalTo(PAaptation_y(40));
    }];

    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    BOOL isAgree = [[user objectForKey:@"privacyAgree"]boolValue];
    if (!isAgree) {
        //设置隐私页面
        [self setupPrivacyVCtrl];
    }
}
- (void)setupPrivacyVCtrl
{
    PrivacyAlertVC *privacyVC = [[PrivacyAlertVC alloc] init];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:privacyVC];
    navCtrl.navigationBar.translucent = NO;
    navCtrl.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:navCtrl animated:YES completion:nil];
    
}
- (void)setControlView:(UIView *)view borderWidth:(CGFloat)width borderColor:(UIColor *)color cornerRadius:(CGFloat)cor
{
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = width;
    view.layer.borderColor = color.CGColor;
    view.layer.cornerRadius = cor;
}
/*
- (void)autoLoginRequest
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];

    NSString *loginName = [userDef objectForKey:KEY_LoginName];
    NSString *password = [userDef objectForKey:KEY_Password];
    
    self.loginNameField.text = loginName;
    self.passwordField.text = password;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    DefineWeakSelf;
    BWLoginReq *loginReq = [[BWLoginReq alloc] init];
    loginReq.loginName = loginName;
    loginReq.passWord = password;
    [NetManger getRequest:loginReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        BWLoginResp *loginResp = (BWLoginResp *)resp;
        NSDictionary *userDic = loginResp.result;
        
        [weakSelf saveDic:userDic];
        
        [weakSelf setCookieWithItem:userDic];

        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        appDelegate.window.rootViewController = [[NXBaseTabbarVC alloc] init];
        
        DownLoadManager.userId = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_UserId];
        DownLoadManager.sourceArray = [DownLoadManager getFinishSource];

        
    } failure:^(BWBaseReq *req, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showMessag:error.domain toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];
    }];
}
 */
- (void)loginClick:(id)sender
{
    if (!self.customView.selectState) {
            
        [MBProgressHUD showMessag:@"请先阅读用户协议和隐私政策并勾选同意" toView:self.view hudModel:MBProgressHUDModeText hide:YES];
              
        return;
         
    }
    NSString *name = [self.loginNameField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *password = [self.passwordField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([name isEqualToString:@""] || [password isEqualToString:@""]) {
        [MBProgressHUD showMessag:@"用户名或密码不能为空或空格" toView:self.view hudModel:MBProgressHUDModeText hide:YES];
        return;
    }
    
    [SCustomProgressHUD showHUDAddedTo:self.view animated:YES];
    
    DefineWeakSelf;
    BWLoginReq *loginReq = [[BWLoginReq alloc] init];
    loginReq.methodType = httpMethod_POST;
    loginReq.username = name;
    loginReq.password = password;
    [NetManger sendRequest:loginReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
        
        [SCustomProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        BWLoginResp *loginResp = (BWLoginResp *)resp;
        
        [weakSelf saveDic:loginResp.userInfo];
        
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        appDelegate.window.rootViewController = [[SRootVC alloc] init];
        

        
    } failure:^(BWBaseReq *req, NSError *error) {
        [SCustomProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showMessag:error.domain toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];
    }];
           
}
- (void)saveDic:(NSDictionary *)userDic
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:[userDic safeObjectForKey:@"id"] forKey:KEY_userId];
    [userDef setObject:[userDic safeObjectForKey:@"openid"] forKey:KEY_openId];
    [userDef setObject:[userDic safeObjectForKey:@"nickName"] forKey:KEY_nickName];
    [userDef synchronize];
}

- (void)forgetClick:(id)sender
{
//    NXForgetVC *forgetVC = [[NXForgetVC alloc] init];
//    [self.navigationController pushViewController:forgetVC animated:YES];
}
#pragma mark - 懒加载属性 -
- (TPKeyboardAvoidingScrollView *)myScrollView{
    if (!_myScrollView) {
        _myScrollView = [[TPKeyboardAvoidingScrollView alloc]init];
        _myScrollView.backgroundColor = [UIColor whiteColor];
        _myScrollView.frame = self.view.bounds;
    }
    return _myScrollView;
}
- (UIView *)loginBgView
{
    if (!_loginBgView) {
        _loginBgView = [[UIView alloc] init];
        _loginBgView.backgroundColor = [UIColor whiteColor];
        [self setControlView:_loginBgView borderWidth:1.5 borderColor:[UIColor lightGrayColor] cornerRadius:5];
    }
    return _loginBgView;
}
- (UIView *)passwordBgView
{
    if (!_passwordBgView) {
        _passwordBgView = [[UIView alloc] init];
        _passwordBgView.backgroundColor = [UIColor whiteColor];
        [self setControlView:_passwordBgView borderWidth:1.5 borderColor:[UIColor lightGrayColor] cornerRadius:5];
    }
    return _passwordBgView;
}
- (UIImageView *)loginImageView
{
    if (!_loginImageView) {
        _loginImageView = [[UIImageView alloc] init];
    }
    return _loginImageView;
}
- (UIImageView *)passwordImageView
{
    if (!_passwordImageView) {
        _passwordImageView = [[UIImageView alloc] init];
    }
    return _passwordImageView;
}
- (UITextField *)loginNameField
{
    if (!_loginNameField) {
        _loginNameField = [[UITextField alloc] init];
        _loginNameField.keyboardType = UIKeyboardTypeDefault;
        _loginNameField.clearButtonMode = YES;
        _loginNameField.placeholder = @"请输入用户名";
        _loginNameField.font = [UIFont systemFontOfSize:14];
        _loginNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return _loginNameField;
}
- (UITextField *)passwordField
{
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] init];
        _passwordField.secureTextEntry = YES;
        _passwordField.keyboardType = UIKeyboardTypeDefault;
        _passwordField.font = [UIFont systemFontOfSize:14];
        _passwordField.clearButtonMode = YES;
        _passwordField.placeholder = @"请输入密码";
    }
    return _passwordField;
}
- (UIButton *)loginInBtn
{
    if (!_loginInBtn) {
        _loginInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginInBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginInBtn setBackgroundImage:[UIImage imageNamed:@"login-btn-nomal"] forState:UIControlStateNormal];
        [_loginInBtn setBackgroundImage:[UIImage imageNamed:@"login-btn-selected"] forState:UIControlStateSelected];
        [_loginInBtn setBackgroundColor:[UIColor blueColor]];
        [_loginInBtn setTintColor:[UIColor whiteColor]];
        _loginInBtn.layer.cornerRadius = 10;
        _loginInBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_loginInBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginInBtn;
}
- (UIButton *)forgetBtn
{
    if (!_forgetBtn) {
        _forgetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitleColor:BWColor(36, 109, 188, 1) forState:UIControlStateNormal];
        [_forgetBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetBtn addTarget:self action:@selector(forgetClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _forgetBtn;
}
- (CustomPrivacyView *)customView
{
    DefineWeakSelf;
    if (!_customView) {
        _customView = [[CustomPrivacyView alloc] init];
        
        __block NSString *title, *url;
        _customView.clickAction = ^(NSInteger tag) {
            if (tag == 6667) {
                //隐私
                title = @"隐私政策";
                url = PrivacyURL;
            }else{
                //用户
                title = @"用户协议";
                url = UserProURL;
            }
            //用户
            [weakSelf.privacyPageCtrl loadPrivacyHtmlWithAppName:title andHtml:url isHiddenBottomView:YES];
            [weakSelf.privacyPageCtrl createLeftBackBtnWithImageName:@"menu-back.png"];
            [weakSelf.navigationController pushViewController:weakSelf.privacyPageCtrl animated:YES];
        };
    }
    return _customView;
}
- (PrivacyPageController *)privacyPageCtrl
{
    if (!_privacyPageCtrl) {
        _privacyPageCtrl = [[PrivacyPageController alloc] init];
    }
    return _privacyPageCtrl;
}




@end
