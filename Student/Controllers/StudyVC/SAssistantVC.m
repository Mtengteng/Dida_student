//
//  SAssistantVC.m
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import "SAssistantVC.h"
#import "SCureView.h"
#import "SHomeSelectView.h"
#import "SAssistantCell.h"

@interface SAssistantVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SHomeSelectView *selectView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UILabel *subtitleLabel;

@end

@implementation SAssistantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    self.currentIndex = 0;
//    [self startRequest];
    
    DefineWeakSelf;
    self.selectView.selectBlock = ^(NSInteger index) {
        weakSelf.currentIndex = index;
//        [weakSelf.collectionView reloadData];
    };
    
}
- (void)createUI
{
    SCureView *curv = [[SCureView alloc] initWithTitle:@"测试成绩" withItemArray:@[@"数学",@"物理",@"化学"]];
    [self.view addSubview:curv];
    [curv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LAdaptation_y(44));
        make.left.equalTo(self.view).offset(LAdaptation_x(24));
        make.right.equalTo(self.view).offset(-LAdaptation_x(24));
        make.height.mas_equalTo(LAdaptation_y(290));
    }];
    
    [self.view addSubview:self.subtitleLabel];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(curv.mas_bottom).offset(LAdaptation_y(30));
        make.left.equalTo(curv);
        make.height.mas_equalTo(LAdaptation_y(24));
    }];
    
    [self.view addSubview:self.selectView];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(LAdaptation_y(24));
        make.left.equalTo(self.subtitleLabel);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(LAdaptation_y(44));
    }];
}


#pragma mark - LazyLoad -
- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont boldSystemFontOfSize:24.0];
        _subtitleLabel.text = @"最新试卷";
    }
    return _subtitleLabel;
}
- (SHomeSelectView *)selectView
{
    if (!_selectView) {
        NSArray *itemList = @[@"数学",@"物理",@"化学"];
        _selectView = [[SHomeSelectView alloc] initWithItemArray:itemList];
    }
    return _selectView;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat itemW;
        CGFloat itemH;
        layout.minimumInteritemSpacing = LAdaptation_x(20);
        layout.minimumLineSpacing = LAdaptation_y(53);

        // 设置item的大小
        itemW = LAdaptation_x(128);
        itemH = LAdaptation_y(209);
        
        // 设置每个分区的 上左下右 的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, 0 ,0, 0);
        layout.itemSize = CGSizeMake(itemW, itemH);
        // 设置滚动条方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
        _collectionView.scrollEnabled = YES;  //滚动使能
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册Cell，必须要有
        [_collectionView registerClass:[SAssistantCell class] forCellWithReuseIdentifier:@"SAssistantCell"];
    }
    return _collectionView;
}
@end
