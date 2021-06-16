//
//  SMoreSelectView.h
//  Student
//
//  Created by 马腾 on 2021/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^clickMoreSelectBlock)(NSString *name);

@interface SMoreSelectView : UIView
@property (nonatomic, copy) clickMoreSelectBlock selectBlock;

- (instancetype)initWithFrame:(CGRect)frame WithArray:(NSArray *)contentArray;
@end

NS_ASSUME_NONNULL_END
