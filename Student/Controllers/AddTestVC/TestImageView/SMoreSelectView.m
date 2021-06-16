//
//  SMoreSelectView.m
//  Student
//
//  Created by 马腾 on 2021/6/16.
//

#import "SMoreSelectView.h"

@interface SMoreSelectView()
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) NSMutableArray *btnList;

@end

@implementation SMoreSelectView

- (instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)contentArray
{
    if (self = [super initWithFrame:frame]) {
        
        self.contentArray = contentArray;
        
        for (NSInteger i = 0; i < contentArray.count; i++) {
            
//            CGSize size = [BWTools SizeWithString:contentArray[i] withFont:[UIFont systemFontOfSize:14.0]];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            [button setFrame:CGRectMake(LAdaptation_x(15)+i*(LAdaptation_x(100)+LAdaptation_x(20)), 0, (LAdaptation_x(100)+LAdaptation_x(10)), LAdaptation_y(40))];
            [button setTitle:[contentArray safeObjectAtIndex:i] forState:UIControlStateNormal];
            [button.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [self addSubview:button];
            
            [self.btnList addObject:button];
            
        }
        
    }
    return self;
}
- (void)clickAction:(UIButton *)selButton
{
    for (UIButton *button in self.btnList) {
        if (button.tag == selButton.tag) {
            [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];

        }
    }
    if (self.selectBlock) {
        self.selectBlock([self.contentArray safeObjectAtIndex:selButton.tag]);
    }
}

#pragma mark - LazyLoad -
- (NSMutableArray *)btnList
{
    if (!_btnList) {
        _btnList = [[NSMutableArray alloc] init];
    }
    return _btnList;
}
@end
