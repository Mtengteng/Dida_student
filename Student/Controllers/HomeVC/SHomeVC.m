//
//  SHomeVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "SHomeVC.h"
#import "SubModel.h"
#import "SelectSubView.h"
#import "SAnswerCollectionViewCell.h"
#import "StudyCollectionViewCell.h"
#import "SMenuItem.h"
#import "SMenuView.h"

#import "BWGetAllBookReq.h"
#import "BWGetAllBookResp.h"
#import "SBook.h"
#import "ItemTabView.h"
#import "ItemModel.h"

#import "SChapterInfoVC.h"

typedef enum _studyOrAnswerType
{
    answer_type = 0,
    study_type = 1,
}studyOrAnswerType;

@interface SHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, assign) studyOrAnswerType type;
@property (nonatomic, strong) UIImageView *bannerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) SelectSubView *selectView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) SMenuView *menuView;
@property (nonatomic, strong) ItemTabView *itemTab;
@property (nonatomic, strong) ItemTabView *sortTab;
@property (nonatomic, strong) NSArray *menuArray;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *subArray;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) NSArray *sortArray;

@end

@implementation SHomeVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.menuView.hidden = NO;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.menuView.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    self.currentIndex = 0;
    
    [self startRequest];
    
    DefineWeakSelf;
    
    //答题集block
    self.itemTab.selectBlock = ^(NSInteger index) {
        
        weakSelf.type = index == 0 ? answer_type : study_type;

        [weakSelf.selectView setFirstSub:^(SubModel * _Nonnull model,NSInteger index) {
            NSLog(@"复原 sub选项 subName = %@,index = %ld",model.subName,index);
            //此处获取数据刷新
            weakSelf.currentIndex = index;
            [weakSelf.collectionView reloadData];
        }];
        
        [weakSelf loadCollectViewType];
        
    };
    
    //数学block
    self.selectView.selectSubBlock = ^(SubModel * _Nonnull model,NSInteger index) {
        weakSelf.currentIndex = index;
        [weakSelf.collectionView reloadData];
    };
    
    //必修一block
    self.sortTab.selectBlock = ^(NSInteger index) {
        
    };
    
    //高中、竞赛block
    self.menuView.select = ^(SMenuItem * _Nonnull selectItem) {
        NSLog(@"%@",selectItem.itemName);
    };
    

}
- (void)createUI
{
    [self.view addSubview:self.bannerView];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LAdaptation_y(8));
        make.left.equalTo(self.view).offset(LAdaptation_x(24));
        make.right.equalTo(self.view.mas_right).offset(-LAdaptation_x(24));
        make.height.mas_equalTo(LAdaptation_y(233));
    }];
    
    [self.view addSubview:self.itemTab];
    [self.itemTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom).offset(LAdaptation_y(30));
        make.left.equalTo(self.bannerView);
        make.width.mas_equalTo(LAdaptation_x(100)*self.itemArray.count);
        make.height.mas_equalTo(LAdaptation_y(24));
    }];
    
    [self.view addSubview:self.selectView];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemTab.mas_bottom).offset(LAdaptation_y(10));
        make.left.equalTo(self.itemTab);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(LAdaptation_y(44));
    }];
    
    [self.view addSubview:self.sortTab];
    [self.sortTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectView.mas_bottom).offset(LAdaptation_y(10));
        make.left.equalTo(self.bannerView);
        make.width.mas_equalTo(LAdaptation_x(100)*self.sortArray.count);
        make.height.mas_equalTo(LAdaptation_y(24));
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortTab.mas_bottom).offset(LAdaptation_y(15));
        make.left.equalTo(self.selectView);
        make.right.equalTo(self.view.mas_right).offset(-LAdaptation_x(24));
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self loadCollectViewType];

    
    [self.navigationController.navigationBar addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationController.navigationBar);
        make.left.equalTo(self.navigationController.navigationBar).offset(LAdaptation_x(24));
        make.width.mas_equalTo(LAdaptation_x(60));
        make.height.mas_equalTo(44);
    }];
    
    
}
- (void)startRequest
{
    [SCustomProgressHUD showHUDAddedTo:self.view animated:YES];
    
    DefineWeakSelf;
    BWGetAllBookReq *bookReq = [[BWGetAllBookReq alloc] init];
    [NetManger sendRequest:bookReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
        [SCustomProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        BWGetAllBookResp *bookResp = (BWGetAllBookResp *)resp;
        weakSelf.dataArray = bookResp.hotBookArray;
        [weakSelf.collectionView reloadData];
      
    } failure:^(BWBaseReq *req, NSError *error) {
        [SCustomProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showMessag:error.domain toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];
        
    }];
}
- (void)loadCollectViewType
{
    
    if (self.type == answer_type) {
        CGFloat itemW;
        CGFloat itemH;
        self.flowLayout.minimumInteritemSpacing = LAdaptation_x(20);
        self.flowLayout.minimumLineSpacing = LAdaptation_y(53);

        // 设置item的大小
        itemW = LAdaptation_x(128);
        itemH = LAdaptation_y(209);
        
        // 设置每个分区的 上左下右 的内边距
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0 ,0, 0);
        self.flowLayout.itemSize = CGSizeMake(itemW, itemH);
        [self.collectionView registerClass:[SAnswerCollectionViewCell class] forCellWithReuseIdentifier:@"answerCell"];

        
    }else{
        
        CGFloat itemW;
        CGFloat itemH;
        self.flowLayout.minimumInteritemSpacing = LAdaptation_x(20);
        self.flowLayout.minimumLineSpacing = LAdaptation_y(20);

        // 设置item的大小
        itemW = LAdaptation_x(220);
        itemH = LAdaptation_y(165);
        
        // 设置每个分区的 上左下右 的内边距
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0 ,0, 0);
        self.flowLayout.itemSize = CGSizeMake(itemW, itemH);
        [self.collectionView registerClass:[StudyCollectionViewCell class] forCellWithReuseIdentifier:@"studyCell"];

    }
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.type == answer_type) {
        SBook *book = [self.dataArray safeObjectAtIndex:self.currentIndex];
        return book.books.count;
    }else{
        return 10;
    }
    return 0;

}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == answer_type) {
        static NSString * CellIdentifier = @"answerCell";
        SAnswerCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        SBook *book = [self.dataArray safeObjectAtIndex:self.currentIndex];
        SBookInfo *bookInfo = [book.books safeObjectAtIndex:indexPath.row];
        [cell setupCellWithModel:bookInfo];
        return cell;
    }else{
        static NSString * cellId = @"studyCell";
        StudyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        [cell setupCellWithModel:nil];

        return cell;
    }

    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == answer_type) {
        SBook *book = [self.dataArray safeObjectAtIndex:self.currentIndex];
        SBookInfo *bookInfo = [book.books safeObjectAtIndex:indexPath.row];
        SChapterInfoVC *infoVC = [[SChapterInfoVC alloc] init];
        infoVC.bookInfo = bookInfo;
        infoVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:infoVC animated:YES];
    }else{
        
    }

    
}

#pragma mark - LazyLoad -
- (UIImageView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[UIImageView alloc] init];
        _bannerView.contentMode = UIViewContentModeScaleToFill;
        [_bannerView setImage:[UIImage imageNamed:@"banner"]];
    }
    return _bannerView;
}
- (SMenuView *)menuView
{
    if (!_menuView) {
        NSMutableArray *itemArray = [[NSMutableArray alloc] init];
        NSArray *nameArray = @[@"高中",@"竞赛"];
        for (NSInteger i = 0; i < nameArray.count; i++) {
            SMenuItem *item = [[SMenuItem alloc] init];
            item.itemId = [NSString stringWithFormat:@"%ld",i];
            item.itemName = [nameArray safeObjectAtIndex:i];
            [itemArray addObject:item];
        }
        self.menuArray = itemArray;
        _menuView = [[SMenuView alloc] initContentArray:itemArray withSuperView:self.view];
    }
    return _menuView;
}
- (ItemTabView *)itemTab
{
    if (!_itemTab) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *itemArray = @[@"答题集",@"学习集"];
        for (NSInteger i = 0; i < itemArray.count; i++) {
            ItemModel *model = [[ItemModel alloc] init];
            model.itemId = [NSString stringWithFormat:@"%ld",i];
            model.itemName = [itemArray safeObjectAtIndex:i];
            [array addObject:model];
        }
        self.itemArray = array;
        
        _itemTab = [[ItemTabView alloc] initWithItemArray:array withFontSize:20 withEachItemWidth:LAdaptation_x(100) contentAlignment:ButtonContentAlignment_Left];
    }
    
    return _itemTab;
}
- (ItemTabView *)sortTab
{
    if (!_sortTab) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *itemArray = @[@"必修一",@"必修二",@"必修三",@"必须四"];
        for (NSInteger i = 0; i < itemArray.count; i++) {
            ItemModel *model = [[ItemModel alloc] init];
            model.itemId = [NSString stringWithFormat:@"%ld",i];
            model.itemName = [itemArray safeObjectAtIndex:i];
            [array addObject:model];
        }
        self.sortArray = array;
        
        _sortTab = [[ItemTabView alloc] initWithItemArray:array withFontSize:16 withEachItemWidth:LAdaptation_x(100) contentAlignment:ButtonContentAlignment_Left];
    }
    
    return _sortTab;
}
- (SelectSubView *)selectView
{
    if (!_selectView) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *subArray = @[@"数学",@"物理",@"化学"];
        for (NSInteger i = 0; i < subArray.count; i++) {
            SubModel *model = [[SubModel alloc] init];
            model.subId = [NSString stringWithFormat:@"%ld",i];
            model.subName = [subArray safeObjectAtIndex:i];
            [array addObject:model];
        }
        
        self.subArray = array;

        
        _selectView = [[SelectSubView alloc] initWithItemArray:array];
    }
    return _selectView;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
        _collectionView.scrollEnabled = YES;  //滚动使能
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        //注册Cell，必须要有
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return _flowLayout;
}

@end
