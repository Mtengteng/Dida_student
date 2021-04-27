//
//  SCurrentStudyCell.m
//  Student
//
//  Created by 马腾 on 2021/4/25.
//

#import "SCAssistantCell.h"
#import "SBookImageView.h"

@interface SCAssistantCell()
@property (nonatomic, strong) SBookImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *createDate;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *studyLabel;

@end

@implementation SCAssistantCell

- (void)layoutSubviews
{
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(LAdaptation_x(24));
        make.width.mas_equalTo(LAdaptation_x(100));
        make.height.mas_equalTo(LAdaptation_y(140));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView);
        make.left.equalTo(self.imageView.mas_right).offset(LAdaptation_x(10));
        make.right.equalTo(self.contentView.mas_right).offset(-LAdaptation_x(24));
    }];
    
    [self.contentView addSubview:self.createDate];
    [self.createDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(LAdaptation_y(5));
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView.mas_right).offset(-LAdaptation_x(24));
    }];
//
    [self.contentView addSubview:self.progressLabel];
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.createDate.mas_bottom).offset(LAdaptation_y(10));
        make.left.equalTo(self.createDate);
        make.width.mas_equalTo(LAdaptation_x(100));
    }];
    
    [self.contentView addSubview:self.studyLabel];
    [self.studyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-LAdaptation_y(20));
        make.right.equalTo(self.contentView.mas_right).offset(-LAdaptation_x(24));
        make.width.mas_equalTo(LAdaptation_x(100));
        make.height.mas_equalTo(LAdaptation_y(40));
    }];
    
    
}
- (void)setupCellWithModel:(id)model
{
    self.titleLabel.text = @"语文";
    self.createDate.text = @"2021.4.27";
    self.progressLabel.text = @"12%";
    self.studyLabel.text = @"去学习";
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"https://hello2020edu.oss-cn-beijing.aliyuncs.com/images/shijuan.png"]];
}


#pragma mark - LazyLoad -
- (SBookImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[SBookImageView alloc] init];
    }
    return _imageView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLabel;
}
- (UILabel *)createDate
{
    if (!_createDate) {
        _createDate = [[UILabel alloc] init];
        _createDate.font = [UIFont boldSystemFontOfSize:12.0];
    }
    return _createDate;
}
- (UILabel *)progressLabel
{
    if (!_progressLabel) {
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    return _progressLabel;
}
- (UILabel *)studyLabel
{
    if (!_studyLabel) {
        _studyLabel = [[UILabel alloc] init];
        _studyLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _studyLabel.textAlignment = NSTextAlignmentCenter;
        _studyLabel.backgroundColor = [UIColor blueColor];
        _studyLabel.textColor = [UIColor whiteColor];
    }
    return _studyLabel;
}

@end
