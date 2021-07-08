//
//  SAddStudyClassVC.m
//  Student
//
//  Created by mateng on 2021/7/8.
//

#import "SAddStudyClassVC.h"

@interface SAddStudyClassVC ()
@property (nonatomic, strong) UIView *tabView;

@end

@implementation SAddStudyClassVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(NAV_HEIGHT);
    }];
    
}



#pragma mark - LazyLoad -
- (UIView *)tabView
{
    if (!_tabView) {
        _tabView = [[UIView alloc] init];
        _tabView.backgroundColor = [UIColor redColor];
    }
    return _tabView;
}
@end
