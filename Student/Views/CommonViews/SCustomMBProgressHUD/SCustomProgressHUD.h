//
//  SCustomProgressHUD.h
//  smartCourse
//
//  Created by 马腾 on 2021/3/4.
//  Copyright © 2021 beiwaionline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCustomProgressHUD : UIView

+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (void)hideHUDForView:(UIView *)view animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
