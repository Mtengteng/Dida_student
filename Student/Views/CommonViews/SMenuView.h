//
//  SMenuView.h
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SMenuItem;
typedef void(^selectBlock)(SMenuItem *selectItem);

@interface SMenuView : UIView
@property (nonatomic, copy) selectBlock select;

- (id)initContentArray:(NSArray *)dataArray
        withSuperView:(UIView *)superView;

@end

NS_ASSUME_NONNULL_END
