//
//  ItemTabView.h
//  Student
//
//  Created by 马腾 on 2021/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum _ButtonContentAlignment
{
    ButtonContentAlignment_Center = 0,
    ButtonContentAlignment_Left = 1
}ButtonContentAlignment;

typedef void(^selectIndexBlock)(NSInteger index);

@interface ItemTabView : UIView
@property (nonatomic, copy) selectIndexBlock selectBlock;

- (instancetype)initWithItemArray:(NSArray *)itemList
                     withFontSize:(NSInteger)fontSize
                withEachItemWidth:(CGFloat)width
                 contentAlignment:(ButtonContentAlignment)alignment;


@end

NS_ASSUME_NONNULL_END
