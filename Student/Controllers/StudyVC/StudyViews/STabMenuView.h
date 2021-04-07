//
//  STabMenuView.h
//  Student
//
//  Created by 马腾 on 2021/4/7.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^selectIndexBlock)(NSString *titleName);

@interface STabMenuView : UIView
@property (nonatomic, copy) selectIndexBlock selectBlock;
- (id)initWithTitle:(NSArray *)titleArray;
@end

NS_ASSUME_NONNULL_END
