//
//  SHomeSelectView.m
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "SelectSubView.h"
#import "SCDictModel.h"

@interface SelectSubView()
@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) UIView *blueLineView;

@end

@implementation SelectSubView

- (instancetype)initWithItemArray:(NSArray *)itemList
{
    if (self = [super init]) {
        
        self.itemList = itemList;

        UIButton *firstBtn = nil;
        for (NSInteger i = 0; i < itemList.count; i++) {
            
            SCDictInfoModel *model = [itemList safeObjectAtIndex:i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i+1000;
            [button setTitle:model.dictValue forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:18.0]];
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
        
        if (self.selectSubBlock) {
            self.selectSubBlock([itemList safeObjectAtIndex:0],0);
        }
        
    }
    return self;
}
- (void)click:(UIButton *)button
{

    [self changeSelectStateWithBtn:button];
    
    if (self.selectSubBlock) {
        self.selectSubBlock([self.itemList safeObjectAtIndex:button.tag-1000],button.tag-1000);
    }

}

- (void)setFirstSub:(void (^)(SCDictInfoModel * _Nonnull, NSInteger))selectFirst
{
    UIButton *firstBtn = (UIButton *)[self viewWithTag:1000];
    [self changeSelectStateWithBtn:firstBtn];
    selectFirst(self.itemList[0],0);
}
- (void)changeSelectStateWithBtn:(UIButton *)button
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
