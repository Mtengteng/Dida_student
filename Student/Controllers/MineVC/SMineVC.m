//
//  SMineVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "SMineVC.h"

@interface SMineVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *headerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *desLabel;
@property (nonatomic, strong) UIButton *settingBtn;

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
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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


@end
