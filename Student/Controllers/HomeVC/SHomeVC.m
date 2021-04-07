//
//  SHomeVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "SHomeVC.h"
#import "SHomeSelectView.h"
#import "SHomeCollectionViewCell.h"
#import "SMenuItem.h"
#import "SMenuView.h"

#import "BWGetAllBookReq.h"
#import "BWGetAllBookResp.h"
#import "SBook.h"

@interface SHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *bannerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SHomeSelectView *selectView;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) SMenuView *menuView;
@end

@implementation SHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    self.currentIndex = 0;
    [self startRequest];
    
    DefineWeakSelf;
    self.selectView.selectBlock = ^(NSInteger index) {
        weakSelf.currentIndex = index;
        [weakSelf.collectionView reloadData];
    };
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
    
    [self.view addSubview:self.subtitleLabel];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom).offset(LAdaptation_y(30));
        make.left.equalTo(self.bannerView);
        make.height.mas_equalTo(LAdaptation_y(24));
    }];
    
    [self.view addSubview:self.selectView];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(LAdaptation_y(24));
        make.left.equalTo(self.subtitleLabel);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(LAdaptation_y(44));
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectView.mas_bottom).offset(LAdaptation_y(24));
        make.left.equalTo(self.selectView);
        make.right.equalTo(self.view.mas_right).offset(-LAdaptation_x(24));
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    NSMutableArray *itemArray = [[NSMutableArray alloc] init];
    NSArray *nameArray = @[@"高中",@"竞赛"];
    for (NSInteger i = 0; i < nameArray.count; i++) {
        SMenuItem *item = [[SMenuItem alloc] init];
        item.itemId = [NSString stringWithFormat:@"%ld",i];
        item.itemName = [nameArray safeObjectAtIndex:i];
        [itemArray addObject:item];
    }
    self.menuView = [[SMenuView alloc] initContentArray:itemArray withSuperView:self.view];
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
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    DefineWeakSelf;
    BWGetAllBookReq *bookReq = [[BWGetAllBookReq alloc] init];
    [NetManger sendRequest:bookReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        BWGetAllBookResp *bookResp = (BWGetAllBookResp *)resp;
        weakSelf.dataArray = bookResp.hotBookArray;
        [weakSelf.collectionView reloadData];
      
    } failure:^(BWBaseReq *req, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showMessag:error.domain toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];
        
    }];
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SBook *book = [self.dataArray safeObjectAtIndex:self.currentIndex];
    return book.books.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"homeCell";
    SHomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    SBook *book = [self.dataArray safeObjectAtIndex:self.currentIndex];
    SBookInfo *bookInfo = [book.books safeObjectAtIndex:indexPath.row];
    [cell setupCellWithModel:bookInfo];
    return cell;
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
- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont boldSystemFontOfSize:24.0];
        _subtitleLabel.text = @"精彩内容";
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
        [_collectionView registerClass:[SHomeCollectionViewCell class] forCellWithReuseIdentifier:@"homeCell"];
    }
    return _collectionView;
}

@end
