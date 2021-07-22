//
//  SBoxInfoVC.m
//  Student
//
//  Created by 马腾 on 2021/7/22.
//

#import "SBoxInfoVC.h"
#import "SBox.h"
#import "SBoxInfoHeaderView.h"

@interface SBoxInfoVC ()
@property (nonatomic, strong) SBoxInfoHeaderView *headerView;

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
    
    [self createLeftBackBtn:^{
        
    }];
    
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
@end
