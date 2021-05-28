//
//  SAddSelectView.m
//  Student
//
//  Created by 马腾 on 2021/5/21.
//

#import "SAddSelectView.h"

@interface SAddSelectView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation SAddSelectView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self.titleLabel setFrame:CGRectMake(LAdaptation_x(20), 0, LAdaptation_x(60), frame.size.height)];
        [self addSubview:self.titleLabel];
        
        [self.scrollView setFrame:CGRectMake(LAdaptation_x(90), 0, frame.size.width - LAdaptation_x(90), frame.size.height)];
        [self addSubview:self.scrollView];
        
    }
    return self;
}
- (void)reloadData
{
    for (NSInteger i = 0; i < self.itemArray.count; i++) {
        NSString *name = [self.itemArray safeObjectAtIndex:i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i+1000;
        [button setTitle:name forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:CGRectMake(LAdaptation_x(10)+i*LAdaptation_x(90), self.bounds.size.height/2- LAdaptation_y(40)/2, LAdaptation_x(80), LAdaptation_y(40))];
        [self.scrollView addSubview:button];
    }
}
- (void)clickAction:(UIButton *)button
{
    
}

#pragma mark - LazyLoad -
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _titleLabel;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}
@end
