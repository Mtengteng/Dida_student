//
//  SBoxInfoScrollView.h
//  Student
//
//  Created by 马腾 on 2021/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SBoxGroup;

typedef void(^clickActionBlock)(SBoxGroup *group);

@interface SBoxInfoScrollView : UIView
@property (nonatomic, copy) clickActionBlock clickBlock;

- (instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)contentArray;
@end

NS_ASSUME_NONNULL_END
