//
//  SCureView.m
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import "SCureView.h"

@interface SCureView()

@end

@implementation SCureView

- (instancetype)init
{
    if (self = [super init]) {
        
        [self addSubview:self.chartView];
        [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self);
            make.right.equalTo(self.mas_right);
            make.bottom.equalTo(self.mas_bottom).offset(-LAdaptation_y(15));
        }];
        
    }
    return self;
}


#pragma mark - LazyLoad -

- (AAChartView *)chartView
{
    if (!_chartView) {
        _chartView = [[AAChartView alloc] init];
    }
    return _chartView;
}

@end
