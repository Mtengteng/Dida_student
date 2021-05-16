//
//  SAssistantVC.m
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import "SAssistantVC.h"
#import "SCureView.h"
#import "SelectSubView.h"
#import "SubModel.h"
#import "SelectWhiteBGBar.h"
#import "SCAssistantCell.h"
#import "SCPaperCell.h"


@interface SAssistantVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *currentView;
@property (nonatomic, strong) UICollectionView *asstView;
@property (nonatomic, strong) SelectSubView *selectView;
@property (nonatomic, strong) SelectWhiteBGBar *whiteBar;
@property (nonatomic, strong) SCureView *curv;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UILabel *asstSubtitleLabel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *subArray;

@end

@implementation SAssistantVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    self.currentIndex = 0;
//    [self startRequest];
    
    DefineWeakSelf;
    self.selectView.selectSubBlock = ^(SubModel * _Nonnull model,NSInteger index) {
        weakSelf.currentIndex = index;
        
    };
    
    self.whiteBar.selectWhiteBarBlock = ^(NSString * _Nonnull barTitle) {
        if ([barTitle isEqualToString:@"试卷"]) {
            
            [weakSelf.curv.chartView aa_drawChartWithChartModel:[weakSelf configureColorfulGradientSplineChart]];

        }else{
            [weakSelf.curv.chartView aa_drawChartWithChartModel:[weakSelf configureColorfulColumnChart]];

        }
        
    };
    
}
- (void)createUI
{
    [self.view addSubview:self.whiteBar];
    [self.whiteBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(LAdaptation_y(40));
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(LAdaptation_x(160));
        make.height.mas_equalTo(LAdaptation_y(30));
    }];
    
    [self.curv.chartView aa_drawChartWithChartModel:[self configureColorfulGradientSplineChart]];
    [self.view addSubview:self.curv];
    [self.curv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteBar.mas_bottom);
        make.left.equalTo(self.view).offset(LAdaptation_x(24));
        make.right.equalTo(self.view).offset(-LAdaptation_x(24));
        make.height.mas_equalTo(LAdaptation_y(290));
    }];
    
    [self.view addSubview:self.subtitleLabel];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.curv.mas_bottom).offset(LAdaptation_y(30));
        make.left.equalTo(self.curv);
        make.height.mas_equalTo(LAdaptation_y(24));
    }];

//    [self.view addSubview:self.selectView];
//    [self.selectView mas_makeCons traints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(LAdaptation_y(24));
//        make.left.equalTo(self.subtitleLabel);
//        make.width.equalTo(self.view);
//        make.height.mas_equalTo(LAdaptation_y(44));
//    }];
    
    [self.view addSubview:self.currentView];
    [self.currentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subtitleLabel.mas_bottom);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(LAdaptation_y(210));
    }];
    
    [self.view addSubview:self.asstSubtitleLabel];
    [self.asstSubtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.currentView.mas_bottom);
        make.left.equalTo(self.subtitleLabel);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(LAdaptation_y(24));
    }];
    
    
    
}


#pragma mark - UICollectionViewDataSource -
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 1) {
        return 5;
    }else{
        return 5;
    }
    return 0;

}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView.tag == 1) {
        static NSString *cellId = @"AssistantCell";
        SCAssistantCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
        
        [cell setupCellWithModel:nil];
        return cell;
    }else{
        
        
    }

    return nil;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    CGFloat itemW;
//    CGFloat itemH;
//    self.flowLayout.minimumInteritemSpacing = LAdaptation_x(20);
//    self.flowLayout.minimumLineSpacing = LAdaptation_y(20);
//
//    // 设置item的大小
//    itemW = LAdaptation_x(220);
//    itemH = LAdaptation_y(165);
//
//    // 设置每个分区的 上左下右 的内边距
//    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0 ,0, 0);
//    self.flowLayout.itemSize = CGSizeMake(itemW, itemH);
//    [self.collectionView registerClass:[SCPaperCell class] forCellWithReuseIdentifier:@"PaperCell"];
}

#pragma mark - LazyLoad -
- (SelectWhiteBGBar *)whiteBar
{
    if (!_whiteBar) {
        _whiteBar = [[SelectWhiteBGBar alloc] initWithItemArray:@[@"试卷",@"教辅"]];
        _whiteBar.backgroundColor = [UIColor clearColor];
    }
    return _whiteBar;
}
- (SCureView *)curv
{
    if (!_curv) {
        _curv = [[SCureView alloc] init];
    }
    return _curv;
}
- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont boldSystemFontOfSize:24.0];
        _subtitleLabel.text = @"最近学习";
    }
    return _subtitleLabel;
}
- (UILabel *)asstSubtitleLabel
{
    if (!_asstSubtitleLabel) {
        _asstSubtitleLabel = [[UILabel alloc] init];
        _asstSubtitleLabel.font = [UIFont boldSystemFontOfSize:24.0];
        _asstSubtitleLabel.text = @"教辅列表";
    }
    return _asstSubtitleLabel;
}
    
    
- (SelectSubView *)selectView
{
    if (!_selectView) {
        NSMutableArray *subArray = [[NSMutableArray alloc] init];
        NSArray *array = @[@"数学",@"物理",@"化学"];
        
        for (NSInteger i = 0; i < array.count; i++) {
            SubModel *model = [[SubModel alloc] init];
            model.subId = [NSString stringWithFormat:@"%ld",i];
            model.subName = [array safeObjectAtIndex:i];
            [subArray addObject:model];
        }
        self.subArray = subArray;
        _selectView = [[SelectSubView alloc] initWithItemArray:subArray];
    }
    return _selectView;
}
- (UICollectionView *)currentView
{
    if (!_currentView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        CGFloat itemW;
        CGFloat itemH;
        
        flowLayout.minimumInteritemSpacing = LAdaptation_x(20);
        flowLayout.minimumLineSpacing = LAdaptation_y(53);

        // 设置item的大小
        itemW = LAdaptation_x(348);
        itemH = LAdaptation_y(194);
        
        // 设置每个分区的 上左下右 的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0 ,0, 0);
        flowLayout.itemSize = CGSizeMake(itemW, itemH);
        
        _currentView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _currentView.backgroundColor = [UIColor clearColor];
        _currentView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
        _currentView.scrollEnabled = YES;  //滚动使能
        _currentView.delegate = self;
        _currentView.dataSource = self;
        _currentView.tag = 1;
        
        [_currentView registerClass:[SCAssistantCell class] forCellWithReuseIdentifier:@"AssistantCell"];
    }
    return _currentView;
}
- (UICollectionView *)asstView
{
    if (!_asstView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

        CGFloat itemW;
        CGFloat itemH;
        
        flowLayout.minimumInteritemSpacing = LAdaptation_x(20);
        flowLayout.minimumLineSpacing = LAdaptation_y(53);

        // 设置item的大小
        itemW = LAdaptation_x(280);
        itemH = LAdaptation_y(360);
        
        // 设置每个分区的 上左下右 的内边距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0 ,0, 0);
        flowLayout.itemSize = CGSizeMake(itemW, itemH);
        
        _asstView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _asstView.backgroundColor = [UIColor clearColor];
        _asstView.showsVerticalScrollIndicator = NO;   //是否显示滚动条
        _asstView.scrollEnabled = YES;  //滚动使能
        _asstView.delegate = self;
        _asstView.dataSource = self;
        _asstView.tag = 2;
        [_asstView registerClass:[SCPaperCell class] forCellWithReuseIdentifier:@"SCPaperCell"];
    }
    return _asstView;
}


- (AAChartModel *)configureColorfulGradientSplineChart {
    NSArray *stopsArr = @[
        @[@0.00, @"#febc0f"],//颜色字符串设置支持十六进制类型和 rgba 类型
        @[@0.25, @"#FF14d4"],
        @[@0.50, @"#0bf8f5"],
        @[@0.75, @"#F33c52"],
        @[@1.00, @"#1904dd"],
    ];

    NSDictionary *gradientColorDic1 =
    [AAGradientColor gradientColorWithDirection:AALinearGradientDirectionToTop
                                     stopsArray:stopsArr];

    return AAChartModel.new
    .chartTypeSet(AAChartTypeSpline)
    .categoriesSet(@[
        @"一月", @"二月", @"三月", @"四月", @"五月", @"六月",
        @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月"
                   ])
    .markerRadiusSet(@0)
    .yAxisLineWidthSet(@0)
    .legendEnabledSet(false)
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Tokyo Hot")
        .lineWidthSet(@6)
        .colorSet((id)gradientColorDic1)
        .dataSet(@[@7.0, @6.9, @2.5, @14.5, @18.2, @21.5, @5.2, @26.5, @23.3, @45.3, @13.9, @9.6]),
               ]);
}
- (AAChartModel *)configureColorfulColumnChart {
    return AAChartModel.new
    .chartTypeSet(AAChartTypeColumn)
    .titleSet(@"Colorful Column Chart")
    .subtitleSet(@"single data array colorful column chart")
    .colorsThemeSet([self configureTheRandomColorArrayWithColorNumber:14])
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"ElementOne")
        .dataSet(@[@211, @183, @157, @133, @111, @91, @73, @57, @43, @31, @21, @13, @7, @3])
        .colorByPointSet(@true),//When using automatic point colors pulled from the options.colors collection, this option determines whether the chart should receive one color per series or one color per point. Default Value：false.
               ]);
}
- (NSArray *)configureTheRandomColorArrayWithColorNumber:(NSInteger)colorNumber {
    NSMutableArray *colorStringArr = [[NSMutableArray alloc]init];
    for (unsigned int i=0; i < colorNumber; i++) {
        unsigned int R = (arc4random() % 256) ;
        unsigned int G = (arc4random() % 256) ;
        unsigned int B = (arc4random() % 256) ;
        NSString *colorStr = [NSString stringWithFormat:@"rgba(%d,%d,%d,0.9)",R,G,B];
        [colorStringArr addObject:colorStr];
    }
    return colorStringArr;
}
@end
