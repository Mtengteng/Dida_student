//
//  SContentImageView.m
//  Student
//
//  Created by 马腾 on 2021/5/20.
//

#import "SContentImageView.h"

@interface SContentImageView()
@property (nonatomic, strong) UIButton *deleteBtn;


@end

@implementation SContentImageView

- (instancetype)initWithFrame:(CGRect)frame withTag:(NSInteger)tag
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.deleteBtn.tag = tag;
        [self.deleteBtn setFrame:CGRectMake(frame.size.width - LAdaptation_x(30), 0, LAdaptation_x(30), LAdaptation_y(30))];
        [self addSubview:self.deleteBtn];
        
    }
    return self;
}

- (void)deleteAction:(UIButton *)button
{
    if (self.deleteBlock) {
        self.deleteBlock(button.tag);
    }
}
#pragma mark - LazyLoad -
- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

@end
