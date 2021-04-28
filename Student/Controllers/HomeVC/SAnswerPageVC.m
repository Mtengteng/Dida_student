//
//  SAnswerPageVC.m
//  Student
//
//  Created by 马腾 on 2021/4/19.
//

#import "SAnswerPageVC.h"
#import "SChapterSection.h"
#import "ItemTabView.h"
#import "ItemModel.h"
#import "SAnswerSelectCell.h"
#import "SAnswer.h"

@interface SAnswerPageVC ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) ItemTabView *itemTab;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *submitArray;
@end

@implementation SAnswerPageVC

//+ (id)shareInstances
//{
//    static SAnswerPageVC *pageVC = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        pageVC = [[SAnswerPageVC alloc] init];
//    });
//    return pageVC;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    //答题集block
    self.itemTab.selectBlock = ^(NSInteger index) {
        
        
    };
    
    //假数据
    self.sectionArray = @[@"单选题",@"填空题",@"解答题"];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i<35; i++) {
        NSMutableArray *answerList = [[NSMutableArray alloc] init];
        for (NSInteger j = 0;j<4; j++) {
            NSArray *array = @[@"A",@"B",@"C",@"D"];
            SAnswer *answer = [[SAnswer alloc] init];
            answer.answerId = [NSString stringWithFormat:@"%ld%ld",i,j];
            answer.name = [array safeObjectAtIndex:j];
            [answerList addObject:answer];
        }
        [dataArray addObject:answerList];

    }
    self.dataArray = dataArray;
    [self.collectionView reloadData];
    
}
- (void)createUI
{
    DefineWeakSelf;
    [self createLeftBackBtn:^{
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    self.title = self.section.sectionName;
    
    [self.view addSubview:self.itemTab];
    [self.itemTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(LAdaptation_y(60));
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.itemTab.mas_bottom).offset(LAdaptation_y(10));
        make.left.equalTo(self.view).offset(LAdaptation_x(24));
        make.right.equalTo(self.view.mas_right).offset(-LAdaptation_x(24));
        make.height.equalTo(self.view).offset(-LAdaptation_y(70));
    }];

    
    
}
#pragma UICollectionView - delegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(14, 14, 14, 14);
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.sectionArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section {
   
    return CGSizeMake(self.view.frame.size.width, LAdaptation_y(60));
}
 
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor whiteColor];
    
    for (id v in headerView.subviews)
        [v removeFromSuperview];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, LAdaptation_y(60))];
    titleLabel.text = [NSString stringWithFormat:@"%ld  %@",(long)indexPath.section+1,[self.sectionArray safeObjectAtIndex:indexPath.section]];
    titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
    [headerView addSubview:titleLabel];
    return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArray.count;
    }else if(section == 1){
        return 0;
    }else{
        return 0;
    }
    return 0;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"cell";
    SAnswerSelectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        NSArray *answerList = [self.dataArray safeObjectAtIndex:indexPath.row];
        [cell setupCellWithArray:answerList];
        
        DefineWeakSelf;
        cell.selectAnswerBlock = ^(NSInteger answerId) {
            [self.dataArray enumerateObjectsUsingBlock:^(NSArray *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [answerList enumerateObjectsUsingBlock:^(SAnswer*  _Nonnull answer, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (answer.answerId.integerValue == answerId) {
                        answer.isSelected = YES;
                        [weakSelf.submitArray addObject:answer];
                    }
                }];

            }];
            [weakSelf.collectionView reloadData];
        };

    }
    
    return cell;
}
#pragma mark - LazyLoad -
- (ItemTabView *)itemTab
{
    if (!_itemTab) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        NSArray *itemArray = @[@"基础篇",@"综合篇",@"应用篇",@"专属检测"];
        for (NSInteger i = 0; i < itemArray.count; i++) {
            ItemModel *model = [[ItemModel alloc] init];
            model.itemId = [NSString stringWithFormat:@"%ld",i];
            model.itemName = [itemArray safeObjectAtIndex:i];
            [array addObject:model];
        }
        self.itemArray = array;
        
        _itemTab = [[ItemTabView alloc] initWithItemArray:array withFontSize:20 withEachItemWidth:self.view.bounds.size.width/itemArray.count contentAlignment:ButtonContentAlignment_Center];
    }
    
    return _itemTab;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        CGFloat itemW;
        CGFloat itemH;
        layout.minimumInteritemSpacing = LAdaptation_x(20);
        layout.minimumLineSpacing = LAdaptation_y(20);

        // 设置item的大小
        itemW = LAdaptation_x(300);
        itemH = LAdaptation_y(60);
        
        // 设置每个分区的 上左下右 的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, LAdaptation_x(20) ,0, LAdaptation_x(120));
        layout.itemSize = CGSizeMake(itemW, itemH);
        // 设置滚动条方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, LAdaptation_y(60));
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
//        _collectionView.scrollEnabled = YES;  //滚动使能
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.clipsToBounds = NO;
//        _collectionView.pagingEnabled = YES;
        //注册Cell，必须要有
        [_collectionView registerClass:[SAnswerSelectCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionViewHeader"];//注册header的view

    }
    return _collectionView;
}
- (NSMutableArray *)submitArray
{
    if (!_submitArray) {
        _submitArray = [[NSMutableArray alloc] init];
    }
    return _submitArray;
}
@end
