//
//  StudyCollectionViewCell.m
//  Student
//
//  Created by mateng on 2021/4/18.
//

#import "StudyCollectionViewCell.h"
#import "SBookImageView.h"

@interface StudyCollectionViewCell()
@property (nonatomic, strong) SBookImageView *imageView;
@property (nonatomic, strong) UILabel *studyTitleLabel;
@property (nonatomic, strong) UILabel *studyCountLabel;

@end

@implementation StudyCollectionViewCell

- (void)layoutSubviews
{
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(LAdaptation_y(110));
    }];
    
    [self.contentView addSubview:self.studyTitleLabel];
    [self.studyTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(LAdaptation_y(15));
        make.left.equalTo(self.imageView);
        make.width.equalTo(self.imageView);
    }];
    
    [self.contentView addSubview:self.studyCountLabel];
    [self.studyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.studyTitleLabel.mas_bottom).offset(LAdaptation_y(5));
        make.left.equalTo(self.imageView);
        make.width.equalTo(self.imageView);
    }];
}

- (void)setupCellWithModel:(id)model
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"studyCell_bg"]];
    self.studyTitleLabel.text = @"五年高考";
    self.studyCountLabel.text = @"12门";
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
- (UILabel *)studyTitleLabel
{
    if (!_studyTitleLabel) {
        _studyTitleLabel = [[UILabel alloc] init];
        _studyTitleLabel.font = [UIFont systemFontOfSize:14.0];
        _studyTitleLabel.textColor = BWColor(44, 48, 81, 1);
        _studyTitleLabel.textAlignment = NSTextAlignmentLeft;
        _studyTitleLabel.numberOfLines = 2;
        _studyTitleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _studyTitleLabel;
}
- (UILabel *)studyCountLabel
{
    if (!_studyCountLabel) {
        _studyCountLabel = [[UILabel alloc] init];
        _studyCountLabel.font = [UIFont systemFontOfSize:14.0];
        _studyCountLabel.textColor = BWColor(44, 48, 81, 1);
        _studyCountLabel.textAlignment = NSTextAlignmentLeft;
        _studyCountLabel.numberOfLines = 1;
        _studyCountLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _studyCountLabel;
}
@end
