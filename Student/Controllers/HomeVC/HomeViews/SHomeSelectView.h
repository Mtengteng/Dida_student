//
//  SHomeSelectView.h
//  Student
//
//  Created by 马腾 on 2021/4/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^selectIndexBlock)(NSInteger index);

@interface SHomeSelectView : UIView
@property (nonatomic, copy) selectIndexBlock selectBlock;

- (instancetype)initWithItemArray:(NSArray *)itemList;

@end

NS_ASSUME_NONNULL_END
