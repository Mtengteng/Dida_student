//
//  SAddStudyClassVC.m
//  Student
//
//  Created by mateng on 2021/7/8.
//

#import "SAddStudyClassVC.h"
#import "SAMenuBarView.h"
#import "SANode.h"

@interface SAddStudyClassVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) SAMenuBarView *menuBarView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) SANode *node;

@end

@implementation SAddStudyClassVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
}
- (void)createUI
{
    [self.view addSubview:self.menuBarView];
    [self.menuBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(self.view);
        make.height.mas_equalTo(BW_TopHeight+LAdaptation_y(10));
    }];
    
    DefineWeakSelf;
    self.menuBarView.backBlock = ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
    self.menuBarView.saveBlock = ^{
        
    };
}


#pragma mark - LazyLoad -
- (SAMenuBarView *)menuBarView
{
    if (!_menuBarView) {
        _menuBarView = [[SAMenuBarView alloc] init];
        _menuBarView.backgroundColor = [UIColor whiteColor];
    }
    return _menuBarView;
}
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.scrollEnabled = NO;
    }
    return _scrollView;
}

@end
