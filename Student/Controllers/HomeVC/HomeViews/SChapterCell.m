//
//  SChapterCell.m
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import "SChapterCell.h"
#import "SChapter.h"
#import "SChapterSection.h"
#import "SectionTableViewCell.h"


@interface SChapterCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *accuracyLabel;
@property (nonatomic, strong) UILabel *accuracyDesLabel;
@property (nonatomic, strong) UILabel *finishedLabel;
@property (nonatomic, strong) UILabel *finishedDesLabel;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *sectionArray;

@end

@implementation SChapterCell

- (void)layoutSubviews
{
    [self.contentView addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.contentView);
        make.width.equalTo(self.contentView);
        make.height.mas_equalTo(LAdaptation_y(100));
    }];
    
    [self.titleView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleView).offset(LAdaptation_y(10));
        make.left.equalTo(_titleView).offset(LAdaptation_x(24));
    }];
    
    [self.titleView addSubview:self.finishedLabel];
    [self.finishedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView).offset(LAdaptation_y(10));
        make.right.equalTo(self.titleView.mas_right).offset(-LAdaptation_x(24));
        make.height.mas_equalTo(LAdaptation_y(40));
    }];
    
    [self.titleView addSubview:self.finishedDesLabel];
    [self.finishedDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finishedLabel.mas_bottom);
        make.centerX.equalTo(self.finishedLabel);
        make.height.mas_equalTo(LAdaptation_y(40));
    }];
    
    [self.titleView addSubview:self.accuracyLabel];
    [self.accuracyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.finishedLabel);
        make.right.equalTo(self.finishedLabel.mas_left).offset(-LAdaptation_x(40));
        make.height.mas_equalTo(LAdaptation_y(40));
    }];
    
    [self.titleView addSubview:self.accuracyDesLabel];
    [self.accuracyDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.accuracyLabel.mas_bottom);
        make.centerX.equalTo(self.accuracyLabel);
        make.height.mas_equalTo(LAdaptation_y(40));
    }];
    
    [self.titleView addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView);
        make.left.equalTo(self.titleView).offset(LAdaptation_x(24));
        make.right.equalTo(self.accuracyLabel.mas_left).offset(-LAdaptation_x(60));
        make.height.mas_equalTo(LAdaptation_y(15));
    }];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView.mas_bottom);
        make.left.equalTo(self.titleView);
        make.width.equalTo(self.titleView);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)setupCellWithModel:(SChapter *)model
{
    self.titleLabel.text = model.chapterName;
    self.accuracyLabel.text = [NSString stringWithFormat:@"%@%%",model.accuracy];
    self.finishedLabel.text = [NSString stringWithFormat:@"%@%%",model.chapterProcess];
}
- (void)loadSectionArray:(NSArray *)array
{
    self.sectionArray = array;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return LAdaptation_y(120);
}
#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sectionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    SectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[SectionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    SChapterSection *section = [self.sectionArray safeObjectAtIndex:indexPath.row];
    [cell setupCellWithModel:section];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SChapterSection *section = [self.sectionArray safeObjectAtIndex:indexPath.row];
    
    if (self.didSelectModelBlock) {
        self.didSelectModelBlock(section);
    }
}
#pragma mark - LazyLoad -
- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor whiteColor];
    }
    return _titleView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20.0];
    }
    return _titleLabel;
}
- (UILabel *)finishedLabel
{
    if (!_finishedLabel) {
        _finishedLabel = [[UILabel alloc] init];
        _finishedLabel.font = [UIFont systemFontOfSize:18.0];
    }
    return _finishedLabel;
}
- (UILabel *)finishedDesLabel
{
    if (!_finishedDesLabel) {
        _finishedDesLabel = [[UILabel alloc] init];
        _finishedDesLabel.font = [UIFont systemFontOfSize:18.0];
        _finishedDesLabel.textColor = [UIColor lightGrayColor];
        _finishedDesLabel.text = @"完成率";
    }
    return _finishedDesLabel;
}
- (UILabel *)accuracyLabel
{
    if (!_accuracyLabel) {
        _accuracyLabel = [[UILabel alloc] init];
        _accuracyLabel.font = [UIFont systemFontOfSize:18.0];
        _accuracyLabel.textColor = [UIColor blueColor];
    }
    return _accuracyLabel;
}
- (UILabel *)accuracyDesLabel
{
    if (!_accuracyDesLabel) {
        _accuracyDesLabel = [[UILabel alloc] init];
        _accuracyDesLabel.font = [UIFont systemFontOfSize:18.0];
        _accuracyDesLabel.textColor = [UIColor blueColor];
        _accuracyDesLabel.text = @"正确率";
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
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
