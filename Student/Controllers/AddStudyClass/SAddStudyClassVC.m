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
    
    __block NSString *stName;
    __block BOOL public;
    __block NSString *grade;
    infoView.nextBlock = ^(NSString * _Nonnull name, BOOL isPublic, NSString * _Nonnull gradeKey) {
        stName = name;
        public = isPublic;
        grade = gradeKey;
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    };
    
    SAPublishView *publishView = [[SAPublishView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (BW_TopHeight+LAdaptation_y(10)))];
    publishView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:publishView];
    
    SANodeInfoView *nodeView = [[SANodeInfoView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (BW_TopHeight+LAdaptation_y(10)))];
    nodeView.backgroundColor = [UIColor whiteColor];
    nodeView.superVC = self;
    [self.scrollView addSubview:nodeView];
    
    __block NSArray *nodeList;
    nodeView.next = ^(NSArray *nodeArray) {
        nodeList = nodeArray;
        
        [publishView setDataWith:nodeList];
        
        [self.scrollView setContentOffset:CGPointMake(SCREEN_WIDTH*2, 0) animated:YES];
    };
    
    
    publishView.publish = ^(NSString * _Nonnull name, NSArray * _Nonnull nodeArray, NSString * _Nonnull backup) {
        
        [weakSelf queryPublishRequest:name nodeList:nodeArray public:public grade:grade];
    };

    
    [self.viewList addObjectsFromArray:@[infoView,nodeView,publishView]];
    
    self.scrollView.contentSize = CGSizeMake(self.viewList.count*SCREEN_WIDTH, 0);
    
}

- (void)queryPublishRequest:(NSString *)name
                   nodeList:(NSArray *)nodeArray
                     public:(BOOL)isPublic
                      grade:(NSString *)gradeKey
{
    
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

@end
