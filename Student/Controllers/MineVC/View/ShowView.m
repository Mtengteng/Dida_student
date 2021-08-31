//
//  ShowView.m
//  Student
//
//  Created by 马腾 on 2021/8/30.
//

#import "ShowView.h"

@interface ShowView()


@end

@implementation ShowView

- (instancetype)init
{
    if (self = [super init]) {
                
        [self addSubview:self.label1];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self.mas_centerX);
            make.height.mas_equalTo(LAdaptation_y(40));
        }];
        
        [self addSubview:self.numberLabel1];
        [self.numberLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label1.mas_bottom);
            make.left.equalTo(self.label1);
            make.width.equalTo(self.label1);
            make.height.mas_equalTo(LAdaptation_y(40));

        }];
        
        [self addSubview:self.label2];
        [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self.label1.mas_right);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(LAdaptation_y(40));

        }];
        
        [self addSubview:self.numberLabel2];
        [self.numberLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.label2.mas_bottom);
            make.left.equalTo(self.label2);
            make.width.equalTo(self.label2);
            make.height.mas_equalTo(LAdaptation_y(40));

        }];
        
    }
    return self;
}



#pragma mark - LazyLoad -
- (UILabel *)label1
{
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.font = [UIFont systemFontOfSize:14];
        _label1.textAlignment = NSTextAlignmentCenter;
    }
    return _label1;
}
- (UILabel *)label2
{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.font = [UIFont systemFontOfSize:14];
        _label2.textAlignment = NSTextAlignmentCenter;

    }
    return _label2;
}
- (UILabel *)numberLabel1
{
    if (!_numberLabel1) {
        _numberLabel1 = [[UILabel alloc] init];
        _numberLabel1.font = [UIFont systemFontOfSize:14];
        _numberLabel1.textAlignment = NSTextAlignmentCenter;

    }
    return _numberLabel1;
}
- (UILabel *)numberLabel2
{
    if (!_numberLabel2) {
        _numberLabel2 = [[UILabel alloc] init];
        _numberLabel2.font = [UIFont systemFontOfSize:14];
        _numberLabel2.textAlignment = NSTextAlignmentCenter;

    }
    return _numberLabel2;
}
@end
