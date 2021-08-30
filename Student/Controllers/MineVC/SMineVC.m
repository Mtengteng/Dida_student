//
//  SMineVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "SMineVC.h"
#import "SelectSubView.h"
#import "SCDictModel.h"


@interface SMineVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIButton *settingBtn;
@property (nonatomic, strong) SelectSubView *subView;

@end

@implementation SMineVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}
- (void)createUI
{
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LAdaptation_y(60));
        make.left.equalTo(self.view).offset(LAdaptation_x(20));
        make.width.mas_equalTo(LAdaptation_x(60));
        make.height.mas_equalTo(LAdaptation_y(60));
    }];
    
    [self.view addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView);
        make.left.equalTo(self.headerView.mas_right).offset(LAdaptation_x(5));
    }];
    
    [self.view addSubview:self.desLabel];
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.headerView.mas_right).offset(LAdaptation_x(5));
    }];
    
    [self.view addSubview:self.settingBtn];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView);
        make.right.equalTo(self.view.mas_right).offset(-LAdaptation_x(20));
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.subView];
    [self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(LAdaptation_y(20));
        make.left.equalTo(self.view).offset(LAdaptation_x(40));
        make.right.equalTo(self.view.mas_right).offset(-LAdaptation_x(40));
        make.height.mas_equalTo(LAdaptation_y(44));
    }];
    
//    [self.view addSubview:self.scrollView];
//    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
}
- (void)gotoSettingAction:(id)sender
{
    
}
#pragma mark - LazyLoad -
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
    }
    return _scrollView;
}
- (UIImageView *)headerView
{
    if (!_headerView) {
        NSString *photo = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_avatar];
        _headerView = [[UIImageView alloc] init];
        _headerView.backgroundColor = [UIColor redColor];
        [_headerView sd_setImageWithURL:[NSURL URLWithString:photo]];
    }
    return _headerView;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_nickName];
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
    }
    return _titleLabel;
}
- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.text = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_slogan];
        _desLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _desLabel;
}
- (UIButton *)settingBtn
{
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_settingBtn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(gotoSettingAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}
- (SelectSubView *)subView
{
    if (!_subView) {
        
        NSArray *array = @[@"我的动态",@"我的数据",@"我的内容"];
        NSMutableArray *infoArray = [[NSMutableArray alloc] init];
       
        for (NSInteger i = 0; i < array.count; i++) {
            SCDictInfoModel *model = [[SCDictInfoModel alloc] init];
            model.dictValueId = [NSString stringWithFormat:@"%ld",i];
            model.dictValue = [array safeObjectAtIndex:i];
            [infoArray addObject:model];
        }
        
        _subView = [[SelectSubView alloc] initWithItemArray:infoArray];
    }
    return _subView;
}

@end
