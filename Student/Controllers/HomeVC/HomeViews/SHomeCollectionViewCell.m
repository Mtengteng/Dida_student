//
//  SHomeCollectionViewCell.m
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import "SHomeCollectionViewCell.h"

@interface SHomeCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *bookTitleLabel;

@end

@implementation SHomeCollectionViewCell


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
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.cornerRadius = 10;
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.shadowOffset = CGSizeMake(5,5);
        _imageView.layer.shadowOpacity = 0.8;
        _imageView.layer.shadowRadius = 4;
        _imageView.layer.borderWidth = 1;
        _imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
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
