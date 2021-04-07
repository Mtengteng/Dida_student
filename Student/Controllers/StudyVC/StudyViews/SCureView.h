//
//  SCureView.h
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import <UIKit/UIKit.h>
#import "AAChartKit.h"

NS_ASSUME_NONNULL_BEGIN

@interface SCureView : UIView
@property (nonatomic, strong) AAChartView *chartView;

- (instancetype)initWithTitle:(NSString *)title
                withItemArray:(NSArray *)itemArray;
@end

NS_ASSUME_NONNULL_END
