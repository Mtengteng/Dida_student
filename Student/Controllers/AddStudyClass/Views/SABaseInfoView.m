//
//  SABaseInfoView.m
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import "SABaseInfoView.h"

@interface SABaseInfoView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *publicLabel;
@property (nonatomic, strong) UILabel *gradeLabel;

@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, assign) BOOL isPublish;
@property (nonatomic, strong) NSArray *gradeArray;
@property (nonatomic, strong) NSString *selectGrade;
@property (nonatomic, strong) UIButton *yesBtn;
@property (nonatomic, strong) UIButton *noBtn;
@property (nonatomic, strong) UIButton *nextBtn;

@end

@implementation SABaseInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(LAdaptation_y(60));
            make.left.equalTo(self).offset(LAdaptation_x(40));
        }];
        
        [self addSubview:self.titleField];
        [self.titleField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel);
            make.left.equalTo(self.titleLabel.mas_right).offset(LAdaptation_x(30));
        }];
        
        [self addSubview:self.publicLabel];
        [self.publicLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(LAdaptation_y(30));
            make.left.equalTo(self.titleLabel);
            make.width.mas_equalTo(LAdaptation_x(50));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
        self.yesBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.yesBtn.tag = 1000;
        [self.yesBtn setTitle:@"是" forState:UIControlStateNormal];
        [self.yesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.yesBtn addTarget:self action:@selector(clickPublishAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.yesBtn];
        
        [self.yesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.publicLabel);
            make.left.equalTo(self.publicLabel.mas_right).offset(LAdaptation_x(10));
            make.width.mas_equalTo(LAdaptation_x(40));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
        self.noBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.noBtn.tag = 1001;
        [self.noBtn setTitle:@"否" forState:UIControlStateNormal];
        [self.noBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.noBtn addTarget:self action:@selector(clickPublishAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.noBtn];
        
        [self.noBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.publicLabel);
            make.left.equalTo(self.yesBtn.mas_right).offset(LAdaptation_x(10));
            make.width.mas_equalTo(LAdaptation_x(40));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
        [self addSubview:self.gradeLabel];
        [self.gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.publicLabel.mas_bottom).offset(LAdaptation_y(30));
            make.left.equalTo(self.titleLabel);
            make.width.mas_equalTo(LAdaptation_x(50));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
        self.gradeArray = @[@"数学",@"物理"];
        for (NSInteger i = 0; i < self.gradeArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
            button.tag = 2000+i;
            [button setTitle:self.gradeArray[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickGradeAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.gradeLabel);
                make.left.mas_offset(LAdaptation_x(80)+ LAdaptation_x(50) * i + LAdaptation_x(10));
                make.width.mas_equalTo(LAdaptation_x(40));
                make.height.mas_equalTo(LAdaptation_y(30));
            }];
        }
        
        [self addSubview:self.nextBtn];
        [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).offset(-LAdaptation_y(80));
            make.width.mas_equalTo(LAdaptation_x(120));
            make.height.mas_equalTo(LAdaptation_y(44));
        }];
        
        
    }
    return self;
}
- (void)clickPublishAction:(UIButton *)button
{
    if (button.tag == 1000) {
        self.isPublish = YES;
        [self.yesBtn setTitleColor:BWColor(98, 166, 248, 1.0) forState:UIControlStateNormal];
        [self.noBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

    }else{
        self.isPublish = NO;
        [self.noBtn setTitleColor:BWColor(98, 166, 248, 1.0) forState:UIControlStateNormal];
        [self.yesBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }

}
- (void)clickGradeAction:(UIButton *)button
{
    
    self.selectGrade = [self.gradeArray safeObjectAtIndex:button.tag - 2000];
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *subBtn = (UIButton *)view;
            if (button.tag == subBtn.tag) {
                [button setTitleColor:BWColor(98, 166, 248, 1.0) forState:UIControlStateNormal];
            }else{
                [subBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

            }
        }
    }
}
- (void)nextAction:(id)sender
{
    if (self.titleField.text.length == 0 || self.selectGrade.length == 0) {
        [MBProgressHUD showMessag:@"请输入内容" toView:self hudModel:MBProgressHUDModeText hide:YES];
        return;
    }
    if (self.nextBlock) {
        self.nextBlock(self.titleField.text, self.isPublish, self.selectGrade);
    }
}

#pragma mark - LazyLoad -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"学习组名称";
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = [UIColor lightGrayColor];
    }
    return _titleLabel;
}
- (UITextField *)titleField
{
    if (!_titleField) {
        _titleField = [[UITextField alloc] init];
        _titleField.placeholder = @"请输入名称";
        _titleField.textColor = [UIColor blackColor];
    }
    return _titleField;
}
- (UILabel *)publicLabel
{
    if (!_publicLabel) {
        _publicLabel = [[UILabel alloc] init];
        _publicLabel.text = @"公开";
        _publicLabel.font = [UIFont systemFontOfSize:16.0];
        _publicLabel.textColor = [UIColor lightGrayColor];
    }
    return _publicLabel;
}
- (UILabel *)gradeLabel
{
    if (!_gradeLabel) {
        _gradeLabel = [[UILabel alloc] init];
        _gradeLabel.text = @"学科";
        _gradeLabel.font = [UIFont systemFontOfSize:16.0];
        _gradeLabel.textColor = [UIColor lightGrayColor];
    }
    return _gradeLabel;
}
- (UIButton *)nextBtn
{
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:[UIColor redColor]];
        [_nextBtn addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}
@end
