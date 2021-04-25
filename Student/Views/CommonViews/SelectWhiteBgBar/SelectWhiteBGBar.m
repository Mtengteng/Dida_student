//
//  SelectWhiteBGBar.m
//  Student
//
//  Created by 马腾 on 2021/4/25.
//

#import "SelectWhiteBGBar.h"

@interface SelectWhiteBGBar()
@property (nonatomic, strong) UIView *selectBarView;
@property (nonatomic, strong) UIView *whiteView;
@property (nonatomic, strong) NSArray *itemArray;


@end

@implementation SelectWhiteBGBar

- (instancetype)initWithItemArray:(NSArray *)itemArray

{
    if (self = [super init]) {
        
        self.itemArray = itemArray;
        
        [self addSubview:self.selectBarView];
        [self.selectBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(LAdaptation_x(80)*self.itemArray.count);
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
    }
    return self;
}
- (void)clickAction:(UIButton *)button
{
    NSLog(@"curveIndex = %ld",button.tag);
    
    if (self.selectWhiteBarBlock) {
        self.selectWhiteBarBlock(button.tag == 0 ? @"试卷":@"教辅");
    }
    
    for (UIView *contentView in self.selectBarView.subviews) {
        if ([contentView isKindOfClass:[UIButton class]]) {
            UIButton *tempBtn = (UIButton *)contentView;
            if (tempBtn.tag == button.tag) {
                [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                DefineWeakSelf;
                [UIView animateWithDuration:0.25 animations:^{
                    [weakSelf.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(weakSelf.selectBarView);
                        make.left.mas_equalTo(button.tag*LAdaptation_x(80));
                        make.width.mas_equalTo(LAdaptation_x(80));
                        make.height.mas_equalTo(LAdaptation_y(30));
                    }];
                    
                    [weakSelf.superview layoutIfNeeded];
                }];

            }else{
                [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            
            

        }
    }
}

#pragma mark - LazyLoad -
- (UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (UIView *)selectBarView
{
    if (!_selectBarView) {
        _selectBarView = [[UIView alloc] init];
        _selectBarView.backgroundColor = [UIColor lightGrayColor];

        for (NSInteger i = 0; i < self.itemArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            if (i == 0) {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            [button setTitle:[self.itemArray safeObjectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [_selectBarView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_selectBarView);
                make.left.mas_equalTo(i*LAdaptation_x(80));
                make.width.mas_equalTo(LAdaptation_x(80));
                make.height.mas_equalTo(LAdaptation_y(30));
            }];
        }
        
        [_selectBarView addSubview:self.whiteView];
        [_selectBarView sendSubviewToBack:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_selectBarView);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(LAdaptation_x(80));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
    }

    
    return _selectBarView;
}
@end
