//
//  SHomeSelectView.m
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "SHomeSelectView.h"

@interface SHomeSelectView()
@property (nonatomic, strong) UIView *blueLineView;

@end

@implementation SHomeSelectView

- (instancetype)initWithItemArray:(NSArray *)itemList
{
    if (self = [super init]) {

        UIButton *firstBtn = nil;
        for (NSInteger i = 0; i < itemList.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button setTitle:[itemList safeObjectAtIndex:i] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:20.0]];
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
            [button setFrame:CGRectMake(i*(LAdaptation_x(40)+LAdaptation_x(48)), LAdaptation_y(44)/2 - LAdaptation_y(20)/2, LAdaptation_x(40), LAdaptation_y(20))];
            if (i == 0) {
                firstBtn = button;
                [button setTitleColor:BWColor(44, 48, 81, 1) forState:UIControlStateNormal];
            }else{
                [button setTitleColor:BWColor(44, 48, 81, 0.4) forState:UIControlStateNormal];
            }
            [self addSubview:button];
        }
        
        [self addSubview:self.blueLineView];
        [self.blueLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(firstBtn);
            make.top.equalTo(firstBtn.mas_bottom).offset(LAdaptation_y(5));
            make.width.mas_equalTo(LAdaptation_x(26));
            make.height.mas_equalTo(LAdaptation_y(6));
        }];
        
        if (self.selectBlock) {
            self.selectBlock(0);
        }
        
    }
    return self;
}
- (void)click:(UIButton *)button
{
    for (UIView *contentView in self.subviews) {
        if ([contentView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)contentView;
            if (btn.tag == button.tag) {
                [btn setTitleColor:BWColor(44, 48, 81, 1) forState:UIControlStateNormal];

            }else{
                [btn setTitleColor:BWColor(44, 48, 81, 0.4) forState:UIControlStateNormal];
            }
        }
    }
    DefineWeakSelf;
    [UIView animateWithDuration:0.25 animations:^{
        
        [weakSelf.blueLineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(button);
            make.top.equalTo(button.mas_bottom).offset(LAdaptation_y(5));
            make.width.mas_equalTo(LAdaptation_x(26));
            make.height.mas_equalTo(LAdaptation_y(6));
        }];
        [weakSelf.superview layoutIfNeeded];
    }];
    
    if (self.selectBlock) {
        self.selectBlock(button.tag);
    }

}

#pragma mark - LazyLoad -
- (UIView *)blueLineView
{
    if (!_blueLineView) {
        _blueLineView = [[UIView alloc] init];
        _blueLineView.backgroundColor = BWColor(58, 98, 255, 1);
    }
    return _blueLineView;
}
@end
