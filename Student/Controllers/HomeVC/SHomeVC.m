//
//  SHomeVC.m
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import "SHomeVC.h"
#import "SelectSubView.h"
#import "SAnswerCollectionViewCell.h"
#import "StudyCollectionViewCell.h"
#import "SMenuView.h"

#import "BWGetDictReq.h"
#import "BWGetDictResp.h"
#import "BWKnowledgeBoxReq.h"
#import "BWKnowledgeBoxResp.h"
#import "ItemTabView.h"
#import "ItemModel.h"

#import "SChapterInfoVC.h"
#import "SCDictModel.h"
#import "EBDropdownListView.h"
#import "SBoxInfoVC.h"
#import "SBox.h"

@interface SHomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UIImageView *bannerView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) SelectSubView *selectView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) SMenuView *menuView;
@property (nonatomic, strong) NSArray *menuArray;//学段array
@property (nonatomic, strong) NSArray *subArray;//学科
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) BWGetDictReq *dictReq;
@property (nonatomic, strong) BWKnowledgeBoxReq *boxReq;
@property (nonatomic, strong) EBDropdownListView *dropView;


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
- (void)initBlock
{
    DefineWeakSelf;
    
    //数学block
    self.selectView.selectSubBlock = ^(SCDictInfoModel * _Nonnull model,NSInteger index) {
//        weakSelf.currentIndex = index;
        [weakSelf getKnowledgeBoxWithSubject:model.dictKey];
        
    };
    
    
    //高中、竞赛block
    self.menuView.select = ^(SCDictInfoModel * _Nonnull selectItem) {
//        NSLog(@"%@",selectItem.itemName);
    };
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentIndex = 0;
    
    [self getDictPERIODRequest];
    
    
}
//获取学段
- (void)getDictPERIODRequest
{
    DefineWeakSelf;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.dictReq.dictType = @"PERIOD";//学段
    [NetManger sendRequest:self.dictReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
            
        BWGetDictResp *dictResp = (BWGetDictResp *)resp;
        
        SCDictModel *dictModel = (SCDictModel *)dictResp.data;
        
        weakSelf.menuArray = dictModel.dictValueList;
            
        if (weakSelf.menuArray.count != 0) {
            SCDictInfoModel *infoModel = [dictModel.dictValueList safeObjectAtIndex:1];
            [weakSelf getDictSUBJECTRequestWithGrade:infoModel.dictValue];
        }else{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [MBProgressHUD showMessag:@"无学段信息" toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];

        }
       
    } failure:^(BWBaseReq *req, NSError *error) {
            
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showMessag:error.domain toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];
       
    }];
}
//获取学科
- (void)getDictSUBJECTRequestWithGrade:(NSString *)PERIOD
{
    DefineWeakSelf;
    self.dictReq.dictType = @"SUBJECT"; //学科
//    self.dictReq.param = PERIOD;//学段
    [NetManger sendRequest:self.dictReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
        
        BWGetDictResp *dictResp = (BWGetDictResp *)resp;
        
        SCDictModel *dictModel = (SCDictModel *)dictResp.data;
        
        weakSelf.subArray = dictModel.dictValueList;
        
        if (weakSelf.subArray.count != 0) {
            SCDictInfoModel *infoModel = [dictModel.dictValueList safeObjectAtIndex:0];
            [weakSelf getKnowledgeBoxWithSubject:infoModel.dictKey];
        }else{
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [MBProgressHUD showMessag:@"无学科信息" toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];
        }
        [weakSelf createUI];

        
    } failure:^(BWBaseReq *req, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showMessag:error.domain toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];
    }];
}
//通过学科获取所有box
- (void)getKnowledgeBoxWithSubject:(NSString *)subject
{
    DefineWeakSelf;
    self.boxReq.subject = subject;
    [NetManger sendRequest:self.boxReq withSucessed:^(BWBaseReq *req, BWBaseResp *resp) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        BWKnowledgeBoxResp *boxResp = (BWKnowledgeBoxResp *)resp;
        weakSelf.dataArray = boxResp.data;
        
        EBDropdownListItem *item1 = [[EBDropdownListItem alloc] initWithItem:@"1" itemName:@"集合"];
        EBDropdownListItem *item2 = [[EBDropdownListItem alloc] initWithItem:@"2" itemName:@"函数"];
        EBDropdownListItem *item3 = [[EBDropdownListItem alloc] initWithItem:@"3" itemName:@"效率"];
        EBDropdownListItem *item4 = [[EBDropdownListItem alloc] initWithItem:@"4" itemName:@"ABC"];

        self.dropView.dataSource = @[item1,item2,item3,item4];
        
        [weakSelf.collectionView reloadData];
        
    } failure:^(BWBaseReq *req, NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showMessag:error.domain toView:weakSelf.view hudModel:MBProgressHUDModeText hide:YES];
    }];
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
    
    [self.view addSubview:self.selectView];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bannerView.mas_bottom).offset(LAdaptation_y(10));
        make.left.equalTo(self.bannerView);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(LAdaptation_y(44));
    }];
    
    [self.navigationController.navigationBar addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.navigationController.navigationBar);
        make.left.equalTo(self.navigationController.navigationBar).offset(LAdaptation_x(24));
        make.width.mas_equalTo(LAdaptation_x(60));
        make.height.mas_equalTo(44);
    }];
    
    
    [self.view addSubview:self.dropView];
    [self.dropView setDropdownListViewSelectedBlock:^(EBDropdownListView *dropdownListView) {
        NSString *msgString = [NSString stringWithFormat:
                               @"selected name:%@  id:%@  index:%ld"
                               , dropdownListView.selectedItem.itemName
                               , dropdownListView.selectedItem.itemId
                               , dropdownListView.selectedIndex];

        NSLog(@"%@",msgString);

    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.selectView.mas_bottom).offset(LAdaptation_y(84));
        make.left.equalTo(self.bannerView);
        make.width.equalTo(self.bannerView);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [self loadCollectViewType];
    [self initBlock];

}

- (void)loadCollectViewType
{
    
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
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
}

#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellId = @"studyCell";
    
    SBox *box = [self.dataArray safeObjectAtIndex:indexPath.row];
    
    StudyCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell setupCellWithModel:box];

    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SBox *box = [self.dataArray safeObjectAtIndex:indexPath.row];
    SBoxInfoVC *infoVC = [[SBoxInfoVC alloc] init];
    infoVC.box = box;
    infoVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:infoVC animated:YES];
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
        _menuView = [[SMenuView alloc] initContentArray:self.menuArray withSuperView:self.view];
    }
    return _menuView;
}

- (SelectSubView *)selectView
{
    if (!_selectView) {
        _selectView = [[SelectSubView alloc] initWithItemArray:self.subArray];
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
        [_collectionView registerClass:[StudyCollectionViewCell class] forCellWithReuseIdentifier:@"studyCell"];
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
- (EBDropdownListView *)dropView
{
    if (!_dropView) {
        _dropView = [[EBDropdownListView alloc] init];
        [_dropView setFrame:CGRectMake(LAdaptation_x(24), LAdaptation_y(321), LAdaptation_x(120), LAdaptation_y(30))];
        [_dropView setViewBorder:0.5 borderColor:[UIColor grayColor] cornerRadius:2];
        _dropView.selectedIndex = 0;
    }
    return _dropView;
}
- (BWGetDictReq *)dictReq
{
    if (!_dictReq) {
        _dictReq = [[BWGetDictReq alloc] init];
    }
    return _dictReq;
}
- (BWKnowledgeBoxReq *)boxReq
{
    if (!_boxReq) {
        _boxReq = [[BWKnowledgeBoxReq alloc] init];
    }
    return _boxReq;
}
@end
