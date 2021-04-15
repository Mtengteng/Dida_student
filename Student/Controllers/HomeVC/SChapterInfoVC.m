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


@interface SChapterInfoVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) SChapterHeaderView *headerView;
@property (nonatomic, strong) UICollectionView *collectionView;

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
    
    self.title = self.bookInfo.bookName;
    
    
    [self startRequest];
    
    [self createUI];
    
    
}
- (void)startRequest
{
    BWGetBookChapterReq *chapterReq = [[BWGetBookChapterReq alloc] init];
    chapterReq.bookId = self.bookInfo.bId;
    chapterReq.userId = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_userId];
    [NetManger sendRequest:chapterReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
        
    } failure:^(BWBaseReq *req, NSError *error) {
        
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
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 5;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"homeCell";
    SChapterCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
#pragma mark - LazyLoad -
- (SChapterHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[SChapterHeaderView alloc] initWithModel:self.bookInfo];
        _headerView.backgroundColor = [UIColor blueColor];
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
//        _collectionView.pagingEnabled = YES;
        //注册Cell，必须要有
        [_collectionView registerClass:[SChapterCell class] forCellWithReuseIdentifier:@"homeCell"];
    }
    return _collectionView;
}
@end
