//
//  SectionTableViewCell.m
//  Student
//
//  Created by 马腾 on 2021/4/19.
//

#import "SectionTableViewCell.h"
#import "SChapterSection.h"

@interface SectionTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *subLabel;
@property (nonatomic, strong) UILabel *subDesLabel;
@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) UILabel *testDesLabel;
@property (nonatomic, strong) UILabel *accuracyLabel;
@property (nonatomic, strong) UILabel *accuracyDesLabel;
@property (nonatomic, strong) UILabel *progressDesLabel;
@property (nonatomic, strong) UILabel *finishedLabel;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation SectionTableViewCell

- (void)layoutSubviews
{
    [self.contentView addSubview:self.progressDesLabel];
    [self.progressDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(LAdaptation_y(20));
        make.right.equalTo(self.contentView.mas_right).offset(-LAdaptation_x(24));
        make.width.mas_equalTo(LAdaptation_x(40));
        make.height.mas_equalTo(LAdaptation_y(20));
    }];
    
    [self.contentView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.progressDesLabel);
        make.right.equalTo(self.progressDesLabel.mas_left).offset(-LAdaptation_x(5));
        make.width.mas_equalTo(LAdaptation_x(100));
        make.height.mas_equalTo(LAdaptation_y(5));
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(LAdaptation_y(20));
        make.left.equalTo(self.contentView).offset(LAdaptation_x(24));
        make.right.equalTo(self.progressView.mas_left).offset(-LAdaptation_x(10));
    }];
    
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(LAdaptation_y(10));
        make.left.equalTo(self.nameLabel);
        make.width.mas_equalTo(LAdaptation_x(400));
        make.height.mas_equalTo(LAdaptation_y(30));
    }];
    
    [bgView addSubview:self.subLabel];
    [bgView addSubview:self.testLabel];
    [bgView addSubview:self.accuracyLabel];

    NSArray *viewsArray = @[self.subLabel,self.testLabel,self.accuracyLabel];
    [viewsArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [viewsArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView);
        make.height.mas_equalTo(LAdaptation_y(30));
    }];
    
    UIView *bgDesView = [[UIView alloc] init];
    bgDesView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:bgDesView];
    
    [bgDesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom);
        make.left.equalTo(self.nameLabel);
        make.width.mas_equalTo(LAdaptation_x(400));
        make.height.mas_equalTo(LAdaptation_y(30));
    }];
    
    [bgDesView addSubview:self.subDesLabel];
    [bgDesView addSubview:self.testDesLabel];
    [bgDesView addSubview:self.accuracyDesLabel];

    NSArray *viewsDesArray = @[self.subDesLabel,self.testDesLabel,self.accuracyDesLabel];
    [viewsDesArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [viewsDesArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_bottom);
        make.height.mas_equalTo(LAdaptation_y(30));
    }];
    
    
    [self.contentView addSubview:self.finishedLabel];
    [self.finishedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(LAdaptation_y(20));
        make.right.equalTo(self.contentView.mas_right).offset(-LAdaptation_x(24));
        make.width.mas_equalTo(LAdaptation_x(60));
        make.height.mas_equalTo(LAdaptation_y(35));
    }];

    
}
- (void)setupCellWithModel:(SChapterSection *)model
{
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@",model.sectionIndex, model.sectionName];

    self.subLabel.text = [NSString stringWithFormat:@"%@/%@",model.finishedModular,model.finishedQuestion];
    self.subDesLabel.text = @"题目";

    self.testLabel.text = [NSString stringWithFormat:@"%@/%@",model.finishedModular,model.finishedQuestion];
    self.testDesLabel.text = @"练习";

    self.accuracyLabel.text = model.accuracy;
    self.accuracyDesLabel.text = @"正确率";
    
    self.progressView.progress = model.secctionProcess.floatValue;
    self.progressDesLabel.text = [NSString stringWithFormat:@"%@%%",model.secctionProcess];
    self.finishedLabel.text = @"去完成";
}

#pragma mark - LazyLoad -
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:18.0];
    }
    return _nameLabel;
}
- (UILabel *)subLabel
{
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] init];
        _subLabel.textColor = [UIColor blackColor];
        _subLabel.font = [UIFont systemFontOfSize:16.0];
        _subLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subLabel;
}
- (UILabel *)subDesLabel
{
    if (!_subDesLabel) {
        _subDesLabel = [[UILabel alloc] init];
        _subDesLabel.textColor = [UIColor blackColor];
        _subDesLabel.font = [UIFont systemFontOfSize:14.0];
        _subDesLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subDesLabel;
}
- (UILabel *)testLabel
{
    if (!_testLabel) {
        _testLabel = [[UILabel alloc] init];
        _testLabel.textColor = [UIColor blackColor];
        _testLabel.font = [UIFont systemFontOfSize:16.0];
        _testLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _testLabel;
}
- (UILabel *)testDesLabel
{
    if (!_testDesLabel) {
        _testDesLabel = [[UILabel alloc] init];
        _testDesLabel.textColor = [UIColor blackColor];
        _testDesLabel.font = [UIFont systemFontOfSize:14.0];
        _testDesLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _testDesLabel;
}
- (UILabel *)accuracyLabel
{
    if (!_accuracyLabel) {
        _accuracyLabel = [[UILabel alloc] init];
        _accuracyLabel.textColor = [UIColor blackColor];
        _accuracyLabel.font = [UIFont systemFontOfSize:16.0];
        _accuracyLabel.textAlignment = NSTextAlignmentCenter;

    }
    return _accuracyLabel;
}
- (UILabel *)accuracyDesLabel
{
    if (!_accuracyDesLabel) {
        _accuracyDesLabel = [[UILabel alloc] init];
        _accuracyDesLabel.textColor = [UIColor blackColor];
        _accuracyDesLabel.font = [UIFont systemFontOfSize:14.0];
        _accuracyDesLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _accuracyDesLabel;
}
- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] init];
    }
    return _progressView;
}
- (UILabel *)progressDesLabel
{
    if (!_progressDesLabel) {
        _progressDesLabel = [[UILabel alloc] init];
        _progressDesLabel.textColor = [UIColor blackColor];
        _progressDesLabel.font = [UIFont boldSystemFontOfSize:14.0];
    }
    return _progressDesLabel;
}
- (UILabel *)finishedLabel
{
    if (!_finishedLabel) {
        _finishedLabel = [[UILabel alloc] init];
        _finishedLabel.textColor = [UIColor whiteColor];
        _finishedLabel.backgroundColor = [UIColor blueColor];
        _finishedLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _finishedLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _finishedLabel;
}
@end
