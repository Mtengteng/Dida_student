//
//  SBaseVC.h
//  Student
//
//  Created by mateng on 2021/1/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBaseVC : UIViewController

- (void)createUI;

- (void)createLeftBackBtn:(void(^)(void))backBlock;
@end

NS_ASSUME_NONNULL_END
