//
//  SAddStudyClassVC.m
//  Student
//
//  Created by mateng on 2021/7/8.
//

#import "SAddStudyClassVC.h"
#import "SAMenuBarView.h"
#import "SANode.h"

#import "SABaseInfoView.h"
#import "SANodeInfoView.h"
#import "SAPublishView.h"

@interface SAddStudyClassVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) SAMenuBarView *menuBarView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *viewList;
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
    
    [self.scrollView setFrame:CGRectMake(0, BW_TopHeight+LAdaptation_y(10), SCREEN_WIDTH, SCREEN_HEIGHT - (BW_TopHeight+LAdaptation_y(10)))];
    [self.view addSubview:self.scrollView];

    SABaseInfoView *infoView = [[SABaseInfoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (BW_TopHeight+LAdaptation_y(10)))];
    infoView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:infoView];
    
    infoView.nextBlock = ^(NSString * _Nonnull name, BOOL isPublic, NSString * _Nonnull gradeKey) {
        weakSelf.node
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    };
    
    SANodeInfoView *nodeView = [[SANodeInfoView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (BW_TopHeight+LAdaptation_y(10)))];
    nodeView.backgroundColor = [UIColor whiteColor];
    nodeView.superVC = self;
    [self.scrollView addSubview:nodeView];
    
    nodeView.nextBlock = ^(NSString * _Nonnull name, BOOL isPublic, NSString * _Nonnull gradeKey) {
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0) animated:YES];
    };
    
    SAPublishView *publishView = [[SAPublishView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (BW_TopHeight+LAdaptation_y(10)))];
    publishView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:publishView];
    
    [self.viewList addObjectsFromArray:@[infoView,nodeView,publishView]];
    
    self.scrollView.contentSize = CGSizeMake(self.viewList.count*SCREEN_WIDTH, 0);
    
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
- (NSMutableArray *)viewList
{
    if (!_viewList) {
        _viewList = [[NSMutableArray alloc] init];
    }
    return _viewList;
}
- (SANode *)node
{
    if (!_node) {
        _node = [[SANode alloc] init];
    }
    return _node;
}
@end
