//
//  SAWKViewController.h
//  SAPro
//
//  Created by 马腾 on 2019/8/28.
//  Copyright © 2019 beiwaionline. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^agreeBlock)(void);
typedef void(^disAgreeBlock)(void);

@interface PrivacyPageController : UIViewController
@property (nonatomic, copy)agreeBlock agress;
@property (nonatomic, copy)disAgreeBlock disagree;

- (void)loadPrivacyHtmlWithAppName:(NSString *)appName andHtml:(NSString *)html isHiddenBottomView:(BOOL)isHidden;
- (void)createLeftBackBtnWithImageName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
