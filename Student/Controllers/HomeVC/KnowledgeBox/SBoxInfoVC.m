//
//  SBoxInfoVC.m
//  Student
//
//  Created by 马腾 on 2021/7/22.
//

#import "SBoxInfoVC.h"
#import "SBox.h"
#import "SBoxInfoHeaderView.h"
#import "BWKnowledgeBoxGroupReq.h"
#import "BWKnowledgeBoxGroupResp.h"

@interface SBoxInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SBoxInfoHeaderView *headerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UILabel *allLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@end

@implementation SBoxInfoVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createUI];
}
- (void)createUI
{
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(LAdaptation_y(245));
    }];
    
    [self.headerView addSubview:self.leftBtn];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView).offset(LAdaptation_y(20));
        make.left.equalTo(self.headerView).offset(LAdaptation_x(20));
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    [self.view addSubview:self.allLabel];
    [self.allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(LAdaptation_y(10));
        make.left.equalTo(self.view).offset(LAdaptation_x(20));
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allLabel.mas_bottom).offset(LAdaptation_y(10));
        make.left.equalTo(self.view).offset(LAdaptation_x(20));
        make.right.equalTo(self.view.mas_right).offset(-LAdaptation_x(20));
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UITableViewDataSource -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count+10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = @"asdlkfjasdlf";
    return cell;
}

#pragma mark - LazyLoad -
- (SBoxInfoHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[SBoxInfoHeaderView alloc] init];
        _headerView.backgroundColor = [UIColor redColor];
        _headerView.titleLabel.text = self.box.boxName;
        _headerView.gradeLabel.text = @"学科";
        _headerView.gradeInfoLabel.text = self.box.boxSubject;
        _headerView.tagLabel.text = @"标签";
        _headerView.tagInfoLabel.text = self.box.boxTags;
        _headerView.sourceLabel.text = @"来源";
        _headerView.sourceInfoLabel.text = @"暂无";
        _headerView.updateLabel.text = @"最近更新";
        _headerView.updateInfoLabel.text = self.box.updateDate;
        _headerView.studyCountLabel.text = @"学习人数";
        _headerView.studyCountInfoLabel.text = self.box.boxStudyCount;
    }
    return _headerView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}
- (UILabel *)allLabel
{
    if (!_allLabel) {
        _allLabel = [[UILabel alloc] init];
        _allLabel.text = @"全部内容";
        _allLabel.font = [UIFont systemFontOfSize:14.0];
    }
    return _allLabel;
}
- (UIButton *)leftBtn
{
    if (!_leftBtn) {
        UIImage *image = [UIImage imageNamed:@"arrow_left_white"];
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:image forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
@end
