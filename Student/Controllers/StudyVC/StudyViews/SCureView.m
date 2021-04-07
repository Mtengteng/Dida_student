//
//  SCureView.m
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import "SCureView.h"

@interface SCureView()
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) NSArray *itemArray;
@property (nonatomic, strong) UIView *selectBarView;
@property (nonatomic, strong) UIView *whiteView;

@end

@implementation SCureView

- (instancetype)initWithTitle:(NSString *)title
                withItemArray:(NSArray *)itemArray
{
    if (self = [super init]) {
        
        self.itemArray = itemArray;
        
        [self addSubview:self.subtitleLabel];
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(LAdaptation_y(5));
            make.left.equalTo(self).offset(LAdaptation_x(10));
        }];
        
        [self addSubview:self.chartView];
        [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subtitleLabel.mas_bottom).offset(LAdaptation_y(10));
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom).offset(-LAdaptation_y(15));
        }];
        
        [self addSubview:self.selectBarView];
        [_selectBarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.subtitleLabel);
            make.right.equalTo(self.chartView.mas_right);
            make.width.mas_equalTo(LAdaptation_x(50)*self.itemArray.count);
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
        
        [self.chartView aa_drawChartWithChartModel:[self configureColorfulGradientSplineChart]];

    }
    return self;
}

- (void)clickAction:(UIButton *)button
{
    NSLog(@"curveIndex = %ld",button.tag);
    
    for (UIView *contentView in self.selectBarView.subviews) {
        if ([contentView isKindOfClass:[UIButton class]]) {
            UIButton *tempBtn = (UIButton *)contentView;
            if (tempBtn.tag == button.tag) {
                [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
                DefineWeakSelf;
                [UIView animateWithDuration:0.25 animations:^{
                    [weakSelf.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.equalTo(weakSelf.selectBarView);
                        make.left.mas_equalTo(button.tag*LAdaptation_x(50));
                        make.width.mas_equalTo(LAdaptation_x(50));
                        make.height.mas_equalTo(LAdaptation_y(30));
                    }];
                    
                    [weakSelf.superview layoutIfNeeded];
                }];

            }else{
                [tempBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            
            

        }
    }
}
#pragma mark - LazyLoad -
- (UILabel *)subtitleLabel
{
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont boldSystemFontOfSize:20.0];
        _subtitleLabel.text = @"测试成绩";
    }
    return _subtitleLabel;
}
- (UIView *)selectBarView
{
    if (!_selectBarView) {
        _selectBarView = [[UIView alloc] init];
        _selectBarView.backgroundColor = [UIColor lightGrayColor];

        for (NSInteger i = 0; i < self.itemArray.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.tag = i;
            if (i == 0) {
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            }
            [button setTitle:[self.itemArray safeObjectAtIndex:i] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
            [_selectBarView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_selectBarView);
                make.left.mas_equalTo(i*LAdaptation_x(50));
                make.width.mas_equalTo(LAdaptation_x(50));
                make.height.mas_equalTo(LAdaptation_y(30));
            }];
        }
        
        [_selectBarView addSubview:self.whiteView];
        [_selectBarView sendSubviewToBack:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_selectBarView);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(LAdaptation_x(50));
            make.height.mas_equalTo(LAdaptation_y(30));
        }];
    }

    
    return _selectBarView;
}
- (UIView *)whiteView
{
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
- (AAChartView *)chartView
{
    if (!_chartView) {
        _chartView = [[AAChartView alloc] init];
    }
    return _chartView;
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
    [AAGradientColor gradientColorWithDirection:AALinearGradientDirectionToRight
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
@end
