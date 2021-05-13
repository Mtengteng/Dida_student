//
//  SMenuView.h
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import <UIKit/UIKit.h>
//下拉框view
NS_ASSUME_NONNULL_BEGIN

@class SCDictInfoModel;
typedef void(^selectBlock)(SCDictInfoModel *selectItem);

@interface SMenuView : UIView
@property (nonatomic, copy) selectBlock select;

- (id)initContentArray:(NSArray *)dataArray
        withSuperView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
