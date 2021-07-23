//
//  SAMenuBarView.m
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import "SAMenuBarView.h"

@implementation SAMenuBarView

- (instancetype)init
{
    if (self = [super init]) {
        
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"arrow_left"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(LAdaptation_y(5));
        make.left.equalTo(self).offset(LAdaptation_x(20));
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    centerBtn.tag = 1;
    [centerBtn setTitle:@"- 节点内容 -" forState:UIControlStateNormal];
    [centerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [centerBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:centerBtn];
    
    [centerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(LAdaptation_y(5));
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.tag = 0;
    [leftBtn setTitle:@"基础信息" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(centerBtn.mas_left).offset(-LAdaptation_x(20));
        make.centerY.equalTo(self).offset(LAdaptation_y(5));
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.tag = 2;
    [rightBtn setTitle:@"发布确认" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(centerBtn.mas_right).offset(LAdaptation_x(20));
        make.centerY.equalTo(self).offset(LAdaptation_y(5));
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(40);
    }];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:saveBtn];
    
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-LAdaptation_x(20));
        make.centerY.equalTo(self).offset(LAdaptation_y(5));
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(40);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.equalTo(self);
        make.width.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}
- (void)clickAction:(UIButton *)button
{
    NSLog(@"clicked:%@",button.titleLabel.text);
}
- (void)saveAction:(id)sender
{
    if (self.saveBlock) {
        self.saveBlock();
    }
}
- (void)backAction:(id)sender
{
    if (self.backBlock) {
        self.backBlock();
    }
}
@end
