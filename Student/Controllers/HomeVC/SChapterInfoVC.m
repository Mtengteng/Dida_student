//
//  SChapterInfoVC.m
//  Student
//
//  Created by 马腾 on 2021/4/15.
//

#import "SChapterInfoVC.h"
#import "SChapterCell.h"
#import "SChapterHeaderView.h"
#import "SBook.h"
#import "BWGetBookChapterReq.h"
#import "BWGetBookChapterResp.h"
#import "SChapter.h"

#import "BWChapterSecionReq.h"
#import "BWChapterSecionResp.h"
#import "SChapterSection.h"

#import "SAnswerPageVC.h"


@interface SChapterInfoVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) SChapterHeaderView *headerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *chapterArray;
@property (nonatomic, strong) NSCache *cache;

@end

@implementation SChapterInfoVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.title = self.bookInfo.bookName;
    
    [self startRequest];
    
    [self createUI];
    
    
}
- (void)startRequest
{
    [SCustomProgressHUD showHUDAddedTo:self.view animated:YES];
    
    DefineWeakSelf;
    BWGetBookChapterReq *chapterReq = [[BWGetBookChapterReq alloc] init];
//    chapterReq.bookId = self.bookInfo.bId;
    chapterReq.userId = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_userId];
    [NetManger sendRequest:chapterReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
        [SCustomProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        BWGetBookChapterResp *chapterResp = (BWGetBookChapterResp *)resp;
        
        weakSelf.chapterArray = chapterResp.data;
        
        [weakSelf.collectionView reloadData];
        
    } failure:^(BWBaseReq *req, NSError *error) {
        [SCustomProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showMessag:error.domain toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];
    }];
}
- (void)createUI
{

    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(LAdaptation_y(354));
    }];
    
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(-LAdaptation_y(40));
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self.view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LAdaptation_y(24));
        make.left.equalTo(self.view).offset(LAdaptation_y(24));
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
}
- (void)backAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UIScrollViewDelegate -
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGPoint originalTargetContentOffset = CGPointMake(targetContentOffset->x, targetContentOffset->y);
    CGPoint targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2, CGRectGetHeight(self.collectionView.bounds) / 2);
    NSIndexPath *indexPath = nil;
    NSInteger i = 0;
    while (indexPath == nil) {
        targetCenter = CGPointMake(originalTargetContentOffset.x + CGRectGetWidth(self.collectionView.bounds)/2 + 10*i, CGRectGetHeight(self.collectionView.bounds) / 2);
        indexPath = [self.collectionView indexPathForItemAtPoint:targetCenter];
        i++;
    }
//    self.selectedIndex = indexPath;
    //这里用attributes比用cell要好很多，因为cell可能因为不在屏幕范围内导致cellForItemAtIndexPath返回nil
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
    if (attributes) {
        *targetContentOffset = CGPointMake(attributes.center.x - CGRectGetWidth(self.collectionView.bounds)/2, originalTargetContentOffset.y);
    } else {
//        DLog(@"center is %@; indexPath is {%@, %@}; cell is %@",NSStringFromCGPoint(targetCenter), @(indexPath.section), @(indexPath.item), attributes);
    }
   
}
#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.chapterArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"homeCell";
    SChapterCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SChapter *chapter = [self.chapterArray safeObjectAtIndex:indexPath.row];
    [cell setupCellWithModel:chapter];
    
    id data = [self.cache objectForKey:chapter.chapterId];
    if (data == nil) {
        
        DefineWeakSelf;
        [SCustomProgressHUD showHUDAddedTo:self.view animated:YES];
        BWChapterSecionReq *sectionReq = [[BWChapterSecionReq alloc] init];
        sectionReq.sectionId = chapter.chapterId;
        sectionReq.userId = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_userId];
        [NetManger sendRequest:sectionReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
            [SCustomProgressHUD hideHUDForView:weakSelf.view animated:YES];
            
            BWChapterSecionResp *sectionResp = (BWChapterSecionResp *)resp;
            
            [cell loadSectionArray:sectionResp.data];
            
            [weakSelf.cache setObject:sectionResp.data forKey:chapter.chapterId];
            
        } failure:^(BWBaseReq *req, NSError *error) {
            [SCustomProgressHUD hideHUDForView:weakSelf.view animated:YES];
            
        }];
        
    }else{
        [cell loadSectionArray:data];
    }
    
    DefineWeakSelf;
    cell.didSelectModelBlock = ^(SChapterSection * _Nonnull model) {
        
        SAnswerPageVC *pageVC = [[SAnswerPageVC alloc] init];
        pageVC.section = model;
        [weakSelf.navigationController pushViewController:pageVC animated:YES];
    };
    
    return cell;
}

#pragma mark - LazyLoad -
- (UIButton *)backBtn
{
    if (!_backBtn) {
        UIImage *image = [UIImage imageNamed:@"arrow_left_white"];
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (SChapterHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[SChapterHeaderView alloc] initWithModel:self.bookInfo];
    }
    return _headerView;
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
        itemW = LAdaptation_x(680);
        itemH = LAdaptation_y(690);
        
        // 设置每个分区的 上左下右 的内边距
        layout.sectionInset = UIEdgeInsetsMake(0, LAdaptation_x(20) ,0, LAdaptation_x(20));
        layout.itemSize = CGSizeMake(itemW, itemH);
        // 设置滚动条方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
//        _collectionView.scrollEnabled = YES;  //滚动使能
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.clipsToBounds = NO;
//        _collectionView.pagingEnabled = YES;
        //注册Cell，必须要有
        [_collectionView registerClass:[SChapterCell class] forCellWithReuseIdentifier:@"homeCell"];
        
    }
    return _collectionView;
}
- (NSCache *)cache
{
    if (!_cache) {
        _cache = [[NSCache alloc] init];
    }
    return _cache;
}
@end
