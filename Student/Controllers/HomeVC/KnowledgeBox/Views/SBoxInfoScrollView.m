//
//  SBoxInfoScrollView.m
//  Student
//
//  Created by 马腾 on 2021/7/26.
//

#import "SBoxInfoScrollView.h"
#import "SBoxGroup.h"

@interface SBoxInfoScrollView()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *contentArray;
@end

@implementation SBoxInfoScrollView

- (instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)contentArray
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentArray = contentArray;
        
        [self.scrollView setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:self.scrollView];
        
        for (NSInteger i = 0; i < contentArray.count+10; i++) {
            
            SBoxGroup *group = [contentArray safeObjectAtIndex:i];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button setTitle:group.groupName forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor redColor]];
            [button setFrame:CGRectMake(i *LAdaptation_x(120), self.bounds.size.height/2 - LAdaptation_y(44)/2, LAdaptation_x(100), LAdaptation_y(44))];
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:button];
        }
        
        [self.scrollView setContentSize:CGSizeMake((self.contentArray.count+10) *(LAdaptation_x(120)), 0)];
    }
    return self;
}
- (void)clickAction:(UIButton *)button
{
    if (self.clickBlock) {
        self.clickBlock(self.contentArray[button.tag]);
    }
}

#pragma mark - LazyLoad -
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}
@end
