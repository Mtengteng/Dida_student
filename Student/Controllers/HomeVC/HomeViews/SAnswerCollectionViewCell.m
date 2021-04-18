//
//  SHomeCollectionViewCell.m
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "SAnswerCollectionViewCell.h"
#import "SBookImageView.h"

@interface SAnswerCollectionViewCell()
@property (nonatomic, strong) SBookImageView *imageView;
@property (nonatomic, strong) UILabel *bookTitleLabel;

@end

@implementation SAnswerCollectionViewCell


- (void)layoutSubviews
{
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(LAdaptation_y(176));
    }];
    
    [self.contentView addSubview:self.bookTitleLabel];
    [self.bookTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(LAdaptation_y(15));
        make.left.equalTo(self.imageView);
        make.width.equalTo(self.imageView);
    }];
}

- (void)setupCellWithModel:(SBookInfo *)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.bookPic]];
    self.bookTitleLabel.text = model.bookName;
}

#pragma mark - LazyLoad -
- (SBookImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[SBookImageView alloc] init];
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}
- (UILabel *)bookTitleLabel
{
    if (!_bookTitleLabel) {
        _bookTitleLabel = [[UILabel alloc] init];
        _bookTitleLabel.font = [UIFont systemFontOfSize:14.0];
        _bookTitleLabel.textColor = BWColor(44, 48, 81, 1);
        _bookTitleLabel.textAlignment = NSTextAlignmentLeft;
        _bookTitleLabel.numberOfLines = 2;
        _bookTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _bookTitleLabel;
}

@end
