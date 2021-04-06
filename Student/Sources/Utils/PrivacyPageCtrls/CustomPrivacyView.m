//
//  CustomPrivacyView.m
//  webViewSearch
//
//  Created by 马腾 on 2019/9/4.
//  Copyright © 2019 mateng. All rights reserved.
//

#import "CustomPrivacyView.h"


@interface CustomPrivacyView()
@property (nonatomic, strong) UIButton *selectBtn;

@end

@implementation CustomPrivacyView

- (instancetype)init
{
    if (self = [super init]) {
        
        self.userInteractionEnabled = YES;
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateNormal];
        [_selectBtn addTarget:self action:@selector(changeSelectState:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_selectBtn];
        
        [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self);
            make.width.mas_equalTo(PAdaptation_x(15));
            make.height.mas_equalTo(PAaptation_y(15));
        }];
        
        UILabel *desLabel = [[UILabel alloc] init];
        desLabel.text = @"  已阅读并同意";
        desLabel.font = [UIFont systemFontOfSize:12.0];
        desLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        [self addSubview:desLabel];
        
        [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(_selectBtn.mas_right);
            make.height.equalTo(self);
        }];
        
        UIButton *privacyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [privacyBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [privacyBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [privacyBtn addTarget:self action:@selector(privacyAction:) forControlEvents:UIControlEventTouchUpInside];
        [privacyBtn setTitleColor:[UIColor colorWithRed:73.0/255.0 green:161.0/255.0 blue:232.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        privacyBtn.tag = 6666;
        [privacyBtn setTitle:@"《用户协议》" forState:UIControlStateNormal];
        [self addSubview:privacyBtn];

        [privacyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(desLabel.mas_right);
            make.height.equalTo(self);
        }];

        UILabel *andLabel = [[UILabel alloc] init];
        andLabel.text = @"和";
        andLabel.font = [UIFont systemFontOfSize:12.0];
        andLabel.textColor = [UIColor colorWithRed:158.0/255.0 green:158.0/255.0 blue:158.0/255.0 alpha:1.0];
        [self addSubview:andLabel];

        [andLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(privacyBtn.mas_right);
            make.height.equalTo(self);
        }];
        
        UIButton *userBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [userBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [userBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [userBtn addTarget:self action:@selector(privacyAction:) forControlEvents:UIControlEventTouchUpInside];
        [userBtn setTitleColor:[UIColor colorWithRed:73.0/255.0 green:161.0/255.0 blue:232.0/255.0 alpha:1.0] forState:UIControlStateNormal];
        userBtn.tag = 6667;
        [userBtn setTitle:@"《隐私政策》" forState:UIControlStateNormal];
        [self addSubview:userBtn];
        
        [userBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(andLabel.mas_right);
            make.height.equalTo(self);
        }];
        
        _selectState = YES;
        
    }
    
    return self;
}
- (void)changeSelectState:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        [_selectBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateNormal];

    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"weixuanzhong.png"] forState:UIControlStateNormal];

    }
    _selectState = !_selectState;

    button.selected = !button.selected;
}
- (void)privacyAction:(UIButton *)sender
{
    if (_clickAction) {
        _clickAction(sender.tag);
    }
}
@end
