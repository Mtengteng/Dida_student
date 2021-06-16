//
//  SAddTestVC.m
//  Student
//
//  Created by 马腾 on 2021/5/18.
//

#import "SAddTestVC.h"
#import "SAddImageView.h"
#import "SMoreSelectView.h"
#import "CFDropDownMenuView.h"
#import "CFMacro.h"
#import "UIView+CFFrame.h"

@interface SAddTestVC ()
@property (nonatomic, strong) UILabel *addLabel;
@property (nonatomic, strong) SAddImageView *addImageView;

@property (nonatomic, strong) UILabel *ansLabel;
@property (nonatomic, strong) SAddImageView *ansImageView;
@property (nonatomic, strong) CFDropDownMenuView *dropDownMenuView;



@end

@implementation SAddTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加试卷";
    
    [self createUI];
}
- (void)createUI
{
    DefineWeakSelf;
    [self createLeftBackBtn:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self.view addSubview:self.addImageView];
    
    [self.view addSubview:self.addLabel];
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addImageView);
        make.left.equalTo(self.view).offset(LAdaptation_y(20));
        make.width.mas_equalTo(LAdaptation_x(60));
        make.height.mas_equalTo(LAdaptation_y(30));
    }];
    
    [self.view addSubview:self.ansImageView];
    
    [self.view addSubview:self.ansLabel];
    [self.ansLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.ansImageView);
        make.left.equalTo(self.view).offset(LAdaptation_y(20));
        make.width.mas_equalTo(LAdaptation_x(60));
        make.height.mas_equalTo(LAdaptation_y(30));
    }];
    
    UILabel *yearLabel = [[UILabel alloc] init];
    yearLabel.text = @"学年";
    yearLabel.font = [UIFont systemFontOfSize:14.0];
    [self.view addSubview:yearLabel];
    
    [yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ansImageView.mas_bottom).offset(LAdaptation_y(40));
        make.left.equalTo(self.ansLabel);
        make.height.mas_equalTo(LAdaptation_y(30));
    }];
    
    SMoreSelectView *yearView = [[SMoreSelectView alloc] initWithFrame:CGRectMake(LAdaptation_x(50), LAdaptation_y(275), self.view.bounds.size.width - LAdaptation_x(50), LAdaptation_y(50)) WithArray:@[@"2021-2022",@"2020-2021",@"2019-2020",@"2018-2019"]];
    [self.view addSubview:yearView];

    
    
}


#pragma mark - LazyLoad -
- (UILabel *)addLabel
{
    if (!_addLabel) {
        _addLabel = [[UILabel alloc] init];
        _addLabel.text = @"试卷内容";
        _addLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _addLabel;
}
- (SAddImageView *)addImageView
{
    if (!_addImageView) {
        _addImageView = [[SAddImageView alloc] initWithFrame:CGRectMake(LAdaptation_x(90), LAdaptation_y(40), SCREEN_WIDTH, LAdaptation_y(100)) withSuperVC:self];
    }
    return _addImageView;
}
- (UILabel *)ansLabel
{
    if (!_ansLabel) {
        _ansLabel = [[UILabel alloc] init];
        _ansLabel.text = @"答题卡";
        _ansLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _ansLabel;
}
- (SAddImageView *)ansImageView
{
    if (!_ansImageView) {
        _ansImageView = [[SAddImageView alloc] initWithFrame:CGRectMake(LAdaptation_x(90), LAdaptation_y(140), SCREEN_WIDTH, LAdaptation_y(100)) withSuperVC:self];
    }
    return _ansImageView;
}
@end
