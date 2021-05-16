//
//  SMenuView.m
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import "SMenuView.h"
#import "SCDictModel.h"


@interface SMenuView()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL isHidden;
}
@property (nonatomic, strong) UIView *superView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *downArrawImageView;
@end

@implementation SMenuView

- (id)initContentArray:(NSArray *)dataArray
        withSuperView:(UIView *)superView
{
    if (self = [super init]) {
        
        self.dataArray = dataArray;
        self.superView = superView;
        [self createUI];
        
    }
    return self;
}
- (void)createUI
{
    [self addSubview:self.titleView];
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
//    SMenuItem *firstItem = [self.dataArray safeObjectAtIndex:0];
//    self.titleLabel.text = firstItem.itemName;
    [self.titleView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleView);
        make.left.equalTo(self.titleView);
        make.width.mas_equalTo(LAdaptation_x(40));
        make.height.equalTo(self.titleView);
    }];
    
    UIImage *downImg = [UIImage imageNamed:@"down_arrow.png"];

    [self.titleView addSubview:self.downArrawImageView];
    [self.downArrawImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleView);
        make.left.equalTo(self.titleLabel.mas_right);
        make.width.mas_equalTo(downImg.size.width);
        make.height.mas_equalTo(downImg.size.height);
    }];
    
    [self.superView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superView);
        make.left.equalTo(self.superView).offset(LAdaptation_x(24));
        make.width.mas_equalTo(LAdaptation_x(60));
        make.height.mas_equalTo(0);
    }];
}

- (void)clickAction:(UITapGestureRecognizer *)tap
{
    DefineWeakSelf;
    if (!isHidden) {
        
        [UIView animateWithDuration:0.25 animations:^{

            [weakSelf.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.superView);
                make.left.equalTo(self.superView).offset(LAdaptation_x(24));
                make.width.mas_equalTo(LAdaptation_x(60));
                make.height.mas_equalTo(weakSelf.dataArray.count *44);
            }];
            weakSelf.downArrawImageView.transform = CGAffineTransformRotate(weakSelf.downArrawImageView.transform, M_PI);
            
            [weakSelf.superView layoutIfNeeded];

        }];
        
    }else{
        
        [UIView animateWithDuration:0.25 animations:^{

            [weakSelf.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.superView);
                make.left.equalTo(self.superView).offset(LAdaptation_x(24));
                make.width.mas_equalTo(LAdaptation_x(60));
                make.height.mas_equalTo(0);
            }];
            weakSelf.downArrawImageView.transform = CGAffineTransformIdentity;

            [weakSelf.superView layoutIfNeeded];

        }];
    }
    isHidden = !isHidden;
}

#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    for (id v in cell.contentView.subviews)
        [v removeFromSuperview];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SCDictInfoModel *item = [self.dataArray safeObjectAtIndex:indexPath.row];
    cell.textLabel.text = item.dictValue;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}
#pragma mark - UITableViewDelegate -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SCDictInfoModel *item = [self.dataArray safeObjectAtIndex:indexPath.row];
    if (self.select) {
        self.select(item);
    }
    self.titleLabel.text = item.dictValue;
    [self clickAction:nil];
}
#pragma mark - LazyLoad -
- (UIView *)titleView
{
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor whiteColor];
        _titleView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction:)];
        [_titleView addGestureRecognizer:tap];
    }
    return _titleView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textColor = BWColor(66.0, 66.0, 66.0, 1.0);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIImageView *)downArrawImageView
{
    if (!_downArrawImageView) {
        _downArrawImageView = [[UIImageView alloc] init];
        [_downArrawImageView setImage:[UIImage imageNamed:@"down_arrow.png"]];
        _downArrawImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _downArrawImageView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
@end
