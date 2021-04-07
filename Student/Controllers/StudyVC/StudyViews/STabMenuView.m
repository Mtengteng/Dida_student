//
//  STabMenuView.m
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import "STabMenuView.h"

@interface STabMenuView()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation STabMenuView

- (id)initWithTitle:(NSArray *)titleArray
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.titleArray = titleArray;
        
        UIView *contentView = [[UIView alloc] init];
        [self addSubview:contentView];
        [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.mas_equalTo(LAdaptation_x(300));
            make.height.equalTo(self);
        }];
        
        [contentView addSubview:self.leftBtn];
        [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(contentView);
            make.left.equalTo(contentView);
            make.width.mas_equalTo(LAdaptation_x(150));
            make.height.mas_equalTo(LAdaptation_y(40));
        }];
        
        [contentView addSubview:self.rightBtn];
        [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(contentView);
            make.left.equalTo(self.leftBtn.mas_right);
            make.width.mas_equalTo(LAdaptation_x(150));
            make.height.mas_equalTo(LAdaptation_y(40));
        }];
        
       
    }
        
    return self;
}

- (void)clickAction:(id)sender
{
    UIButton *selectButton = (UIButton *)sender;
    
    if (selectButton.tag == 1000) {
        [self.leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.leftBtn.backgroundColor = [UIColor blueColor];

        [self.rightBtn setTitleColor:BWColor(92.0, 92.0, 92.0, 1.0) forState:UIControlStateNormal];
        self.rightBtn.backgroundColor = [UIColor lightGrayColor];

        

    }else{
        [self.leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.leftBtn.backgroundColor = [UIColor lightGrayColor];

        [self.rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.rightBtn.backgroundColor = [UIColor blueColor];


    }
    
    self.selectBlock(_titleArray[selectButton.tag - 1000]);
}

#pragma mark - LazyLoad -
- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.tag = 1000;
        [_leftBtn setTitle:[self.titleArray safeObjectAtIndex:0] forState:UIControlStateNormal];
        [_leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftBtn.backgroundColor = [UIColor blueColor];
        [_leftBtn.titleLabel setFont: [UIFont boldSystemFontOfSize:20.0]];
        [_leftBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn
{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.tag = 1001;
        [_rightBtn setTitle:[self.titleArray safeObjectAtIndex:1] forState:UIControlStateNormal];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rightBtn.backgroundColor = [UIColor lightGrayColor];
        [_rightBtn.titleLabel setFont: [UIFont systemFontOfSize:20.0]];
        [_rightBtn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
@end
