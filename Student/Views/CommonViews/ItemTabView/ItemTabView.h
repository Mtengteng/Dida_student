//
//  ItemTabView.h
//  Student
//
//  Created by 马腾 on 2021/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^selectIndexBlock)(NSInteger index);

@interface ItemTabView : UIView
@property (nonatomic, copy) selectIndexBlock selectBlock;
- (instancetype)initWithItemArray:(NSArray *)itemList withFontSize:(NSInteger)fontSize;


@end

NS_ASSUME_NONNULL_END
