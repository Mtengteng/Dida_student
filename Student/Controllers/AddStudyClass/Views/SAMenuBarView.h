//
//  SAMenuBarView.h
//  Student
//
//  Created by 马腾 on 2021/7/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^backActionBlock)(void);
typedef void(^saveActionBlock)(void);

@interface SAMenuBarView : UIView
@property (nonatomic, copy) backActionBlock backBlock;
@property (nonatomic, copy) saveActionBlock saveBlock;

- (instancetype)init;
@end

NS_ASSUME_NONNULL_END
