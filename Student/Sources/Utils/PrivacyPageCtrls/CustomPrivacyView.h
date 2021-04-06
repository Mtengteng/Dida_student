//
//  CustomPrivacyView.h
//  webViewSearch
//
//  Created by 马腾 on 2019/9/4.
//  Copyright © 2019 mateng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^clickBlock)(NSInteger tag);

@interface CustomPrivacyView : UIView
@property (nonatomic, copy)clickBlock clickAction;
@property (nonatomic, assign)BOOL selectState;

- (instancetype)init;

@end

NS_ASSUME_NONNULL_END
