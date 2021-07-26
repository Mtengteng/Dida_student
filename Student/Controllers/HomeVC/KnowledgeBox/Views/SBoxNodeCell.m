//
//  SBoxGroupCell.m
//  Student
//
//  Created by mateng on 2021/7/22.
//

#import "SBoxNodeCell.h"

@interface SBoxNodeCell()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SBoxNodeCell

- (void)setupCellWithModel:(id)model
{
    
}

#pragma mark - LazyLoad -
- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
    }
    return _bgView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _titleLabel;
}
@end
