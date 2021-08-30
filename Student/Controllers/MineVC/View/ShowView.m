//
//  ShowView.m
//  Student
//
//  Created by 马腾 on 2021/8/30.
//

#import "ShowView.h"

@interface ShowView()
@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *numberLabel1;
@property (nonatomic, strong) UILabel *numberLabel2;

@end

@implementation ShowView

- (instancetype)init
{
    if (self = [super init]) {
                
        [self addSubview:self.label1];
        [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(LAdaptation_y(10));
            make.left.equalTo(self);
            make.right.equalTo(self.mas_centerX);
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
    }
    return _label1;
}
- (UILabel *)label2
{
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.font = [UIFont systemFontOfSize:14];
    }
    return _label2;
}
- (UILabel *)numberLabel1
{
    if (!_numberLabel1) {
        _numberLabel1 = [[UILabel alloc] init];
        _numberLabel1.font = [UIFont systemFontOfSize:14];
    }
    return _numberLabel1;
}
- (UILabel *)numberLabel2
{
    if (!_numberLabel2) {
        _numberLabel2 = [[UILabel alloc] init];
        _numberLabel2.font = [UIFont systemFontOfSize:14];
    }
    return _numberLabel2;
}
@end
